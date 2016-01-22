//
//  MJZoomingScrollView.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SafePhotoViewController, SafePhoto, SafePhotoView;

@protocol SafePhotoViewDelegate <NSObject>

- (void)tapGesClick:(BOOL)isHidden;

@end

@interface SafePhotoView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) SafePhoto *photo;

@property (nonatomic, assign) id<SafePhotoViewDelegate> ddelegate;

@end