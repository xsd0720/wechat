//
//  CycleScrollView.h
//  CycleScrollView
//
//  Created by lin wu on 6/25/15.
//  Copyright (c) 2015 lin wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "CycleImageView.h"

/*
 
 使用示例
 CGRect bound = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-4);
 //
 //    NSMutableArray *viewsArray = [@[] mutableCopy];
 //    for (int i = 0; i < self.bannersArray.count; ++i) {
 //        BannerModel *model = self.bannersArray[i];
 //        CycleImageView *tempImage = [[CycleImageView alloc] initWithFrame:bound];
 //        [tempImage.bgPicImageView sd_setImageWithURL:[NSURL URLWithString:model.bgpicurl] placeholderImage:nil];
 ////        [tempImage.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logourl] placeholderImage:nil];
 //
 //        [viewsArray addObject:tempImage];
 //    }
 //
 //    if (self.mainScorllView) {
 //        [self.mainScorllView setUpCycleScrollViewImageWith:viewsArray];
 //        return;
 //    }
 //    //初始化控件
 //    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:bound animationDuration:4];
 //    self.mainScorllView.delegate = self;
 //    self.mainScorllView.isBeginRefresh = YES;
 //    [self.mainScorllView setUpCycleScrollViewImageWith:viewsArray];
 //    self.mainScorllView.isBeginRefresh = NO;
 //
 //    [self addSubview:self.mainScorllView];
 
 
 */

@protocol CycleScrollViewDelegate <NSObject>

- (void)didClickIndex:(NSInteger)index;

@end

@interface CycleScrollView : UIView
@property (nonatomic, assign) BOOL isBeginRefresh;

@property (nonatomic, assign) id<CycleScrollViewDelegate> delegate;

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
    数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
    数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
    当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
/**
 *  图片添加到CycleScrollView
 *
 *  @param images
 */
- (void)setUpCycleScrollViewImageWith:(NSArray *)images;

//销毁timer
- (void)deallocTimer;

//暂停timer
- (void)bannerPauseTimer;

//恢复timer
- (void)bannerResumTimer;

- (void)initTimer;

@end
