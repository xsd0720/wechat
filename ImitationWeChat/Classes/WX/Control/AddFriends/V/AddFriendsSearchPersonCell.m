//
//  AddFriendsPersonCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "AddFriendsSearchPersonCell.h"
#import "UIImage+Antialiase.h"
@implementation AddFriendsSearchPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.textColor = RGB(166, 166, 166);
        self.detailTextLabel.numberOfLines = 0;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
        self.imageView.layer.cornerRadius = 5;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    self.textLabel.text = datasource[@"text"];
    self.detailTextLabel.text = datasource[@"dText"];
    
    UIImage *im = [UIImage imageNamed:datasource[@"image"]];
    self.imageView.image = [im scaleToSize:im size:CGSizeMake(45, 45)];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.detailTextLabel.height = 40;
    self.imageView.frame = CGRectMake(15, 10, 45, 45);
    
    CGFloat textLabelOrginX = CGRectGetMaxX(self.imageView.frame) + 10;
    CGFloat textLabelWidth = SCREEN_WIDTH-textLabelOrginX-20;
    self.textLabel.frame = CGRectMake(textLabelOrginX, self.imageView.originY + 5, textLabelWidth, 20);
    
    CGFloat detailTextLabelHeight = [self.detailTextLabel.text CalculationStringSizeWithWidth:textLabelWidth font:self.detailTextLabel.font space:0].height;
    self.detailTextLabel.frame = CGRectMake(textLabelOrginX, CGRectGetMaxY(self.textLabel.frame), textLabelWidth, MIN(detailTextLabelHeight, 30));

    
}

@end
