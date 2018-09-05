#!/usr/bin/env python
#encoding:utf-8
# -*- coding: utf-8 -*-
"""
Created on Sun Jul 24 2016

@author: fanfan
"""
# NOTE: this project requires PyAudio because it uses the Microphone class

import time
import rospy
from std_msgs.msg import String
from xm_speech.srv import *     #from...import与import区别在于import直接导入指定的库,而from....import则是从指定的库中导入指定的模块
import speech_recognition as sr   #import...as则是将import A as B,给予A库一个B的别称,帮助记忆
from os import path
from ctypes import *
from lxml import etree
import threading

import rospy

import nltk
import os
import sys

from nltk import CFG
from nltk.parse import RecursiveDescentParser

import subprocess
import time

xm_speech_res = xm_Speech_meaningResponse()
text_last = None
# -----------------------------------------------------------------------------
# From alsa-lib Git 3fd4ab9be0db7c7430ebd258f2717a976381715d
# $ grep -rn snd_lib_error_handler_t
# include/error.h:59:typedef void (*snd_lib_error_handler_t)(const char *file, int line, const char *function, int err, const char *fmt, ...) /* __attribute__ ((format (printf, 5, 6))) */;

# Define our error handler type
ERROR_HANDLER_FUNC = CFUNCTYPE(None, c_char_p, c_int, c_char_p, c_int, c_char_p)

def py_error_handler(filename, line, function, err, fmt):
    pass

c_error_handler = ERROR_HANDLER_FUNC(py_error_handler)

asound = cdll.LoadLibrary('libasound.so')

# Set error handler
asound.snd_lib_error_set_handler(c_error_handler)

# -----------------------------------------------------------------------------

# Python Festival module
def speak(text):
    if type(text) == str and len(text) != 0:
        subprocess.call(["espeak","-v","f3+en_us","-s","130",text])
    else:
        pass

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

VP ->V NP|V NP PP|V PP|V NP NP|V PP PP
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
Object ->"cola"|"sprite"|"water"|"milk"|"tea"|"bread"|"cake"|"noodle"|"biscuit"|"shampoo"|"roll paper"|"toothpaste"|"pen box"|"chips"|"soap"
Person ->"person"|"me"|"her"
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
Grasp ->"grasp"|"get"|"take"
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
                                tr=tree[2]
                                search(tr)
                                tr=tree[0]
                                search(tr)
                                tr=tree[1]
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
            elif tree[0] == "sprite":
                xm_speech_res.target.append('sprite')
                print("sprite")
            elif tree[0] == "water":
                xm_speech_res.target.append('water')
                print("water")            
            elif tree[0] == "milk":
                xm_speech_res.target.append('milk')
                print("milk")
            elif tree[0] == "tea":
                xm_speech_res.target.append('tea')
                print("tea")
            elif tree[0] == "bread":
                xm_speech_res.target.append('bread')
                print("bread")
            elif tree[0] == "cake":
                xm_speech_res.target.append('cake')
                print("cake")
            elif tree[0] == "noodle":
                xm_speech_res.target.append('noodle')
                print("noodle")
            elif tree[0] == "bicuit":
                xm_speech_res.target.append('biscuit')
                print("biscuit")
            elif tree[0] == "shampoo":
                xm_speech_res.target.append('shampoo')
                print("shampoo")
            elif tree[0] == "roll paper":
                xm_speech_res.target.append('roll paper')
                print("roll paper")
            elif tree[0] == "toothpaste":
                xm_speech_res.target.append('toothpaste')
                print("toothpaste")
            elif tree[0] == "pen box":
                xm_speech_res.target.append('pen box')
                print("pen box")
            elif tree[0] == "chips":
                xm_speech_res.target.append('chips')
                print("chips")
            elif tree[0] == "soap":
                xm_speech_res.target.append('soap')
                print("soap")              
	
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

