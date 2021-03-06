#include "ros/ros.h"
#include "xm_speech/xm_Speech.h"

#include "qisr.h"
#include "msp_cmn.h"
#include "msp_errors.h"
#include "msp_types.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#define SAMPLE_RATE_16K     (16000)
#define ASR_THRESHOLD       (8)
#define ASR_DENOISE	    	(1)
#define SAMPLE_RATE_8K      (8000)
#define MAX_GRAMMARID_LEN   (32)
#define MAX_PARAMS_LEN      (1024)
#define MAXBUFSIZE          1024

using namespace std;

typedef struct _UserData {
	int     build_fini;
	int     update_fini;
	int     errcode;
	char    grammar_id[MAX_GRAMMARID_LEN];
}UserData;
UserData asr_data;  //全局变量


//* MSPLogin函数将会初始化msc，在当前工作路径创建msc文件夹（如果不存在）
//* 故在运行程序前，确保存在msc文件，并将res文件和自己的语法文件放到msc文件里面
//* 否则会报错！！！
//* 下面路径请参见doc里面相关函数说明

const char * ASR_RES_PATH        = "fo|res/asr/common.jet"; //离线语法识别资源路径
const char * GRM_BUILD_PATH      = "res/asr/GrmBuilld";    //构建离线语法识别网络生成数据保存路径
const char * GRM_FILE            = "msc/speech.bnf";         //构建离线识别语法网络所用的语法文件

int build_grammar(UserData *udata); //构建离线识别语法网络
int run_asr(UserData *udata);       //进行离线语法识别

int build_grm_cb(int ecode, const char *info, void *udata)
{
	UserData *grm_data = (UserData *)udata;

	if (NULL != grm_data) {
		grm_data->build_fini = 1;
		grm_data->errcode = ecode;
	}
        
	if (MSP_SUCCESS == ecode && NULL != info) {
		printf("构建语法成功！ 语法ID:%s\n", info);
		if (NULL != grm_data)
			snprintf(grm_data->grammar_id, MAX_GRAMMARID_LEN - 1, info);
	}
	else
		printf("构建语法失败！%d\n", ecode);

	return 0;
}

int build_grammar(UserData *udata)
{
	FILE *grm_file                           = NULL;
	char *grm_content                        = NULL;
	unsigned int grm_cnt_len                 = 0;
	char grm_build_params[MAX_PARAMS_LEN]    = {NULL};
	int ret                                  = 0;

	grm_file = fopen(GRM_FILE, "rb");
	if(NULL == grm_file) {
		printf("打开\"%s\"文件失败！[%s]\n", GRM_FILE, strerror(errno));
		return -1;
	}

	fseek(grm_file, 0, SEEK_END);
	grm_cnt_len = ftell(grm_file);
	fseek(grm_file, 0, SEEK_SET);

	grm_content = (char *)malloc(grm_cnt_len + 1);
	if (NULL == grm_content)
	{
		printf("内存分配失败!\n");
		fclose(grm_file);
		grm_file = NULL;
		return -1;
	}
	fread((void*)grm_content, 1, grm_cnt_len, grm_file);
	grm_content[grm_cnt_len] = '\0';
	fclose(grm_file);
	grm_file = NULL;

	snprintf(grm_build_params, MAX_PARAMS_LEN - 1,
		"engine_type = local, \
		asr_res_path = %s, sample_rate = %d, \
		grm_build_path = %s, ",
		ASR_RES_PATH,
		SAMPLE_RATE_16K,
		GRM_BUILD_PATH
		);
	ret = QISRBuildGrammar("bnf", grm_content, grm_cnt_len, grm_build_params, build_grm_cb, udata);

	free(grm_content);
	grm_content = NULL;

	return ret;
}


