//
//  CycleScrollView.m
//  CycleScrollView
//
//  Created by lin wu on 6/25/15.
//  Copyright (c) 2015 lin wu. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+CycleScrollView.h"

@interface CycleScrollView () <UIScrollViewDelegate>
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIPageControl *pageView;            //添加pageView
@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount {
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        if (_totalPageCount == 1) {
            [self configContentViews];
            self.pageView.numberOfPages = 0;             // page 的总个数
            [self.animationTimer pauseTimer];
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        }
        else
        {
            [self configContentViews];
            self.pageView.numberOfPages = _totalPageCount;             // page 的总个数
            [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
            self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));

        }
        
        
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration {
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (void)setUpCycleScrollViewImageWith:(NSArray *)images {

    if (images.count>0) {
        self.isBeginRefresh = YES;
        self.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            return images[pageIndex];
        };
        self.totalPagesCount = ^NSInteger(void){
            return images.count;
        };
        self.isBeginRefresh = NO;
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
//        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        //page
        self.pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+self.bounds.size.height/10 *9, self.bounds.size.width, self.bounds.size.height/10)];
        self.pageView.currentPage = 0;
        self.pageView.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.pageView];
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    if (_totalPageCount == 1) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }else
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
    
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource {
    
    if (_totalPageCount == 1) {
        if (self.contentViews == nil) {
            self.contentViews = [@[] mutableCopy];
        }
        [self.contentViews removeAllObjects];
        
        if (self.fetchContentViewAtIndex) {
            [self.contentViews addObject:self.fetchContentViewAtIndex(0)];
        }

    }
    else if(_totalPageCount == 2)
    {
        NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        if (self.contentViews == nil) {
            self.contentViews = [@[] mutableCopy];
        }
        [self.contentViews removeAllObjects];
        
        if (self.fetchContentViewAtIndex) {
            
            //上一个
            CycleImageView *preView = (CycleImageView *)self.fetchContentViewAtIndex(previousPageIndex);
            CycleImageView *preImageView = [[CycleImageView alloc] initWithFrame:preView.frame];
//            preImageView.image = preView.image;
            [preImageView.bgPicImageView sd_setImageWithURL:preView.bgPicImageView.sd_imageURL placeholderImage:nil];
//            [preImageView.logoImageView sd_setImageWithURL:preView.logoImageView.sd_imageURL placeholderImage:nil];
            
            //当前
            CycleImageView *currentView = (CycleImageView *)self.fetchContentViewAtIndex(_currentPageIndex);
            CycleImageView *currentImageView = [[CycleImageView alloc] initWithFrame:currentView.frame];
//            currentImageView.image = currentView.image;
            [currentImageView.bgPicImageView sd_setImageWithURL:currentView.bgPicImageView.sd_imageURL placeholderImage:nil];
//            [currentImageView.logoImageView sd_setImageWithURL:currentView.logoImageView.sd_imageURL placeholderImage:nil];
            
            
            //下一个
            CycleImageView *nextView = (CycleImageView *)self.fetchContentViewAtIndex(rearPageIndex);
            CycleImageView *nextImageView = [[CycleImageView alloc] initWithFrame:nextView.frame];
//            nextImageView.image = nextView.image;
            [nextImageView.bgPicImageView sd_setImageWithURL:nextView.bgPicImageView.sd_imageURL placeholderImage:nil];
//            [nextImageView.logoImageView sd_setImageWithURL:nextView.logoImageView.sd_imageURL placeholderImage:nil];
            
            
            [self.contentViews addObject:preImageView];
            [self.contentViews addObject:currentImageView];
            [self.contentViews addObject:nextImageView];
        }

    }
    else
    {
        NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        if (self.contentViews == nil) {
            self.contentViews = [@[] mutableCopy];
        }
        [self.contentViews removeAllObjects];
        
        if (self.fetchContentViewAtIndex) {
            [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        }
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex {
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_totalPageCount > 1) {
       [self.animationTimer pauseTimer];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isBeginRefresh) {
        return;
    }
    if (_totalPageCount>1) {
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isBeginRefresh) {
        return;
    }
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isBeginRefresh) {
        return;
    }
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
    self.pageView.currentPage = self.currentPageIndex;  // page 当前显示的页数；
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer {
    if (self.isBeginRefresh) {
        return;
    }
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
    /**
     *  设置自动滚动时page的显示页数
     */
    if (self.currentPageIndex + 1 == self.totalPageCount) {
        self.pageView.currentPage = 0;
    }else{
        self.pageView.currentPage = self.currentPageIndex + 1;
    }
    
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickIndex:)]) {
        [self.delegate didClickIndex:self.currentPageIndex];
    }
}

//销毁timer
- (void)deallocTimer
{
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

//暂停timer
- (void)bannerPauseTimer
{
    if (self.animationTimer && _totalPageCount != 1) {
        [self.animationTimer pauseTimer];
    }
}

//恢复timer
- (void)bannerResumTimer
{
    if (self.animationTimer && _totalPageCount != 1) {
        [self.animationTimer resumeTimer];
    }
}

- (void)initTimer
{
    [self deallocTimer];
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration
                                                           target:self
                                                         selector:@selector(animationTimerDidFired:)
                                                         userInfo:nil
                                                          repeats:YES];
}


- (void)setIsBeginRefresh:(BOOL)isBeginRefresh
{
    _isBeginRefresh = isBeginRefresh;
    if (_totalPageCount != 1) {
        if (isBeginRefresh) {
            [self deallocTimer];
            self.currentPageIndex = 0;
            self.pageView.currentPage = 0;
        }else
        {
            [self initTimer];
        }

    }
}

- (void)dealloc
{
    NSLog(@"cycleScrollview dealloc");
}

@end
