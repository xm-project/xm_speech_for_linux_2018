#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 19 09:37:01 2017

@author: fanfan

This project is to build an interesting chatting robot and aims to serve intelligent home
"""

import sys
import time
import math
import json
import collections
import audioop
import pyaudio
import requests
import random
import rospy
import threading
from std_msgs.msg import String
from xm_speech.srv import *
from ctypes import *
from speech_recognition import *

import nltk
import os
import sys

from nltk import CFG
from nltk.parse import RecursiveDescentParser

import subprocess
import time


sys.path.append('.')
msc = cdll.LoadLibrary("/home/tornado/xm_speech_for_linux/src/xm_speech/lib/libmsc.so") # change   根据lib中libmsc.so文件的绝对路径来改变
libc = cdll.LoadLibrary('libc.so.6')  # Load standard C library on Linux

xm_speech_req = xm_Speech_meaningRequest()
xm_speech_res = xm_Speech_meaningResponse()

text_last = ''
pause = 0
#---------------------------------------------
SAMPLE_RATE_16K    =   16000
ASR_THRESHOLD      =   8
ASR_DENOISE	       =   1
SAMPLE_RATE_8K     =   8000
MAX_GRAMMARID_LEN  =   32
MAX_PARAMS_LEN     =   1024
MAXBUFSIZE         =   1024

ASR_RES_PATH     = c_char_p("fo|res/asr/common.jet")    #离线语法识别资源路径
GRM_BUILD_PATH   = c_char_p("res/asr/GrmBuilld")        #构建离线语法识别网络生成数据保存路径
GRM_FILE         = c_char_p("msc/speech.bnf")           #构建离线识别语法网络所用的语法文件

class _UserData(Structure):
    _fields_ = [('build_fini'                    ,  c_int), 
                ('update_fini'                   ,  c_int),
                ('errcode'                       ,  c_int),
                ('grammar_id[MAX_GRAMMARID_LEN]' ,  c_char)]
asr_data = _UserData

ecode = c_int
info  = c_char_p
udata = c_void_p

#fseek
#SEEK_SET = 0
#SEEK_END = 2

#-----------------ERROR CODES-----------------

MSP_SUCCESS = 0

# End-point detected
MSP_EP_LOOKING_FOR_SPEECH = 0
MSP_EP_IN_SPEECH = 1
MSP_EP_AFTER_SPEECH = 3
MSP_EP_TIMEOUT = 4
MSP_EP_ERROR = 5
MSP_EP_MAX_SPEECH = 6

# Audio Status
MSP_AUDIO_SAMPLE_FIRST = 1
MSP_AUDIO_SAMPLE_CONTINUE = 2
MSP_AUDIO_SAMPLE_LAST = 4

# Recognition Status
MSP_REC_STATUS_SUCCESS = 0
MSP_REC_STATUS_NO_MATCH = 1
MSP_REC_STATUS_INCOMPLETE = 2
MSP_REC_STATUS_COMPLETE = 5

# -----------------------------------------------------------------------------
# From alsa-lib Git 3fd4ab9be0db7c7430ebd258f2717a976381715d
# $ grep -rn snd_lib_error_handler_t
# include/error.h:59:typedef void (*snd_lib_error_handler_t)(const char *file, int line, const char *function, int err, const char *fmt, ...) /* __attribute__ ((format (printf, 5, 6))) */;

# Define our error handler type
ERROR_HANDLER_FUNC = CFUNCTYPE(None, c_char_p, c_int, c_char_p, c_int, c_char_p)

def py_error_handler(filename, line, function, err, fmt):
    pass

c_error_handler = ERROR_HANDLER_FUNC(py_error_handler)

asound = cdll.LoadLibrary('libasound.so.2')

# Set error handler
asound.snd_lib_error_set_handler(c_error_handler)

# -----------------------------------------------------------------------------
'''
def build_grm_cb(ecode, info, asr_data):
    if( None != asr_data ):
        asr_data.build_fini = 1
        asr_data.errcode    = ecode
    
    if( MSP_REC_STATUS_SUCCESS == ecode and None != info ):
        libc.printf("构建语法成功！ 语法ID：%s\n",info)
        if( None != asr_data):
            libc.snprintf(asr_data.grammar_id,MAX_GRAMMARID_LEN-1, info)
    else:
        libc.printf("构建语法失败！%d\n", ecode)
    
    return 0

def build_grammar(asr_data):
    #grm_file                         = c_char_p(None)
    grm_content                      = c_char_p(None)
    grm_cnt_len                      = c_uint(0)
    #grm_build_params                 = MAX_PARAMS_LEN *c_byte
    ret                              = c_int(0)
    
    print("grm_file")
    #grm_file = libc.fopen(GRM_FILE.value,"rb")
    grm_file = open(GRM_FILE.value,'rb')
    print(grm_file)
    if( None == grm_file ):
        libc.printf("打开\"%s\"文件失败！[%s]\n", GRM_FILE, libc.strerror(errno));
        return -1;

    print("fseek")
    grm_file.seek(0, 2)#SEEK_END 2
    print("grm_cnt_len")
    grm_cnt_len = grm_file.tell()
    grm_file.seek(0, 0)#SEEK_SET 0

    print("grm_content")

    
    grm_content.value = libc.malloc(c_char_p)(grm_cnt_len.value + 1)
    print("malloc")    
    if( None == grm_content.value ):
        print("内存分配失败！")
        libc.fclose(grm_file)
        grm_file = None
        return -1
    
    
    grm_content = grm_file.read(grm_cnt_len)
    #grm_content[grm_cnt_len] = '\0'
    grm_file.close()
    grm_file = None
    print("sn")
    grm_build_params = b"engine_type = local, asr_res_path = fo|res/asr/common.jet, sample_rate = 16000, grm_build_path = 'res/asr/GrmBuilld' "

    print("msc")
    ret = msc.QISRBuildGrammar("bnf", grm_content, grm_cnt_len, grm_build_params, None, None);#build_grm_cb,asr_data

    del grm_content
    #grm_content.collect()
    #libc.free(grm_content.value)
    #grm_content.value = None

    return ret
'''
# -----------------------------------------------------------------------------

#建立的文法满足比赛要求即可
#2016/1

# 处理1/2/3个短句
# 句式特点：命令句式
# V NP:find object/person;talk something;grasp object;follow person
# V NP PP:deliver it to ;find sb/obj in;
# V NP NP:ask sb question
# V PP(V P NP):go to bedroom
# S句子,V动词,P介词,VP动词词组,PP介宾,NP名词词组,NOM名次性词

#构建语法树    
grammar=CFG.fromstring("""
S ->Mission1|Mission1 Mission2|Mission1 Mission2 Mission3

