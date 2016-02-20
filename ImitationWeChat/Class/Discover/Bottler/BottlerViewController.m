//
//  BottlerViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "BottlerViewController.h"
#import "ChooseTabbar.h"
#import "WaterPointControl.h"
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
    
    //bottle
    UIButton *bottleButton;
    
    //工具栏
    ChooseTabbar *chooseTabbar;
    
    //水花
    UIImageView *fishWaterImageView;
    
}

@property (nonatomic, strong) WaterPointControl *waterPointControl;

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
    
    pickUpImageView.alpha = 0.5;
    [UIView animateWithDuration:0.2 animations:^{
        pickUpImageView.alpha = 1;
    }];
    
    
    [self setUpFishWater];
    
    //创建椭圆，产生随机坐标
    self.waterPointControl = [[WaterPointControl alloc] initOvalInRect:CGRectMake(55*self.view.bounds.size.width/320, 270*self.view.bounds.size.height/568, 210*self.view.bounds.size.width/320, 75*self.view.bounds.size.height/568)];
    
    
    
    
}
-(void)setUpBottlerBoard{
    UIImage *bottleBardImage = [UIImage imageNamed:@"bottleBoard"];
    CGFloat bottleBoardImageW = bottleBardImage.size.width;
    CGFloat bottleBoardImageH = bottleBardImage.size.height;
    bottleBoardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-bottleBoardImageH, bottleBoardImageW, bottleBoardImageH)];
    bottleBoardImageView.image = bottleBardImage;
    [self.view addSubview:bottleBoardImageView];
}
- (void)setUpBottleSomeThingImageView{
    
    
    
    UIImage *imageSomeThing = [UIImage imageNamed:@"bottleStarfish"];
    CGFloat imageSomeThingW = imageSomeThing.size.width;
    CGFloat imageSomeThingH = imageSomeThing.size.height;
    bottleSomethingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSomeThingW, imageSomeThingH)];
    bottleSomethingImageView.image = imageSomeThing;
    bottleSomethingImageView.center = self.view.center;
    [self.view addSubview:bottleSomethingImageView];
    
    //添加动画
    [self addAnimationToLayer:bottleSomethingImageView.layer];
}

- (void)setUpBottleButton
{
    //随机判断产生语音的还是文字的
    NSString *imageName = @"bottleWriting";
    int random = arc4random()%5;
    if (random-3==0) {
        imageName = @"bottleRecord";
    }
    UIImage *bottleImage = [UIImage imageNamed:imageName];
    CGFloat bottleImageW = bottleImage.size.width;
    CGFloat bottleImageH = bottleImage.size.height;
    bottleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottleButton setImage:bottleImage forState:UIControlStateNormal];
    bottleButton.frame = CGRectMake(0, 0, bottleImageW, bottleImageH);
    bottleButton.center = self.view.center;
    [bottleButton addTarget:self action:@selector(bottleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottleButton];
    
    //添加动画
    [self addAnimationToLayer:bottleButton.layer];
}

- (void)addAnimationToLayer:(CALayer *)layer
{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.2];
    momAnimation.toValue = [NSNumber numberWithFloat:0.2];
    momAnimation.duration = 1;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.autoreverses = YES;
    momAnimation.delegate = self;
    [layer addAnimation:momAnimation forKey:@"animateLayer"];
    

    CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration = 1.0;
    theAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    theAnimation.toValue =[NSNumber numberWithFloat:0.5];
    theAnimation.autoreverses = YES;
    theAnimation.repeatCount = CGFLOAT_MAX;
    [layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    //4秒后消失
    [self performSelector:@selector(disAppearBottoleSomething) withObject:nil afterDelay:4];
}

//加载水花动画
- (void)setUpFishWater
{
    
    fishWaterImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WATERIMAGEVIEWWIDTH, WATERIMAGEVIEWHEIGHT)];
    [self.view addSubview:fishWaterImageView];
    
    //设置动画帧
    fishWaterImageView.animationImages=[NSArray arrayWithObjects:
                             [UIImage imageNamed:@"fishwater"],
                             [UIImage imageNamed:@"fishwater2"],
                             [UIImage imageNamed:@"fishwater3"], nil];
    
    //设置动画总时间
    fishWaterImageView.animationDuration = 0.8;
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
    //隐藏工具栏
    bottleBoardImageView.hidden = YES;
    chooseTabbar.hidden = YES;
    
    //添加打渔图
    [self settUpPickUpImageView];

    //设置水花产生坐标
    fishWaterImageView.center = [self.waterPointControl getRandomPoint];

    //水花开始迸溅
    [fishWaterImageView startAnimating];
    
    //2s 后出现水花消失，出现打捞物
    [self performSelector:@selector(endPickUp) withObject:nil afterDelay:1.f];

}
-(void)endPickUp{
    //停止水花动画
    [fishWaterImageView stopAnimating];
    
    //随机生成星星或者瓶子
    int random = arc4random()%10;
    if (random%3 == 0) {
        [self setUpBottleSomeThingImageView];
    }else
    {
       [self setUpBottleButton];
    }
    
}

- (void)disAppearBottoleSomething
{
    if (bottleSomethingImageView.superview) {
        [pickUpImageView.layer removeAllAnimations];
        //移除遮罩
        [pickUpImageView removeFromSuperview];
        //显示工具栏
        bottleBoardImageView.hidden = NO;
        chooseTabbar.hidden = NO;
        [bottleSomethingImageView removeFromSuperview];
    }
    else if(bottleButton.superview)
    {
        [bottleButton.layer removeAllAnimations];
    }
   
}

- (void)bottleButtonClick
{
    //移除遮罩
    [pickUpImageView removeFromSuperview];
    //显示工具栏
    bottleBoardImageView.hidden = NO;
    chooseTabbar.hidden = NO;
    [bottleButton removeFromSuperview];
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