bool run_asr(xm_speech::xm_Speech::Request &req,xm_speech::xm_Speech::Response &res)
{
    	char asr_params[MAX_PARAMS_LEN]         = {NULL};
    	const char *rec_rslt                    = NULL;
    	const char *session_id                  = NULL;
    	char *pcm_data                          = NULL;
    	long pcm_count                          = 0;
    	long pcm_size                           = 0;
    	int last_audio                          = 0;
    	int aud_stat                            = MSP_AUDIO_SAMPLE_CONTINUE;
    	int ep_status                           = MSP_EP_LOOKING_FOR_SPEECH;
    	int rec_status                          = MSP_REC_STATUS_INCOMPLETE;
    	int rss_status                          = MSP_REC_STATUS_INCOMPLETE;
        int errcode                             = -1;

        std::string audio_str=req.audio_data;
        pcm_size=audio_str.length();
        printf("pcm_size : %d\n",pcm_size);
        pcm_data=(char *)audio_str.c_str();

        if(NULL==pcm_data){
            printf("pcm_data error ！！\n");
            QISRSessionEnd(session_id, NULL);
            return true;
        }
	    //离线语法识别参数设置
	    UserData *udata=&asr_data;
	    snprintf(asr_params, MAX_PARAMS_LEN - 1,
		    "engine_type = local, \
		    language = en_us, \
	    	result_type = plain, \
		    asr_res_path = %s, sample_rate = %d, \
		    asr_threshold = %d, asr_denoise = %d, \
		    grm_build_path = %s, local_grammar = %s, \
		    result_encoding = UTF-8, ",
		    ASR_RES_PATH,
		    SAMPLE_RATE_16K,
		    ASR_THRESHOLD,
		    ASR_DENOISE,
		    GRM_BUILD_PATH,
		    udata->grammar_id
		);
	    session_id = QISRSessionBegin(NULL, asr_params, &errcode);
	    if (NULL == session_id){
	    	pcm_data = NULL;
	    	QISRSessionEnd(session_id, NULL);
	    	return true;
	    }
        printf("开始识别...\n");
	    while (1) {
		    unsigned int len = 6400;

		    if (pcm_size < 12800) {
			    len = pcm_size;
			    last_audio = 1;
		    }

		    aud_stat = MSP_AUDIO_SAMPLE_CONTINUE;

		    if (0 == pcm_count)
			    aud_stat = MSP_AUDIO_SAMPLE_FIRST;
            
		    if (len <= 0){
				printf("len <= 0\n");
			    break;
            }
		    errcode = QISRAudioWrite(session_id, (const void *)&pcm_data[pcm_count],
                                        len, aud_stat, &ep_status, &rec_status);
		    if (MSP_SUCCESS != errcode){
				//printf("MSP_SUCCESS != errcode\n");
				printf("%d\n",errcode);
			    goto run_error;
		    }

		    pcm_count += (long)len;
		    pcm_size -= (long)len;

		    //检测到音频结束
		    if (MSP_EP_AFTER_SPEECH == ep_status){
			    printf("MSP_EP_AFTER_SPEECH == ep_status\n");
			    break;
	        }
		    usleep(150 * 1000); //模拟人说话时间间隙
	    }

        //主动点击音频结束
	    QISRAudioWrite(session_id, (const void *)NULL, 0, MSP_AUDIO_SAMPLE_LAST, &ep_status, &rec_status);

	    pcm_data = NULL;  ///
        //获取识别结果
	    while (MSP_REC_STATUS_COMPLETE != rss_status && MSP_SUCCESS == errcode) {
			rec_rslt = QISRGetResult(session_id, &rss_status, 0, &errcode);
		    usleep(150 * 1000);
	    }
        printf("\n识别结束：");
	    if (NULL != rec_rslt){
			printf(rec_rslt);
			char question[100];
			char input[50];
			strcpy(question,rec_rslt);
			int len=strlen(rec_rslt);
            int confidence_num=1;
			int confidence=0;
			if( question[12] != ' ' ){
				confidence_num++;
				}
			if( confidence_num ==1 ){
				confidence=question[11]-'0';
			}
			else if( confidence_num == 2 ){ 
				confidence=question[11]-'0';
				confidence*=10;
				confidence+=question[12]-'0';
			}
			printf("\n%d\n",confidence);
			int i=26;
			int j=0;		
			for(;i<=len;i++){
				if( question[28] == '=' && i>28 ){
					input[j]=question[i];
					j++;
				}
                else if( question[29]== '=' && i>29 ){
					input[j]=question[i];
				    j++;
			    }
			}
			if( question[28] == '=' ){
				i=29;
		    }
            else if( question[29]== '=' ){
			    i=30;
		    }
		    printf("\n%s\n",input);
	        //strncpy(res.sr_text,input,len-i+1);
		    string input1;
		    string question1;
		    for(int j=0;j<len-i+1;j++){
				input1+=input[j];
		    }
		    for(int j=0;j<len;j++){
				question1+=question[j];
		    }
		    cout << input1 << endl;
		    //res.sr_text = input1;
		    res.sr_text = question1.substr(i,len);
		    cout << res.sr_text << endl;
	    }
	    else{
	        printf("没有识别结果！\n");
	        res.sr_text = "";
	    }
	    goto run_exit;

    run_error:
	    if (NULL != pcm_data) {
		    pcm_data = NULL;
	    }
    run_exit:
	    QISRSessionEnd(session_id, NULL);
        return true;
}

int main(int argc, char **argv)
{
    const char *login_config     = "appid = 5b696e49"; //登录参数
	int ret                      = 0 ;
	char c;
	ret = MSPLogin(NULL, NULL, login_config); //第一个参数为用户名，第二个参数为密码，传NULL即可，第三个参数是登录参数
	if (MSP_SUCCESS != ret) {
	    printf("登录失败：%d\n", ret);
	    MSPLogout();
	    printf("请按任意键退出...\n");
	    getchar();
	    return 0;
	}

    //第一次使用某语法进行识别，需要先构建语法网络，获取语法ID，之后使用此语法进行识别，无需再次构建
      
	memset(&asr_data, 0, sizeof(UserData));
	printf("构建离线识别语法网络...\n");
	ret = build_grammar(&asr_data);
	if (MSP_SUCCESS != ret) {
		printf("构建语法调用失败！\n");
	    MSPLogout();
	    printf("请按任意键退出...\n");
	    getchar();
	    return 0;
	}
	while (1 != asr_data.build_fini)
		usleep(300 * 1000);
	if (MSP_SUCCESS != asr_data.errcode){
            MSPLogout();
	    printf("请按任意键退出...\n");
	    getchar();
	    return 0;
	}
	printf("离线识别语法网络构建完成\n");

    //###############################################################

    ros::init(argc, argv, "xm_speech_server");
    ros::NodeHandle n;
    ros::ServiceServer service = n.advertiseService("xm_speech", run_asr);
    ros::spin();
    return 0;
}
