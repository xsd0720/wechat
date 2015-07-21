//
//  WHAudioTool.m
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "WHAudioTool.h"

@implementation WHAudioTool
/**
 *  存放所有的音乐播放器
 */
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers
{
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (BOOL)playMusic:(NSString *)filename
{
    if (!filename) return NO;
    
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    
    if (!player) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return NO;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        if (![player prepareToPlay]) return NO;
        
        [self musicPlayers][filename] = player;
    }
    
    if (!player.isPlaying) {
        return [player play];
    }
    return YES;
}
+ (void)systemPlay:(NSString *)filename{

    SystemSoundID                 soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    if (path == nil) {
        return;
    }
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    //添加
    AudioServicesPlaySystemSound (soundID);
}
@end
