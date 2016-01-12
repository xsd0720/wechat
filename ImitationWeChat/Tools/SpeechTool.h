//
//  SpeechTool.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/11.
//  Copyright © 2016年 wany. All rights reserved.
//
@class IFlySpeechError;


typedef void(^SpeechResultBlock)(NSString *result);
typedef void(^SpeechResultError)(IFlySpeechError *error);

#import <Foundation/Foundation.h>
#import <iflyMSC/iflyMSC.h>


@interface SpeechTool : NSObject<IFlySpeechRecognizerDelegate, IFlySpeechSynthesizerDelegate>
{

}

//语音语义理解对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象

//语音合成
@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;


@property (nonatomic, strong) SpeechResultBlock speechResultBlock;

@property (nonatomic, strong) SpeechResultError speechResultError;


+(SpeechTool *)defaultTool;


#pragma mark - 语音识别
//识别
-(void)discernBlock:(SpeechResultBlock)speechResult errorBlock:(SpeechResultError)error;


//停止录音
- (void)stopListening;


//取消录音
- (void)cancelListening;


#pragma mark - 语音念

/**
 开始通用合成
 ****/
- (void)startSpeaking:(NSString *)speakString;

@end
