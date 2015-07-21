//
//  ChooseView.m
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ChooseTabbar.h"
#import "TabBarItem.h"
@implementation ChooseTabbar

-(instancetype)initWithFrame:(CGRect)frame subViewData:(NSArray *)datasouce{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = frame.size.width/datasouce.count;
        CGFloat h = frame.size.height;
        
        _chooseItemArray = [NSMutableArray array];
        
        for (int i=0; i<datasouce.count; i++) {
            TabBarItem *tabbrItem = [[TabBarItem alloc] initWithFrame:CGRectMake(i*w,0, w, h)];
            // [tabbrItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            tabbrItem.button.frame = CGRectMake(0,0, w, h-LabelHeight);
            [tabbrItem.button setImage:[UIImage imageNamed:datasouce[i][@"imageName"]] forState:UIControlStateNormal];
            [tabbrItem.button setImage:[UIImage imageNamed:datasouce[i][@"imageName_HL"]] forState:UIControlStateSelected];
            tabbrItem.label.text = datasouce[i][@"text"];
            tabbrItem.label.frame  = CGRectMake(0, tabbrItem.frame.size.height-LabelHeight, w, LabelHeight);
            [self addSubview:tabbrItem];
            tabbrItem.tag = i;
            [tabbrItem addTarget:self action:@selector(chooseViewClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_chooseItemArray addObject:tabbrItem];
            
            if (i == 0) {
                tabbrItem.selected = YES;
            }
        }
        

    }
    return self;
    
}
//功能选择
-(void)chooseViewClick:(UIButton *)button{
    
    [_chooseItemArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
    }];
    button.selected = YES;
    if (_chooseTabbarBlock) {
        _chooseTabbarBlock(button.tag);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(ChooseTabbarDidSelectItem:)]) {
        [_delegate ChooseTabbarDidSelectItem:button.tag];
    }
    
}

@end