Mission1 ->Val VP
Mission2 ->Val VP
Mission3 ->Val VP

VP ->V NP|V NP PP|V PP|V NP NP|V PP PP|V NP NP PP
NP ->Det Nom|PropN
Nom ->Adj N|N
PP ->P NP

Val ->"and"|"then"|
Det ->"a"|"an"|"the"|"your"|"my"|
PropN ->"her"|"him"|"me"|"it"
P ->To|In|For|Of
Adj ->"waving"

N ->Location|Object|Topic|Person
V ->Find|Go|Deliver|Talk|Follow|Grasp|Remember|Stop


Location ->"kitchen"|"diningroom"|"bedroom"|"livingroom"|"here"
Object ->"cola"|"milk"|"noodles"|"cake"|"chips"|"biscuit"|"toothpaste"|"rollpaper"|"water"|"coffee"|"soap"
Person ->"person"|"me"|"her"|"Tom"|"Paul"|"Green"|"Kevin"|"Tracy"|"John"|"Angel"|"Fisher"|"Jamie"|"Daniel"|"Robin"|"Shirley"
Topic ->Time|Date|Name|Day|Question
Time ->"time"|"what time is it"
Date ->"date"|"today"|"tomorrow"
Name ->"name"|"team"
Day ->"day"|"week"|"month"|"whatdayistoday"
Question ->"question"


Find ->"find"|"look"|"search"
Go ->"go"|"navigate"|"reach"|"go back"
Deliver ->"deliver"|"bring"|"carry"
Talk ->"tell"|"say"|"speak"|"ask"|"answer"
Follow ->"follow"
Grasp ->"grasp"|"get"|"take"|"put"
Remember ->"remember"

To ->"to"|"into"|"back"
In ->"in"|"from"|"on"|"at"
Of ->"of"
For ->"for"

