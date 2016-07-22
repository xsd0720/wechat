//
//  TimelineMsgTypeImageCell.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineBaseCell.h"

#define timeLineCollectionItemSize      75.0f
#define timeLineCollectionItemPadding   5.0f

@interface TimelineMsgTypeImageCell : TimelineBaseCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *moreImageCollectionView;

@end
