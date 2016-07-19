//
//  CustomNumberKeyBoard.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "CustomNumberKeyBoard.h"
#import "math.h"


@implementation CustomNumberKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat buttonWidth = SCREEN_WIDTH/3;
        CGFloat buttonHeight = 55;
        self.height = buttonHeight * 4;
        
        CGFloat tempX = 0;
        CGFloat tempY = 0;
        
        for (int i = 1; i<= 12; i++) {
            KeyBoardItem *keyBoardItem = [[KeyBoardItem alloc] init];
            [keyBoardItem addTarget:self action:@selector(keyBoardItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:keyBoardItem];
            
            keyBoardItem.frame = CGRectMake(tempX, tempY, buttonWidth, buttonHeight);
            
            tempX += buttonWidth;
            
            if (i%3 == 0) {
                tempX = 0;
                tempY += buttonHeight;
            }
            
            if (i == 10) {
                keyBoardItem.userInteractionEnabled = NO;
                continue;
            }
            
            
            
            if (i == 11) {
                [keyBoardItem setContent:@"0"];
            }
            else if (i == 12)
            {
                [keyBoardItem setContent:keyBoardDelete];
            }
            else
            {
                [keyBoardItem setContent:[NSString stringWithFormat:@"%i", i]];
            }
            

        }
        
    }
    return self;
}


- (void)keyBoardItemClick:(KeyBoardItem *)item
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItem:isDelete:)]) {
        [self.delegate didClickItem:item isDelete:[item.content isEqualToString:keyBoardDelete]];
    }
}

@end

@implementation KeyBoardItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(28, 34, 36);
        self.layer.borderColor = [RGB(44, 47, 51) CGColor];
        self.layer.borderWidth = 0.5;
        
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentButton setBackgroundImage:[UIImage imageNamed:@"around-friends_keyboard_hl_mid"] forState:UIControlStateHighlighted];
        [_contentButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
        [_contentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _contentButton.titleLabel.font = [UIFont systemFontOfSize:25];
        [_contentButton addTarget:self action:@selector(contentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_contentButton];
        
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    if ([content isEqualToString:keyBoardDelete]) {
        [_contentButton setImage:[UIImage imageNamed:@"around-friends_keybroad"] forState:UIControlStateNormal];
    }
    else
    {
        [_contentButton setTitle:content forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _contentButton.frame = CGRectMake(-5, -5, frame.size.width+8, frame.size.height+8);
}

- (void)contentButtonClick
{
    [WHAudioTool systemPlay:@"facegroup_key.wav"];
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end