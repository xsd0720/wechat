//
//  TimelineMsgTypeWebCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineMsgTypeWebCell.h"


@interface LinkView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *title;

@end

@implementation LinkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        //add the show imageview
        [self addSubview:self.imageView];
        
        //add the sow label
        [self addSubview:self.label];
        
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.label.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.centerY = self.height/2;
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+5, 0, self.width-CGRectGetMaxX(self.imageView.frame)-5, 40);
    self.label.centerY = self.height/2;
}

@end



@interface TimelineMsgTypeWebCell()

@property (nonatomic, strong) LinkView *linkView;

@end

@implementation TimelineMsgTypeWebCell

- (LinkView *)linkView
{
    if (!_linkView) {
        _linkView = [[LinkView alloc] initWithFrame:CGRectZero];
        _linkView.backgroundColor = RGB(243, 243, 244);
        [self addSubview:_linkView];
    }
    return _linkView;
}


- (void)setDatasource:(NSDictionary *)datasource
{
    [super setDatasource:datasource];
    
    NSDictionary *dic = datasource[WXMessageTypeDataKey][0];
    NSString *imageName = dic[@"image"];
    NSString *text = dic[@"text"];
    
    
    
    self.linkView.imageName = imageName;
    self.linkView.title = text;
    
}

- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY
{
    
    self.linkView.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+MsgTypeMarginTop, SCREEN_WIDTH-CGRectGetMinX(self.textLabel.frame)-10, 50);
    
    return CGRectGetMaxY(self.linkView.frame);
}

@end
