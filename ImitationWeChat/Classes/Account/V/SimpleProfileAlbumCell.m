//
//  SimpleProfileAlbumCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileAlbumCell.h"
#import "UIImage+Antialiase.h"
@implementation SimpleProfileAlbumCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

- (UIView *)someAlbumView
{
    if (!_someAlbumView) {
        
        CGFloat itemSize = 55;
        CGFloat padding = 6;
        int totalCount = 3;
        
        _someAlbumView = [[UIView alloc] initWithFrame:CGRectMake(95, 15, itemSize*totalCount+padding*(totalCount-1), 110/2)];
        [self addSubview:_someAlbumView];

        for (int i=0; i<totalCount; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(itemSize*i+padding*i, 0, itemSize, itemSize)];
            [_someAlbumView addSubview:imageV];
        }
        
    }
    return _someAlbumView;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    self.textLabel.text = datasource[@"text"];
    
    NSString *type = datasource[@"type"];
    if ([type isEqualToString:@"album"]) {
        NSArray *imageArray = datasource[@"data"];
        
        for (int i=0; i< imageArray.count; i++) {
            UIImageView *imageV = [self.someAlbumView.subviews objectAtIndex:i];
            imageV.image = [UIImage scaleToSize:[UIImage imageNamed:imageArray[i]] size:imageV.bounds.size];
        }
        
        self.someAlbumView.centerY = self.height/2;
        
    }
    else if ([type isEqualToString:@"text"])
    {
        self.detailTextLabel.text = datasource[@"data"];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.frame = CGRectMake(95, 0, 250, 20);
    self.textLabel.centerY = self.height/2;
    self.detailTextLabel.centerY = self.height/2;
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.detailTextLabel.font = self.textLabel.font;
    
    
    
    
}

@end
