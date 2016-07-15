//
//  CustomSearchViewController.h
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSearchViewController : UISearchController<UISearchBarDelegate>

@property (nonatomic, assign) BOOL isAddFriendsController;

- (void)setUpSearBarFuGaiView;

@end
