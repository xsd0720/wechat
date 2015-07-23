//
//  ChooseView.h
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseTabbarBlock)(NSInteger index);

@protocol ChooseTabbarDelegate <NSObject>

@required
-(void)ChooseTabbarDidSelectItem:(NSInteger)index;

@end



@interface ChooseTabbar : UIView
@property (nonatomic,strong)NSMutableArray *chooseItemArray;

@property (nonatomic,copy) ChooseTabbarBlock chooseTabbarBlock;

@property (nonatomic,assign) id<ChooseTabbarDelegate> delegate;

@property (nonatomic,copy) UIColor *labelTextColor;
@property (nonatomic,copy) UIColor *labelTextHLColor;

@property (nonatomic,assign) CGFloat *fontSize;

@property (nonatomic,assign) BOOL isSelected;

/**
 *
 *@param  datasouce tabbar子view 数据
 *@param  normalColor  文字颜色
 *@param  hightlightColor 文字高亮颜色
 **/

-(instancetype)initWithFrame:(CGRect)frame subViewData:(NSArray *)datasouce normalColor:(UIColor *)normalColor hightlightColor:(UIColor *)hightlightColor;
@end
