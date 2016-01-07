//
//  CustomSearchViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "CustomSearchViewController.h"

@interface CustomSearchViewController ()

@property (nonatomic, strong) UIView *searchBarBackground;

@end

@implementation CustomSearchViewController


-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
//        self.view.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;

        
//        self.searchBarBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
//        self.searchBarBackView.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;
//
//        
//        self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.placeholder = @"搜索";
//        self.searchBar.frame = self.searchBarBackView.bounds;
        self.searchBar.backgroundImage = [UIImage new];
        self.searchBar.scopeBarBackgroundImage = [UIImage new];
        self.searchBar.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;
        self.searchBar.barTintColor = NAVGATIONBAR_BARTINTCOLOR;
        self.searchBar.layer.borderColor = [NAVGATIONBAR_BARTINTCOLOR CGColor];
        self.searchBar.layer.borderWidth = 1;
        self.searchBar.delegate = self;
//        [self.searchBarBackView addSubview:self.searchBar];
//        self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

        

    }
    return self;
    
}

- (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame
{
    aFrame = CGRectMake(0, 0, aFrame.size.width, aFrame.size.height);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    for(UIView *view in  [[[self.searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UISearchBarBackground") class]]) {
            view.backgroundColor = [UIColor redColor];
            
        }
    }
    
    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    tempTabBarController.tabBar.hidden = YES;
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [UIView animateWithDuration:0.1 animations:^{
//        tempNavigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -64);
//        [tempNavigationController setNavigationBarHidden:YES animated:YES];
//        self.searchBarBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//        self.searchBarBackView.superview.transform = CGAffineTransformMakeTranslation(0, -64);
//        self.searchBar.showsCancelButton = YES;
//        
//        for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
//            if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
//                UIButton * cancel =(UIButton *)view;
//                [cancel setTitle:@"取消" forState:UIControlStateNormal];
//                [cancel setTitleColor:RGBCOLOR(67, 167, 67) forState:UIControlStateNormal];
//            }
//        }
//    }];
    
    
    
    
//    for(id cc in [searchBar.subviews[0] subviews])
//    {
//        if([cc isKindOfClass:[UIButton class]])
//        {
//            UIButton *btn = (UIButton *)cc;
//            [btn setTitle:@"取消"  forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//    }

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
//            if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
//                UIButton * cancel =(UIButton *)view;
//                [cancel setTitle:@"取消" forState:UIControlStateNormal];
//                [cancel setTitleColor:RGBCOLOR(67, 167, 67) forState:UIControlStateNormal];
//            }
//        }
//    });
    
  
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    tempTabBarController.tabBar.hidden = NO;
//    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
//    UINavigationController *tempNavigationController = (UINavigationController *)tempTabBarController.selectedViewController;
//    [UIView animateWithDuration:0.1 animations:^{
//        tempNavigationController.navigationBar.transform = CGAffineTransformIdentity;
//        self.searchBarBackView.superview.transform = CGAffineTransformIdentity;
//        [tempNavigationController setNavigationBarHidden:NO animated:YES];
//        self.searchBarBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.0f);
//        self.searchBar.showsCancelButton = NO;
//    } completion:^(BOOL finished) {
//        BOOL r = self.searchBar.resignFirstResponder;
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.searchBar.delegate = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
