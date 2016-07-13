//
//  PresentAnimator.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "PresentAnimator.h"

@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *circleView = [[UIView alloc] initWithFrame:self.startRect];
    circleView.layer.cornerRadius = self.startRect.size.width/2;
    circleView.backgroundColor = self.startViewColor;
    [[transitionContext containerView] addSubview:circleView];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
   
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //        fromViewController.view.transform = CGAffineTransformMakeRotation(180);
        circleView.transform = CGAffineTransformMakeScale(10, 10);
        circleView.alpha = 0;
        toViewController.view.alpha = 1;
        fromViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [circleView removeFromSuperview];
        fromViewController.view.alpha = 1;
//        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
