//
//  WHAudioTool.h
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHAudioTool : NSObject

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (BOOL)playMusic:(NSString *)filename;
/**
 *  使用系统方法播放音效
 *
 *
 *@param filename 音乐的文件名
 **/
+ (void)systemPlay:(NSString *)filename;
@end
