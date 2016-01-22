//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol SafePhotoViewControllerDelegate <NSObject>

- (void)deletePhotosIndex:(NSInteger)index;

@end

@interface SafePhotoViewController : BaseViewController <UIScrollViewDelegate>

// 所有的图片对象
@property (nonatomic, strong) NSMutableArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSString * content;

@property (nonatomic,strong) UIViewController *viewController;

@property (nonatomic, assign) NSInteger firstShowIndex;

@property (nonatomic, assign) id<SafePhotoViewControllerDelegate> delegate;

+(SafePhotoViewController *) sharedInstance;
@end

