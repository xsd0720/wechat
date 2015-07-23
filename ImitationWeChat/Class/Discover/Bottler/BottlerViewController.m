//
//  BottlerViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "BottlerViewController.h"
#import "ChooseTabbar.h"
@interface BottlerViewController ()<ChooseTabbarDelegate>
{
    //漂流瓶背景图
    UIImageView *bgImageView;
    
    //捡一个背景图
    UIImageView *pickUpImageView;
    
    //bottleBoard
    UIImageView *bottleBoardImageView;
    
    //star
    UIImageView *bottleSomethingImageView;
    
    //工具栏
    ChooseTabbar *chooseTabbar;
    
    
    
}

@end

@implementation BottlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUpBgImageView];
    [self setUpBottlerBoard];
    [self setUpChooseView];
}
-(void)setUpNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"漂流瓶";
}

//加载漂流瓶背景图
-(void)setUpBgImageView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bottleBkg@2x.jpg" ofType:nil];
    bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:bgImageView];
}
//加载捡一个背景图
-(void)settUpPickUpImageView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bottleBkgSpotLight@2x.png" ofType:nil];
    pickUpImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    pickUpImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:pickUpImageView];
}
-(void)setUpBottlerBoard{
    UIImage *bottleBardImage = [UIImage imageNamed:@"bottleBoard"];
    CGFloat bottleBoardImageW = bottleBardImage.size.width;
    CGFloat bottleBoardImageH = bottleBardImage.size.height;
    bottleBoardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottleBoardImageH, bottleBoardImageW, bottleBoardImageH)];
    bottleBoardImageView.image = bottleBardImage;
    [self.view addSubview:bottleBoardImageView];
}
-(void)setUpBottleSomeThingImageView{
    UIImage *imageSomeThing = [UIImage imageNamed:@"bottleStarfish"];
    CGFloat imageSomeThingW = imageSomeThing.size.width;
    CGFloat imageSomeThingH = imageSomeThing.size.height;
    bottleSomethingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSomeThingW, imageSomeThingH)];
    bottleSomethingImageView.image = imageSomeThing;
    bottleSomethingImageView.center = self.view.center;
    [self.view addSubview:bottleSomethingImageView];
}
#pragma mark ChooseTabbar

//加载功能选择
-(void)setUpChooseView{
    chooseTabbar = [[ChooseTabbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-90, SCREEN_WIDTH, 85) subViewData:DS.bottleChooseSubViewData normalColor:[UIColor whiteColor] hightlightColor:nil];
    chooseTabbar.isSelected = NO;
    chooseTabbar.delegate = self;
    [self.view addSubview:chooseTabbar];
}

//choosetabbar delegate
-(void)ChooseTabbarDidSelectItem:(NSInteger)index{
    switch (index) {
            //扔一个
        case 0:
        {
            
        }
            break;
            //捡一个
        case 1:
        {
            [self pickUp];
        }
            break;
            //我的瓶子
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
    
}


//捡一个
-(void)pickUp{
    bottleBoardImageView.hidden = YES;
    chooseTabbar.hidden = YES;
    
    [self settUpPickUpImageView];
    [self setUpBottleSomeThingImageView];
    [self performSelector:@selector(endPickUp) withObject:nil afterDelay:2.f];
}
-(void)endPickUp{
    bottleBoardImageView.hidden = NO;
    chooseTabbar.hidden = NO;
    [pickUpImageView removeFromSuperview];
    
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