""")

def search(tree):
    global xm_speech_res
    if tree.label()=="S":
        if len(tree)==1:
            tr=tree[0]
            search(tr)
            
        elif len(tree)==2:
            tr=tree[0]
            search(tr)
            tr=tree[1]
            search(tr)
            
        elif len(tree)==3:
            tr=tree[0]
            search(tr)
            tr=tree[1]
            search(tr)
            tr=tree[2]
            search(tr)
#	    
    if tree.label()=="Mission1"or tree.label()=="Mission2" or tree.label()=="Mission3":
        if len(tree)==2:
            tr=tree[1]
            search(tr)
#	    
    if tree.label()=="VP":
        if len(tree)==2:
            if tree[0].label()=="V" and tree[1].label()=="NP":
                tr=tree[0]
                search(tr)
                tr=tree[1]
                search(tr)
                
            if tree[0].label()=="V" and tree[1].label()=="PP":
                tr=tree[0]
                search(tr)
                tr=tree[1]
                search(tr)
        
        elif len(tree)==3:
            if tree[0].label()=="V" and tree[1].label()=="NP" and tree[2].label()=="PP":
                if len(tree[2])>0:             #先分析介词短语
                    if tree[2][0].label()=="P":
                        if len(tree[2][0])>0:
                            if tree[2][0][0].label()=="To":  #
                                tr=tree[0]
                                search(tr)
                                tr=tree[1]
                                search(tr)
                                print("go ")
                                tr=tree[2]
                                search(tr)
                            elif tree[2][0][0].label()=="In":  #
                                print("go ")
                                xm_speech_res.action.insert(0,'go')
                                xm_speech_res.num+=1
                                tr=tree[2]
                                search(tr)
                                tr=tree[0]
                                search(tr)
                                tr=tree[1]
                                search(tr)
                            else :              #exp：tell the date of today;
                                tr=tree[0]      #形式为talk topic;忽略修饰
                                search(tr)
                                tr=tree[1]
                                search(tr)        
                                 
                                                  
            elif tree[0].label()=="V" and tree[1].label()=="NP" and tree[2].label()=="NP": #
                tr=tree[0]
                search(tr)
                tr=tree[2]
                search(tr)

            elif tree[0].label()=="V" and tree[1].label()=="PP" and tree[2].label()=="PP":
                if len(tree[2])>0:
                    if tree[2][0].label()=="P":
                        if len(tree[2][0])>0:
                            if tree[2][0][0].label()=="In":
                                print("go ")
                                xm_speech_res.action.insert(0,'go')
                                xm_speech_res.num+=1
                                tr=tree[2]
                                search(tr)
                                tr=tree[0]
                                search(tr)
                                tr=tree[1]
                                search(tr)
        
        elif len(tree) == 4:
            tr = tree[0]
            search(tr)
            tr = tree[1]
            search(tr)                    
            tr = tree[2]
            search(tr)
            tr = tree[3]
            search(tr) 
                

    if tree.label()=="NP":
        if len(tree)==1:
            tr=tree[0]
            search(tr)
        elif len(tree)==2:
            tr=tree[1]
            search(tr)
                		
    if tree.label()=="PP":
        if len(tree)==2:
            tr=tree[1]
            search(tr)
                                
    if tree.label()=="V":
        if len(tree)>0:
            if tree[0].label()=="Find":
                xm_speech_res.action.append('find')
                xm_speech_res.num += 1
                print("find")
            if tree[0].label()=="Go":
                xm_speech_res.action.append('go')
                xm_speech_res.num += 1
                print("go")
            if tree[0].label()=="Deliver":
                print( tree[0] )
                #if str(tree[0]) == "(Deliver deliver)":
                xm_speech_res.action.append('go')
                xm_speech_res.num += 1
                print("go")
            if tree[0].label()=="Talk":
                print( tree[0] )
                if str(tree[0]) == "(Talk answer)":
                    xm_speech_res.action.append('talk')
                    xm_speech_res.num+=1
                    print("talk")
                else:
                    xm_speech_res.action.append('tell')
                    xm_speech_res.num+=1
                    print("tell")
            if tree[0].label()=="Follow":
                xm_speech_res.action.append('follow')
                xm_speech_res.num += 1
                print( tree[0] )
                print("follow")
            if tree[0].label()=="Grasp":
                xm_speech_res.action.append('grasp')

                xm_speech_res.num += 1
                print("grasp")
            if tree[0].label()=="Remember":
                xm_speech_res.action.append('remember')
                xm_speech_res.num += 1
                print("remember")

    if tree.label()=="PropN":
        if len(tree)>0:
            if tree[0] == "me":
                xm_speech_res.target.append('speaker')
                print("speaker")
		
    if tree.label()=="Nom":
        if len(tree)==1:
            tr=tree[0]
            search(tr)
        if len(tree)==2:
            tr=tree[1]
            search(tr)#先不做形容词
             
    if tree.label()=="N":
        if len(tree)==1:
            tr=tree[0]
            search(tr)
            
    if tree.label()=="Location":
        if len(tree)==1:
            if tree[0] == "bedroom":
                xm_speech_res.target.append('bedroom')
                print("bedroom")
            if tree[0] == "diningroom":
                xm_speech_res.target.append('diningroom')
                print("diningroom")
            if tree[0] == "livingroom":
                xm_speech_res.target.append('livingroom')
                print("livingroom")
            if tree[0] == "kitchen":
                xm_speech_res.target.append('kitchen')
                print("kitchen")
            if tree[0] == "here":
                xm_speech_res.target.append('speaker')
                print("speaker")            

    if tree.label()=="Object":
        if len(tree)==1:
            if tree[0] == "cola":
                xm_speech_res.target.append('cola')
                print("cola")
            elif tree[0] == "coffee":
                xm_speech_res.target.append('coffee')
                print("coffee")
            elif tree[0] == "water":
                xm_speech_res.target.append('water')
                print("water")            
            elif tree[0] == "milk":
                xm_speech_res.target.append('milk')
                print("milk")
            elif tree[0] == "biscuit":
                xm_speech_res.target.append('biscuit')
                print("biscuit")
            elif tree[0] == "noodles":
                xm_speech_res.target.append('noodles')
                print("noodles")
            elif tree[0] == "rollpaper":
                xm_speech_res.target.append('roll paper')
                print("roll paper")
            elif tree[0] == "toothpaste":
                xm_speech_res.target.append('toothpaste')
                print("toothpaste")
            elif tree[0] == "chips":
                xm_speech_res.target.append('chips')
                print("chips")
            elif tree[0] == "soap":
                xm_speech_res.target.append('soap')
                print("soap")
            elif tree[0] == "cake":
                xm_speech_res.target.append('cake')
                print("cake")   
                   
	
    if tree.label()=="Person":
        if len(tree)==1:
            xm_speech_res.target.append('person')
            print("person")
	
    if tree.label()=="Topic":
        if len(tree)==1:
            tr=tree[0]
            search(tr)
            
    if tree.label()=="Time":
        if len(tree)==1:
            print(tree[0]+" ")
    if tree.label()=="Date":
        if len(tree)==1:
            print(tree[0]+" ")
    if tree.label()=="Name":
        if len(tree)==1:
            print(tree[0]+" ")
    if tree.label()=="Day":
        if len(tree)==1:
            print( tree[0] )
            if tree[0] == "whatdayistoday":
                xm_speech_res.target.append('monday')
                print("whatdayistoday")
    if tree.label()=="Question":
        if len(tree)==1:
            if tree[0] == "question":
                xm_speech_res.target.append('question')
                print("question")

#------------------------------------------------------------------------------


class XM(Recognizer):
    def __init__(self):
        """Class XM inherits from class Recognizer in speech_recognition"""

        Recognizer.__init__(self)
        
        #####
        self.login_params = "appid = 5b696e49, work_dir = ." # change   需根据讯飞账号做修改
        # sch=1, nlp_version=2.0
        self.session_begin_params = "engine_type = local, \
        language = en_us, \
        result_type = plain, \
        asr_res_path = fo|res/asr/common.jet, \
        sample_rate = 16000, \
        asr_threshold = 2, \
        asr_denoise = 1, \
        grm_build_path = res/asr/GrmBuilld,  \
        local_grammar= speech, \
        result_encoding = UTF-8";

        #local_grammar = %s,   
        
        
        self.grammar_id = None
        self.FRAME_LEN = 640*3 # change the frame length to change the response speed.
        self.session_id = None
        self.c_ret = c_int(0)

    def tts(self,text):
        #tts_test = rospy.ServiceProxy('tts',xm_Speech_tts)
        #tts_res = tts_test.call(text)
        #if tts_res.flag == 1:
        #    subprocess.call(["play","tts_sample.wav"])
        #else:
        subprocess.call(["espeak","-v","f3+en_us","-s","130",text])

    def callback(self, text):
        """this function is to process the recognized text and send the processed information to Arduino which controls some devices"""
        global text_last
        global xm_speech_req
        global xm_speech_res
        if len(text) != 0 :
            if text[28] == '=':
                text = text[29:]
            elif text[29] == '=':
                text = text[30:]
        if text != "you are right" and text != "no" and len(text) != 0:
            text_last = text
        if type(text) == str and len(text) != 0:
            print("recognized : " + text)
            if xm_speech_req.command == 1:#Answer a question
                if text == "what is the capital of china":
                    print("Beijing")
                    self.tts("Beijing")
                    xm_speech_res.num = 1
                elif text == "how many hours in a day":
                    print("twenty four")
                    self.tts("twenty four")
                    xm_speech_res.num = 1
                elif text == "how many season are there in one year":
                    print("four")
                    self.tts("four")
                    xm_speech_res.num = 1
                elif text == "how many seconds in one minute":
                    print("sixty")
                    self.tts("sixty")
                    xm_speech_res.num = 1
                elif text == "what is the world biggest island":
                    print("green land")
                    self.tts("green land")
                    xm_speech_res.num = 1
                elif text == "what is the biggest province of china":
                    print("xin jiang")
                    self.tts("xin jiang")
                    xm_speech_res.num = 1
                elif text == "how large is the area of china":
                    print("nine million and six hundred thousand saquare kilometers")
                    self.tts("nine million and six hundred thousand saquare kilometers")
                    xm_speech_res.num = 1
                elif text == "who was the first president of the usa":
                    print("george washington")
                    self.tts("george washington")
                    xm_speech_res.num = 1
                elif text == "what is china's national animal":
                    print("panda")
                    self.tts("panda")
                    xm_speech_res.num = 1
                elif text == "how many children did queen victoria have":
                    print("nine children")
                    self.tts("nine children")
                    xm_speech_res.num = 1
                elif text == "what was the former name of new york":
                    print("new amsterdam")
                    self.tts("new amsterdam")
                    xm_speech_res.num = 1
            elif xm_speech_req.command == 2:#GPSR
                if text != "you are right" and text != "no" and text != "stop here now":
                    if len(text_last) != 0:
                        self.tts(text_last)
                    self.tts("am i right")

                if text == "you are right":
                    if len(text_last) != 0:
                        self.tts("OK")
                        sen = text_last
                        rd = RecursiveDescentParser(grammar)
                        t = rd.parse_one(sen.split())
                        search(t)
                elif text == "stop here now":
                    xm_speech_res.action.append('stop')
                    xm_speech_res.num = 1
                    self.tts("OK")
                
            elif xm_speech_req.command == 3:#WhoIsWho
                if text != "you are right" and text != "no":
                    if len(text_last) != 0:
                        self.tts(text_last)
                    self.tts("am i right")   

                if text == "you are right":
                    if len(text_last) != 0:
                        self.tts("OK")
                        print("text_last:"+text_last)
                        #name
                        if text_last.find('Tom') >= 0:
                            xm_speech_res.name.append('Tom')
                            xm_speech_res.num += 1
                        elif text_last.find('Micheal') >= 0:
                            xm_speech_res.name.append('Micheal')
                            xm_speech_res.num += 1
                        elif text_last.find('Jack') >= 0:
                            xm_speech_res.name.append('Jack')
                            xm_speech_res.num += 1
                        elif text_last.find('Kevin') >= 0:
                            xm_speech_res.name.append('Kevin')
                            xm_speech_res.num += 1
                        elif text_last.find('Rose') >= 0:
                            xm_speech_res.name.append('Rose')
                            xm_speech_res.num += 1
                        elif text_last.find('John') >= 0:
                            xm_speech_res.name.append('John')
                            xm_speech_res.num += 1
                        elif text_last.find('Mary') >= 0:
                            xm_speech_res.name.append('Mary')
                            xm_speech_res.num += 1
                        elif text_last.find('Fisher') >= 0:
                            xm_speech_res.name.append('Fisher')
                            xm_speech_res.num += 1
                        elif text_last.find('Adam') >= 0:
                            xm_speech_res.name.append('Adam')
                            xm_speech_res.num += 1
                        elif text_last.find('Daniel') >= 0:
                            xm_speech_res.name.append('Daniel')
                            xm_speech_res.num += 1
                        #object
                        if text_last.find('ice tea') >= 0:
                            xm_speech_res.object.append('ice tea')
                            xm_speech_res.num += 1
                        elif text_last.find('safeguard') >= 0:
                            xm_speech_res.object.append('safeguard')
                            xm_speech_res.num += 1
                        elif text_last.find('napkin') >= 0:
                            xm_speech_res.object.append('napkin')
                            xm_speech_res.num += 1
                        elif text_last.find('chips') >= 0:
                            xm_speech_res.object.append('chips')
                            xm_speech_res.num += 1
                        elif text_last.find('laoganma') >= 0:
                            xm_speech_res.object.append('laoganma')
                            xm_speech_res.num += 1
                        elif text_last.find('porridge') >= 0:
                            xm_speech_res.object.append('porridge')
                            xm_speech_res.num += 1
                        elif text_last.find('milk') >= 0:
                            xm_speech_res.object.append('milk')
                            xm_speech_res.num += 1
                        elif text_last.find('water') >= 0:
                            xm_speech_res.object.append('water')
                            xm_speech_res.num += 1
                        elif text_last.find('cola') >= 0:
                            xm_speech_res.object.append('cola')
                            xm_speech_res.num += 1 
                        elif text_last.find('sprite') >= 0:
                            xm_speech_res.object.append('sprite')
                            xm_speech_res.num += 1 

            elif xm_speech_req.command == 4:#SPR
                #ArenaQ
                if text == "How many bookshelf are in the living room":
                    xm_speech_res.num = 1
                    self.tts("three")
                elif text == "In which room is the fridge":
                    xm_speech_res.num = 1
                    self.tts("kitchen")
                elif text == "How many doors has the Arena":
                    xm_speech_res.num = 1
                    self.tts("2")
                elif text == "In which room is the dining table":
                    xm_speech_res.num = 1
                    tself.tts("diningroom")
                elif text == "Where is located the bed":
                    xm_speech_res.num = 1
                    self.tts("bedroom")
                elif text == "How many fireplace are in the bedroom":
                    xm_speech_res.num = 1
                    self.tts("zero")
                elif text == "In which room is the sofa":
                    xm_speech_res.num = 1
                    self.tts("livingroom")
                elif text == "Where is located the fridge":
                    xm_speech_res.num = 1
                    self.tts("kitchen")
                elif text == "Where is located the cupboard":
                    xm_speech_res.num = 1
                    self.tts("diningroom")
                elif text == "In which room is the bookshelf":
                    xm_speech_res.num = 1
                    self.tts("bedroom")

                #ObjectQ
                elif text == "how many hours in a day":
                    xm_speech_res.num = 1
                    self.tts("twenty four")
                elif text == "how many season are there in one year":
                    xm_speech_res.num = 1
                    self.tts("four")
                elif text == "how many seconds in one minute":
                    xm_speech_res.num = 1
                    self.tts("sixty")
                elif text == "what is the world biggest island":
                    xm_speech_res.num = 1
                    self.tts("green land")
                elif text == "what is the biggest province of china":
                    xm_speech_res.num = 1
                    self.tts("shin junk")
                elif text == "how large is the area of china":
                    xm_speech_res.num = 1
                    self.tts("Nine million and six hundred thousand saquare kilometers")
                elif text == "Who was the first president of the USA":
                    xm_speech_res.num = 1
                    self.tts("George Washington")
                elif text == "What is China's national animal":
                    xm_speech_res.num = 1
                    self.tts("panda")
                elif text == "How many children did Queen Victoria have":
                    xm_speech_res.num = 1
                    self.tts("Nine children")
                elif text == "What was the former name of New York":
                    xm_speech_res.num = 1
                    self.tts("New Amsterdam")

                #PredefinedQ
                elif text == "How many people live in the Japan":
                    xm_speech_res.num = 1
                    self.tts("A little over 80 million")
                elif text == "what is the capital of the united states":
                    xm_speech_res.num = 1
                    self.tts("Washington DC")
                elif text == "what day is today":
                    xm_speech_res.num = 1
                    self.tts("Saturday")
                elif text == "What city is the capital of the Japan":
                    xm_speech_res.num = 1
                    self.tts("Tokyo")
                elif text == "Where does the term computer bug come from":
                    xm_speech_res.num = 1
                    self.tts("From a moth trapped in a relay")
                elif text == "When was invented the B programming language":
                    xm_speech_res.num = 1
                    self.tts("B was developed circa 1969 at Bell Labs")
                elif text == "Who invented the C programming language":
                    xm_speech_res.num = 1
                    self.tts("Ken Thompson and Dennis Ritchie")
                elif text == "What is the highest point in Japan":
                    xm_speech_res.num = 1
                    self.tts("The highest point in Japan is Mount Fuji")
                elif text == "What are the colours of the Japanese flag":
                    xm_speech_res.num = 1
                    self.tts("Japanese flag is a red circle centred over white")
                elif text == "Who invented the first compiler":
                    xm_speech_res.num = 1
                    self.tts("Grace Brewster Murray Hopper invented it")

                #CrowdOperatorQ
                elif text == "number of male people sitting":
                    xm_speech_res.num = 2
                    time.sleep(1)
                elif text == "number of female people sitting":
                    xm_speech_res.num = 3
                    time.sleep(1)
                elif text == "number of male people standing":
                    xm_speech_res.num = 4
                    time.sleep(1)
                elif text == "number of female people standing":
                    xm_speech_res.num = 5
                    time.sleep(1)
                elif text == "number of people standing":
                    xm_speech_res.num = 6
                    time.sleep(1)
                elif text == "number of people sitting":
                    xm_speech_res.num = 7
                    time.sleep(1)


            elif(xm_speech_req.command == 5):     #help me carry   未完成
                if text != "you are right" and text != "no":
                    if len(text_last) != 0:
                        self.tts(text_last)
                    self.tts("am i right")

                if text == "you are right":
                    if len(text_last) != 0:

                        if text_last.find("stop") >= 0:
                            xm_speech_res.action.append('stop')
                        elif text_last.find("follow") >= 0:
                            xm_speech_res.action.append('follow')
                        elif text_last.find("kitchen") >= 0:
                            xm_speech_res.target.append('kitchen')
                        elif text_last.find("livingroom") >= 0:
                            xm_speech_res.target.append('livingroom')
                        elif text_last.find("bedroom") >= 0:
                            xm_speech_res.target.append('bedroom')
                        elif text_last.find("diningroom") >= 0:
                            xm_speech_res.target.append('diningroom')

                        self.tts("OK")
                            
                        xm_speech_res.num = 1 
                        print("text_last:"+text_last)

            
            elif(xm_speech_req.command == 6):       #shopping
                if text != "you are right" and text != "no":
                    if len(text_last) != 0:
                        self.tts(text_last)
                    self.tts("am i right")    

                if text == "you are right":
                    if len(text_last) != 0:
                        self.tts("OK")
                        print("text_last:"+text_last)

                        num = 0
                        #follow
                        if text_last.find('follow') >= 0:
                            xm_speech_res.action.append('follow')
                            num += 1
                        
                        #object
                        if text_last.find('ice tea') >= 0:
                            xm_speech_res.object.append('ice tea')
                            num += 1
                        if text_last.find('safeguard') >= 0:
                            xm_speech_res.object.append('safeguard')
                            num += 1
                        if text_last.find('napkin') >= 0:
                            xm_speech_res.object.append('napkin')
                            num += 1
                        if text_last.find('chips') >= 0:
                            xm_speech_res.object.append('chips')
                            num += 1
                        if text_last.find('laoganma') >= 0:
                            xm_speech_res.object.append('laoganma')
                            num += 1
                        if text_last.find('milk') >= 0:
                            xm_speech_res.object.append('milk')
                            num += 1
                        if text_last.find('water') >= 0:
                            xm_speech_res.object.append('water')
                            num += 1
                        if text_last.find('cola') >= 0:
                            xm_speech_res.object.append('cola')
                            num += 1
                        if text_last.find('porridge') >= 0:
                            xm_speech_res.object.append('porridge')
                            num += 1 
                        if text_last.find('sprite') >= 0:
                            xm_speech_res.object.append('sprite')
                            num += 1
                        #方向
                        if text_last.find('right') >= 0:
                            xm_speech_res.target.append('right')
                            num += 1 
                        if text_last.find('left') >= 0:
                            xm_speech_res.target.append('left')
                            num += 1

                        xm_speech_res.num = num
            
            
                                        
    def auto_listen(self, source, phrase_time_limit=None):
        """this function is similar to listen_in_background in father class, but runs in the main thread"""
        assert isinstance(source, AudioSource), "Source must be an audio source"
        #####
        global xm_speech_res
        self.c_ret.value = msc.MSPLogin(None, None, self.login_params) # change
        if(self.c_ret.value != MSP_SUCCESS):
            print("Login failed ! error code : ", self.c_ret.value)
            return
        #####
        running = [True]
        try:
            print("a moment of silence, please...")
            with source as s:
                self.adjust_for_ambient_noise(s) # we only need to calibrate once, before we start listening

            while pause == 0:
                with source as s:
                    try:  # listen for 1 second, then check again if the stop function has been called
                        print("listen")
                        sr_result = self.listen(s,timeout=100)
                        print("sr_result:"+sr_result)
                    except WaitTimeoutError:  # listening timed out, just try again
                        pass
                if pause == 0: self.callback(sr_result)
        except KeyboardInterrupt:
            running[0] = False
            #####
        self.c_ret.value = msc.MSPLogout()
        print("Logout ! return code : ", self.c_ret.value)
            #####


    def listen(self, source, timeout=None, phrase_time_limit=None):
        """
        this function is to  the function with same name in father class, and to achieve uploading the speech audio while recoding them
        """

        assert isinstance(source, AudioSource), "Source must be an audio source"
        assert source.stream is not None, "Audio source must be entered before listening, see documentation for ``AudioSource``; are you using ``source`` outside of a ``with`` statement?"
        assert self.pause_threshold >= self.non_speaking_duration >= 0

        seconds_per_buffer = (source.CHUNK + 0.0) / source.SAMPLE_RATE
        pause_buffer_count = int(math.ceil(self.pause_threshold / seconds_per_buffer))  # number of buffers of non-speaking audio during a phrase, before the phrase should be considered complete
        phrase_buffer_count = int(math.ceil(self.phrase_threshold / seconds_per_buffer))  # minimum number of buffers of speaking audio before we consider the speaking audio a phrase
        non_speaking_buffer_count = int(math.ceil(self.non_speaking_duration / seconds_per_buffer))  # maximum number of buffers of non-speaking audio to retain before and after a phrase

        # read audio input for phrases until there is a phrase that is long enough
        elapsed_time = 0  # number of seconds of audio read
        buffer = ""  # an empty buffer means that the stream has ended and there is no data left to read
        ####
        resultText = None
        timeout_flag = 0
        ####
        while True:
            frames = collections.deque()
            timeout_flag += 1

            # store audio input until the phrase starts
            while True:
                # handle waiting too long for phrase by raising an exception
                elapsed_time += seconds_per_buffer
                if timeout and elapsed_time > timeout:
                    raise WaitTimeoutError("listening timed out while waiting for phrase to start")

                buffer = source.stream.read(source.CHUNK)
                if len(buffer) == 0: break  # reached end of the stream
                frames.append(buffer)
                if len(frames) > non_speaking_buffer_count:  # ensure we only keep the needed amount of non-speaking buffers
                    frames.popleft()

                # detect whether speaking has started on audio input
                energy = audioop.rms(buffer, source.SAMPLE_WIDTH)  # energy of the audio signal
                if energy > self.energy_threshold: break

                # dynamically adjust the energy threshold using asymmetric weighted average
                if self.dynamic_energy_threshold:
                    damping = self.dynamic_energy_adjustment_damping ** seconds_per_buffer  # account for different chunk sizes and rates
                    target_energy = energy * self.dynamic_energy_ratio
                    self.energy_threshold = self.energy_threshold * damping + target_energy * (1 - damping)
                
            #####
            epStatus = c_int(0)
            recogStatus = c_int(0)
            

            self.session_id = msc.QISRSessionBegin(self.grammar_id, self.session_begin_params, byref(self.c_ret))
            if(self.c_ret.value != MSP_SUCCESS):
                print("SessionBegin failed ! error code : ", self.c_ret.value)
                # end the session
                self.c_ret.value = msc.QISRSessionEnd(self.session_id, "normal end")
                if(self.c_ret.value != MSP_SUCCESS):
                    print("QISRRessionEnd failed ! error code : ", self.c_ret.value)
                self.session_id = None
                break
            

            self.c_ret.value = msc.QISRAudioWrite(self.session_id, buffer, len(buffer), MSP_AUDIO_SAMPLE_FIRST, byref(epStatus), byref(recogStatus))
            if(self.c_ret.value != MSP_SUCCESS):
                print("QISRAudioWrite failed ! error code : ", self.c_ret.value)
                # end the session
                self.c_ret.value = msc.QISRSessionEnd(self.session_id, "normal end")
                if(self.c_ret.value != MSP_SUCCESS):
                    print("QISRRessionEnd failed ! error code : ", self.c_ret.value)
                self.session_id = None
                break
            #####

            # read audio input until the phrase ends
            pause_count, phrase_count = 0, 0
            phrase_start_time = elapsed_time
            lenflag = 0           #cut down the stream when it is time out
            while True:
                # handle phrase being too long by cutting off the audio
                lenflag += 1
                elapsed_time += seconds_per_buffer
                if phrase_time_limit and elapsed_time - phrase_start_time > phrase_time_limit:
                    break

                buffer = source.stream.read(source.CHUNK)
                if len(buffer) == 0 or lenflag == 100: 
                    break  # reached end of the stream
                frames.append(buffer)
                #####
                self.c_ret.value = msc.QISRAudioWrite(self.session_id, buffer, len(buffer), MSP_AUDIO_SAMPLE_CONTINUE, byref(epStatus), byref(recogStatus))
                if(self.c_ret.value != MSP_SUCCESS):
                    print("QISRAudioWrite1 failed ! error code : ", self.c_ret.value)
    #                 # end the session
    #                 self.c_ret.value = msc.QISRSessionEnd(self.session_id, b"normal end")
    #                 if(self.c_ret.value != MSP_SUCCESS):
    #                     print("QISRRessionEnd failed ! error code : ", self.c_ret.value)
    #                 self.session_id = None
                    break
                if(MSP_REC_STATUS_SUCCESS == recogStatus.value):
    #                print("some result")
    #                msc.QISRGetResult.restype = c_char_p
    #                retstr = msc.QISRGetResult(self.session_id, byref(recogStatus), 0, byref(self.c_ret))
    #                if(retstr is not None):
    #                    resultText += str(retstr, encoding = "utf-8") # convert bytes to string
    #                    print(self.c_ret.value)
                    pass
                if(epStatus.value >= 3):
                    break
                #####

                phrase_count += 1

                # check if speaking has stopped for longer than the pause threshold on the audio input
                energy = audioop.rms(buffer, source.SAMPLE_WIDTH)  # unit energy of the audio signal within the buffer
                if energy > self.energy_threshold:
                    pause_count = 0
                else:
                    pause_count += 1
                if pause_count > pause_buffer_count:  # end of the phrase
                    break

            #####
            self.c_ret.value = msc.QISRAudioWrite(self.session_id, None, 0, MSP_AUDIO_SAMPLE_LAST, byref(epStatus), byref(recogStatus))
            if(self.c_ret.value != MSP_SUCCESS):
                print("QISRAudioWrite2 failed ! error code : ", self.c_ret.value)
                # end the session
                self.c_ret.value = msc.QISRSessionEnd(self.session_id, "normal end")
                if(self.c_ret.value != MSP_SUCCESS):
                    print("QISRRessionEnd failed ! error code : ", self.c_ret.value)
                self.session_id = None
                break

            # get the recognition results

            resultText = '' # reset this global variable to blank string
            while(recogStatus.value != MSP_REC_STATUS_COMPLETE):
                msc.QISRGetResult.restype = c_char_p
                retstr = msc.QISRGetResult(self.session_id, byref(recogStatus), 0, byref(self.c_ret))
                if(retstr is not None):
                    resultText += str(retstr) # convert bytes to string, encoding = "utf-8"
                time.sleep(0.1)

#            if(resultText != ''):
#                print(resultText)

            self.c_ret.value = msc.QISRSessionEnd(self.session_id, "normal end")
            if(self.c_ret.value != MSP_SUCCESS):
                print("QISRRessionEnd failed ! error code : ", self.c_ret.value)
            self.session_id = None
            #####

            # check how long the detected phrase is, and retry listening if the phrase is too short
            phrase_count -= pause_count  # exclude the buffers for the pause before the phrase
            if phrase_count >= phrase_buffer_count or len(buffer) == 0 or timeout_flag >= 100: break  # phrase is long enough or we've reached the end of the stream, so stop listening
        return resultText
#        # obtain frame data
#        for i in range(pause_count - non_speaking_buffer_count): frames.pop()  # remove extra non-speaking frames at the end
#        frame_data = b"".join(list(frames))
#        return AudioData(frame_data, source.SAMPLE_RATE, source.SAMPLE_WIDTH)

def xm_callback():
    global xm_speech_req
    if xm_speech_req.command >0 and xm_speech_req.command <=6:
        xm = XM()
        m = Microphone(sample_rate = 16000, chunk_size = 1024)
        xm.auto_listen(m)

def runiat(req):#req
    #ret = build_grammar(asr_data)
    '''
    xm = XM()
    m = Microphone(sample_rate = 16000, chunk_size = 1024)
    xm.auto_listen(m)
    '''
    global xm_speech_req
    global xm_speech_res
    global pause
    xm_speech_req = req
    
    running=[True]
    try:
        while running[0]:
            xm_speech_res.num = 0
            xm_speech_res.action = []
            xm_speech_res.target = []
            xm_speech_res.name = []
            xm_speech_res.object = []
            pause = 0
            while xm_speech_res.num == 0 :
                time.sleep(0.5)
                if xm_speech_res.num !=0:
                    pause = 1
                    '''if xm_speech_req.command == 2:
                        if xm_speech_res.action[2] == 'grasp':
                            if xm_speech_res.target[2] == 'livingroom' or xm_speech_res.target[2] == 'kitchen' or xm_speech_res.target[2] == 'diningroom' or xm_speech_res.target[2] == 'bedroom':
                                xm_speech_res.action[2] = 'go'
                                if xm_speech_res.num ==2:
                                    xm_speech_res.num += 1'''
                    xm_speech_req.command = -1
                    return xm_speech_res
    except KeyboardInterrupt:
        running[0] = False

#------------------------------------------------------------------------------

def xm_speech_clien_server():
    rospy.init_node('xm_speech_clien_server')
    s = rospy.Service('xm_speech_meaning', xm_Speech_meaning, runiat)
    global pause
    global xm_speech_res
    running=[True]
    try:
        while running[0]:
            if pause == 0 :
                xm_callback()
    except KeyboardInterrupt:
        running[0] = False

    #rospy.spin()

#------------------------------------------------------------------------------

if __name__ == "__main__":
    xm_speech_clien_server()    

#------------------------------------------------------------------------------
