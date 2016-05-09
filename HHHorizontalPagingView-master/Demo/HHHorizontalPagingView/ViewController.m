//
//  ViewController.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "ViewController.h"
#import "HHHorizontalPagingView.h"
#import "HHHeaderView.h"
#import "HHContentTableView.h"
#import "HHContentCollectionView.h"
#import "HHContentScrollView.h"

@interface ViewController ()
{
    UIButton *button;
    
    NSLayoutConstraint *topConstraint;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HHHeaderView *headerView                = [HHHeaderView headerView];
    HHContentTableView *tableView           = [HHContentTableView contentTableView];
    HHContentCollectionView *collectionView = [HHContentCollectionView contentCollectionView];
    HHContentScrollView *scrollView         = [HHContentScrollView contentScrollView];
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 3; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
        [segmentButton setTitle:[NSString stringWithFormat:@"view%@",@(i)] forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [buttonArray addObject:segmentButton];
    }
    HHHorizontalPagingView *pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:headerView headerHeight:300.f segmentButtons:buttonArray segmentHeight:60 contentViews:@[tableView, collectionView, scrollView]];
//    pagingView.segmentButtonSize = CGSizeMake(60., 30.);              //自定义segmentButton的大小
//    pagingView.segmentView.backgroundColor = [UIColor grayColor];     //设置segmentView的背景色
    
    //设置需放大头图的top约束
    /*
    pagingView.magnifyTopConstraint = headerView.headerTopConstraint;
    [headerView.headerImageView setImage:[UIImage imageNamed:@"headerImage"]];
    [headerView.headerImageView setContentMode:UIViewContentModeScaleAspectFill];
     */
    
    [self.view addSubview:pagingView];
    
    
//    button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"1231412414" forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
//    [self.view addSubview:button];
//    button.translatesAutoresizingMaskIntoConstraints= NO;
//    
//    
////    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
////    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
////    topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100];
////    [button addConstraint:topConstraint];
//    
//    topConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100];
//    [button addConstraint:topConstraint];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    topConstraint.constant ++;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
