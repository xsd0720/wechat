//
//  TimelineCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/20.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>


#define timeLineImageOrginX         9.0f
#define timeLineImageOrginY         15.0f
#define timeLineImageSize           45.0f

#define timeLineTextLabelOrginX  (timeLineImageOrginX+timeLineImageSize+10)
#define timeLineTextLabelOrginY  (timeLineImageOrginY)
#define timeLineTextLabelWidth   (SCREEN_WIDTH-timeLineTextLabelOrginX-20)
#define timeLineTextLabelHeight     15.0f

#define timeLineDetailTextLabelFont     [UIFont systemFontOfSize:13]
#define timeLineDetailTextLabelOrginX   timeLineTextLabelOrginX
#define timeLineDetailTextLabelOrginY   (timeLineTextLabelOrginY+timeLineTextLabelHeight+7)
#define timeLineDetailTextLabelWidth    timeLineTextLabelWidth
#define timeLineDetailTextLabelMaxHeight    105.0f

#define onlyImageViewMaxSize            150.0f
#define timeLineCollectionItemSize      75.0f
#define timeLineCollectionItemPadding   5.0f

#define timeLineTimeLabelHeight     15.0f

@interface TimelineCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSDictionary *datasource;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *delButton;

@property (nonatomic, strong) UIImageView *onlyImageView;

//@property (nonatomic, strong) UIView *moreImageView
@property (nonatomic, strong)  UICollectionView *moreImageCollectionView;

@property (nonatomic, strong) UIView *playView;

@property (nonatomic, strong) UIView *linkView;



@end
