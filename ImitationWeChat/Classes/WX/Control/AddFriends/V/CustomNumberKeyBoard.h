//
//  CustomNumberKeyBoard.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *keyBoardDelete = @"keyBoardDelete";
static CGFloat KeyBoardTotalHeight = 55*4;

@class KeyBoardItem;

@protocol CustomKeyBoardDelegate <NSObject>

- (void)didClickItem:(KeyBoardItem *)item isDelete:(BOOL)del;

@end


@interface KeyBoardItem : UIControl

@property (nonatomic, strong) UIButton *contentButton;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) id<CustomKeyBoardDelegate> delegate;

@end


@interface CustomNumberKeyBoard : UIView

@property (nonatomic, assign) id<CustomKeyBoardDelegate> delegate;

@end
