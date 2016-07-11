//
//  FunXinNotDisturbTableViewCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "FunXinNotDisturbTableViewCell.h"

@implementation FunXinNotDisturbTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *im = [UIImage imageNamed:@"PaySuccess"];
        _accessViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, im.size.width, im.size.height)];
        _accessViewImageView.image = im;
        self.accessoryView = _accessViewImageView;
        
        self.accessoryView.hidden = YES;
        
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    self.textLabel.text = datasource[@"text"];
    self.textLabel.font = [UIFont systemFontOfSize:16];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    NSLog(@"%@", self.textLabel.text);
//    self.accessoryView.hidden = !selected;
//    
//    // Configure the view for the selected state
//}

@end