def callback(recognizer, audio):
    # received audio data, now we'll recognize it using xunfei Speech Recognition
    global xm_speech_req
    global xm_speech_res
    global text_last
    audio_wav_data = audio.get_wav_data()
    with open("microphone-results.wav", "wb") as f:
        f.write(audio.get_wav_data())
    # print("audio_len : " + str(len(audio_wav_data))) # audio data length
    # print("Got it! Now to recognize it...")
    print("detecting...")
    if len(audio_wav_data) > 50000 and len(audio_wav_data) <300000:
        print("pcm_len : " + str(len(audio_wav_data))) # audio data length
        rospy.wait_for_service('xm_speech')
        try:
            xm_speech = rospy.ServiceProxy('xm_speech',xm_Speech)
            resp1 = xm_speech(audio_wav_data)
            text = resp1.sr_text
            if text != "yes" and text != "no" and len(text) != 0:
                text_last = text
            if type(text) == str and len(text) != 0:
                print("recognized : " + text)
                if xm_speech_req.command == 0:
                    if text == "what is the captital of china":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","bei jing"])
                        xm_speech_res.num = 1
                    elif text == "how many hours in a day":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","24"])
                        xm_speech_res.num = 1
                    elif text == "how many season are there in one year":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","4"])
                        xm_speech_res.num = 1
                    elif text == "how many seconds in one minute":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","60"])
                        xm_speech_res.num = 1
                    elif text == "what is the world biggest island":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","green land"])
                        xm_speech_res.num = 1
                    elif text == "what is the biggest province of china":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","xin jiang"])
                        xm_speech_res.num = 1
                    elif text == "how large is the area of china":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","nine million and six hundred thousand saquare kilometers"])
                        xm_speech_res.num = 1
                    elif text == "who was the first president of the usa":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","george washington"])
                        xm_speech_res.num = 1
                    elif text == "what is china's national animal":
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","panda"])
                        xm_speech_res.num = 1
                elif xm_speech_req.command == 1:#GPSR
                    if text != "yes" and text != "no":
                        if len(text_last) != 0:
                            subprocess.call(["espeak","-v","f3+en_us","-s","130",text_last])
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","yes or no"])
                    if text == "yes":
                        if len(text_last) != 0:
                            sen = text_last
                            rd = RecursiveDescentParser(grammar)
                            t = rd.parse_one(sen.split())
                            search(t)
                elif xm_speech_req.command == 2:#HelpMeCarry
                    if text != "yes" and text != "no":
                        if len(text_last) != 0:
                            subprocess.call(["espeak","-v","f3+en_us","-s","130",text_last])
                        subprocess.call(["espeak","-v","f3+en_us","-s","130","yes or no"])                
                    if text == "yes":
                        if len(text_last) != 0:
                            subprocess.call(["espeak","-v","f3+en_us","-s","130","OK"])
                            print("text_last:"+text_last)
                            if text_last == "follow me":
                                xm_speech_res.action.append('follow')
                                xm_speech_res.num += 1
                            elif text_last == "remember location":
                                xm_speech_res.action.append('remember')
                                xm_speech_res.num += 1
                            elif text_last == "take it":
                                xm_speech_res.action.append('grasp')
                                xm_speech_res.num += 1
                            elif text_last == "carry to the kitchen":
                                xm_speech_res.target.append('kitchen')
                                xm_speech_res.num += 1
                            elif text_last == "carry to the bedroom":
                                xm_speech_res.target.append('bedroom')
                                xm_speech_res.num += 1
                            elif text_last == "take to the dining room":
                                xm_speech_res.target.append('diningroom')
                                xm_speech_res.num += 1
                            elif text_last == "carry to the living room":
                                xm_speech_res.target.append('livingroom')
                                xm_speech_res.num += 1
            else:
                pass

        except rospy.ServiceException, e:
            print "Service call failed: %s"%e
    else:
        pass

#------------------------------------------------------------------------------

def runiat(req):
	#"the main function: listen in the background and retain audio"
    global xm_speech_res
    global xm_speech_req
    xm_speech_res = xm_Speech_meaningResponse()
    xm_speech_req = req
    r = sr.Recognizer()
    r.energy_threshold = 150#energy_threshold higher,means the cround is noisier,keep it at good level
                            #noisy 200 is good, queit 100 is good
    m = sr.Microphone(sample_rate=16000,chunk_size = 1024)#此处有坑
    running=[True]
    try:
        print("a moment of silence, please...")#紧跟with后面的语句被求值后,返回对象的__enter__()方法被调用,这个方法的返回值将被赋值给as后
        speak("a moment of silence, please...")#面的变量.当with后面的代码块全部被执行完之后，将调用前面返回对象的__exit__()方法
        with m as source:
            r.adjust_for_ambient_noise(source) # we only need to calibrate once, before we start listening
	    
        with m as source:
            while running[0]:
                try:
                    audio = r.listen(source,phrase_time_limit = 10)
                except Exception:
                    pass
                else:
                    if running[0]: callback(r, audio)
                    if xm_speech_res.num != 0 : return xm_speech_res                  					
    except KeyboardInterrupt:
        running[0] = False
    pass

#------------------------------------------------------------------------------

def xm_speech_clien_server():
    rospy.init_node('xm_speech_clien_server')
    s = rospy.Service('xm_speech_meaning', xm_Speech_meaning, runiat)
    rospy.spin()

#------------------------------------------------------------------------------

if __name__ == "__main__":
    xm_speech_clien_server()

#------------------------------------------------------------------------------