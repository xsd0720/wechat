//
//  MyTabBarController.m
//  FitTiger
//
//  Created by 李清青 on 15/6/2.
//  Copyright (c) 2015年 PanghuKeji. All rights reserved.
//

#import "MyTabBarController.h"
#import "WXViewController.h"
#import "ContactViewController.h"
#import "FoundViewController.h"
#import "MyViewController.h"

#import "MyNavViewController.h"


#import "KYCuteView.h"
#import "TabBarItem.h"
#define BUTTONWIDTH         (SCREEN_WIDTH/self.viewControllers.count)
#define TABBARITEM_LABELHEIGHT      12


@interface MyTabBarController ()
{
    WXViewController* wxVC;
    ContactViewController *contactVC;
    FoundViewController *foundVC;
    MyViewController *myVC;

    
    UIImageView *tabbarImageView;
    //可删除泡泡
    KYCuteView *cuteView;
}
@property (nonatomic,strong) NSMutableArray *tabbarButtonArray;

@end

@implementation MyTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarBackground];
    [self createViewControllers];
    [self createTabBarItems];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)createTabBarBackground{
    UIImageView  *customView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    customView.userInteractionEnabled = YES;
    UIImage *tbbarBg = [UIImage imageWithContentsOfFile:@"tabbarBkg@2x.png"];
    [tbbarBg stretchableImageWithLeftCapWidth:0.f topCapHeight:0.f];
    customView.image = tbbarBg;
    [self.tabBar addSubview:customView];
}

-(void)createTabBarItems{
    

    _tabbarButtonArray = [NSMutableArray array];
    for (int i=0 ; i<self.viewControllers.count; i++)
    {
        TabBarItem *tabbrItem = [[TabBarItem alloc] initWithFrame:CGRectMake(i*BUTTONWIDTH,0, BUTTONWIDTH, self.tabBar.frame.size.height)];
        [tabbrItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        

        tabbrItem.button.frame = CGRectMake(0,0, BUTTONWIDTH, self.tabBar.frame.size.height-TABBARITEM_LABELHEIGHT);
        [tabbrItem.button setImage:[UIImage imageNamed:DS.tabbarNormalImageArray[i]] forState:UIControlStateNormal];
        [tabbrItem.button setImage:[UIImage imageNamed:DS.tabbarHlImageArray[i]] forState:UIControlStateSelected];
        tabbrItem.label.text = DS.tabbarTitleArray[i];
        tabbrItem.label.frame  = CGRectMake(0, tabbrItem.frame.size.height-TABBARITEM_LABELHEIGHT, BUTTONWIDTH, 8);
        [self.tabBar addSubview:tabbrItem];

        
        tabbrItem.tag = i;

        [_tabbarButtonArray addObject:tabbrItem];
        if (tabbrItem.tag == self.selectedIndex) {
            tabbrItem.selected = YES;
        }
        if (i == 0) {
            cuteView = [[KYCuteView alloc]initWithPoint:CGPointMake(tabbrItem.center.x+10.f, 0) superView:tabbrItem];
            cuteView.viscosity  = 20;
            cuteView.bubbleWidth = 20;
            cuteView.bubbleColor = [UIColor redColor];
            [cuteView setUp];
            [cuteView addGesture];
            
            //注意：设置 'bubbleLabel.text' 一定要放在 '-setUp' 方法之后
            //Tips:When you set the 'bubbleLabel.text',you must set it after '-setUp'
            cuteView.bubbleLabel.text = @"3";

        }
    }
}

-(void)buttonClick:(UIButton *)sender{
    
    if (sender.tag == self.selectedIndex) {
        return;
    }
    
    //选中当前
    [_tabbarButtonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *bt = (UIButton *)obj;
        bt.selected = NO;
    }];
    
    sender.selected = YES;
    self.selectedIndex = sender.tag;
}
-(void)createViewControllers{
    
    //微信
    wxVC=[[WXViewController alloc]init];
    MyNavViewController *nc1=[[MyNavViewController alloc]initWithRootViewController:wxVC];
    
    //联系人
    contactVC=[[ContactViewController alloc]init];
    MyNavViewController *nc2=[[MyNavViewController alloc]initWithRootViewController:contactVC];
    
    //发现
    foundVC=[[FoundViewController alloc]init];
    MyNavViewController *nc3=[[MyNavViewController alloc]initWithRootViewController:foundVC];
    
    //我的
    myVC=[[MyViewController alloc]init];
    MyNavViewController *nc4=[[MyNavViewController alloc]initWithRootViewController:myVC];


    //
    self.viewControllers=@[nc1,nc2,nc3,nc4];
}

@end




