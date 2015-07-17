//
//  LoadingViewController.m
//  ImitationWeChat
//
//  Created by wany on 14/12/12.
//  Copyright (c) 2014年 wany. All rights reserved.
//

#import "LoadingViewController.h"
#import "MyTabBarController.h"
#import "Animator.h"


@interface LoadingViewController ()<UIViewControllerTransitioningDelegate>
{
    UIImageView *imageLoading;
}

@property (nonatomic,copy) Animator *animator;

@end

@implementation LoadingViewController
-(Animator *)animator{
    if (!_animator) {
        _animator = [Animator new];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    imageLoading = [[UIImageView alloc] initWithFrame:self.view.frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LaunchImage@2x.png" ofType:nil];
    [imageLoading setImage:[UIImage imageWithContentsOfFile:path]];
    [self.view addSubview:imageLoading];
    
    


    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    int64_t delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        MyTabBarController *homeVC = [[MyTabBarController alloc] init];
        homeVC.transitioningDelegate = self;
        [self presentViewController:homeVC animated:YES completion:nil];
    });
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animator;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [imageLoading removeFromSuperview];
    imageLoading = nil;
    self.animator = nil;

}
//-(void)dealloc{
//
//}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


