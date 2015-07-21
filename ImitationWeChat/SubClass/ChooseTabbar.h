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

/**
 *
 *@param  datasouce tabbar子view 数据
 *
 *
 **/

-(instancetype)initWithFrame:(CGRect)frame subViewData:(NSArray *)datasouce;
@end
