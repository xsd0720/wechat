//
//  MJPhotoBrowser.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "SafePhotoViewController.h"
#import "SafePhoto.h"

#import "SafePhotoView.h"
//#import "CustomScrollView.h"

#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)


#import "AppDelegate.h"

@interface SafePhotoViewController ()<SafePhotoViewDelegate>
{
    // 滚动的view
	UIScrollView *_photoScrollView;
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;


}
@end

@implementation SafePhotoViewController


+(SafePhotoViewController *) sharedInstance
{
    static SafePhotoViewController *_sharedMyClass;
    static dispatch_once_t token;
    
    dispatch_once(&token,^{ _sharedMyClass = [[SafePhotoViewController alloc] init];} );
    
    return _sharedMyClass;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createScrollView];
    
    [self initData];
    
    [self showPhotos];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_delete"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_deleteClick)];
}

- (void)barbuttonicon_deleteClick
{
    [_photos removeObjectAtIndex:self.currentPhotoIndex];
    [self showPhotos];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePhotosIndex:)]) {
        [self.delegate deletePhotosIndex:self.currentPhotoIndex];
    }
}


-(void)BackToHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
    _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _photoScrollView.pagingEnabled = YES;
    _photoScrollView.delegate = self;
    _photoScrollView.showsHorizontalScrollIndicator = NO;
    _photoScrollView.showsVerticalScrollIndicator = NO;
    _photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
    _photoScrollView.bounces = NO;
    _photoScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
}

- (void)tapGesClick:(BOOL)isHidden
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController setNavigationBarHidden:isHidden animated:YES];
    });
 

}

- (void)initData
{
    _visiblePhotoViews = [NSMutableSet set];
    _reusablePhotoViews = [NSMutableSet set];
}

#pragma mark 显示照片
- (void)showPhotos
{
    [_photoScrollView removeAllSubviews];
    
    for (NSUInteger index = 0; index < _photos.count; index++)
    {
        [self showPhotoViewAtIndex:(int)index];
    }
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    SafePhotoView *photoView = [[SafePhotoView alloc] init];
    photoView.ddelegate = self;

    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    SafePhoto *photo = [[SafePhoto alloc] init];
    photo.image = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (SafePhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
           return YES;
        }
    }
	return  NO;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark 循环利用某个view
- (SafePhotoView *)dequeueReusablePhotoView
{
    SafePhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateTollbarState];
}
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    [_photoScrollView setContentOffset:CGPointMake(_photoScrollView.frame.size.width*currentPhotoIndex, 0)];
    
}

-(void)dealloc{
    [_photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_photoScrollView removeFromSuperview];
    _photos = nil;
    _visiblePhotoViews = nil;
    _reusablePhotoViews = nil;
    _photoScrollView = nil;
}
@end