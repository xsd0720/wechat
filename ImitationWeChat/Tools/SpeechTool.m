//
//  SpeechTool.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SpeechTool.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"
NSString *const kIFlyAppID = @"5396d66c";
@implementation SpeechTool
/**
 *  单例
 *
 *  @return 单例
 */
+ (SpeechTool *)defaultTool
{
    static SpeechTool *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initRecognizer];
        
        [self initSynthesizer];
        
    }
    return self;
}

#pragma mark - 设置合成参数
- (void)initSynthesizer
{
    //合成服务单例
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];

    _iFlySpeechSynthesizer.delegate = self;
    
    //本地资源打包在app内
    [[IFlySpeechUtility getUtility] setParameter:@"tts" forKey:[IFlyResourceUtil ENGINE_START]];
    
    //设置语速1-100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    
    //设置音量1-100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    
    //设置音调1-100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant PITCH]];
    
    //设置引擎类型
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD] forKey:[IFlySpeechConstant ENGINE_TYPE]];
    
    //设置采样率
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant SAMPLE_RATE_16K] forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    
    //    云端支持发音人：小燕（xiaoyan）、小宇（xiaoyu）、凯瑟琳（Catherine）、
    //    亨利（henry）、玛丽（vimary）、小研（vixy）、小琪（vixq）、
    //    小峰（vixf）、小梅（vixm）、小莉（vixl）、小蓉（四川话）、
    //    小芸（vixyun）、小坤（vixk）、小强（vixqa）、小莹（vixying）、 小新（vixx）、楠楠（vinn）老孙（vils）<br>
    //    对于网络TTS的发音人角色，不同引擎类型支持的发音人不同，使用中请注意选择。
    //设置发音人
    [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
}


/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    
//    if ([IATConfig sharedInstance].haveView == NO) {//无界面
    
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
    }
//    }
    
    
//    else  {//有界面
//        
//        //单例模式，UI的实例
//        if (_iflyRecognizerView == nil) {
//            //UI显示剧中
//            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
//            
//            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
//            
//            //设置听写模式
//            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//            
//        }
//        _iflyRecognizerView.delegate = self;
//        
//        if (_iflyRecognizerView != nil) {
//            IATConfig *instance = [IATConfig sharedInstance];
//            //设置最长录音时间
//            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
//            //设置后端点
//            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
//            //设置前端点
//            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
//            //设置采样率，推荐使用16K
//            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
//            if ([instance.language isEqualToString:[IATConfig chinese]]) {
//                //设置语言
//                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//                //设置方言
//                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
//            }else if ([instance.language isEqualToString:[IATConfig english]]) {
//                //设置语言
//                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//            }
//            //设置是否返回标点符号
//            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
//            
//        }
//    }
}


-(void)discernBlock:(SpeechResultBlock)speechResult errorBlock:(SpeechResultError)error{

    self.speechResultBlock = speechResult;
    self.speechResultError = error;
    
//    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        

        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret)
        {
            NSLog(@"成功开始识别");
        }
        else
        {
            NSLog(@"启动识别服务失败，请稍后重试");
        }
//    }
//    else {
//        
//        if(_iflyRecognizerView == nil)
//        {
//            [self initRecognizer ];
//        }
//        
//        [_textView setText:@""];
//        [_textView resignFirstResponder];
//        
//        //设置音频来源为麦克风
//        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
//        
//        //设置听写结果格式为json
//        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
//        
//        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
//        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
//        
//        [_iflyRecognizerView start];
//    }

    
    
}
/**
 
 语义理解结果回调
 result 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度
 isLast：表示最后一次
 ****/
- (void)onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
   
    if (!isLast) {
        NSString *resultFromJson = [ISRDataHelper stringFromJson:resultString];
        self.speechResultBlock(resultFromJson);
        
        [_iFlySpeechRecognizer stopListening];
    }

}

/**
 
 语义理解发生错误
 ****/
- (void) onError:(IFlySpeechError *) errorCode{
    if (self.speechResultError) {
        self.speechResultError(errorCode);
    }
    
}

#pragma mark 语音播放的代理函数
/**
 开始通用合成
 ****/
- (void)startSpeaking:(NSString *)speakString {
    
    if (IsNilOrNull(speakString)) {
        NSLog(@"无效的文本信息");
        return;
    }
    _iFlySpeechSynthesizer.delegate = self;
    [_iFlySpeechSynthesizer startSpeaking:speakString];

}


/**
 开始播放回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakBegin
{

}

/**
 取消合成
 注：
 1、取消通用合成，并停止播放；
 2、uri合成取消时会保存已经合成的pcm；
 ****/
- (void)cancelSynBtnHandler{
    
    [_iFlySpeechSynthesizer stopSpeaking];
    
}


/**
 暂停播放
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)pauseSynBtnHandler{
    
    [_iFlySpeechSynthesizer pauseSpeaking];
}


/**
 恢复播放
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)resumeSynBtnHandler{
    
    [_iFlySpeechSynthesizer resumeSpeaking];
}


@end
