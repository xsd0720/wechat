//
//  WalletCollectionViewCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WalletCollectionViewCell.h"


@implementation WalletCollectionViewCell

/**
 *  初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
//        
        _iconImageView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        _iconImageView.userInteractionEnabled = NO;
        [self.contentView addSubview:_iconImageView];
        
        _iconTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        _iconTextLabel.textColor = RGBCOLOR(129, 129, 129);
        _iconTextLabel.font = [UIFont systemFontOfSize:13];
        _iconTextLabel.textAlignment = 1;
        [self.contentView addSubview:_iconTextLabel];
        
        _iconImageView.center = CGPointMake(frame.size.width/2, frame.size.height/3);
        _iconTextLabel.center = CGPointMake(frame.size.width/2, frame.size.height/3*2);

    }
    
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    NSString *imageName = datasource[@"image"];
    NSString *text = datasource[@"text"];
    
    [_iconImageView setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    _iconImageView.image = [UIImage imageNamed:imageName];
    _iconTextLabel.text = text;
    
}


//
//- (void)drawRect:(CGRect)rect {
//    // Drawing code.
//    //获得处理的上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //设置线条样式
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    //设置线条粗细宽度
//    CGContextSetLineWidth(context, 1.0);
//    
//    //设置颜色
//    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//    //开始一个起始路径
//    CGContextBeginPath(context);
//    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
//    CGContextMoveToPoint(context, rect.size.width, 0);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 0, rect.size.height);
////    //设置下一个坐标点
////    CGContextAddLineToPoint(context, 50, 180);
//    //连接上面定义的坐标点
//    CGContextStrokePath(context);
//}

@end
