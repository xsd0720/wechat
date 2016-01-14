//
//  ShakeViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakeSettingViewController.h"
#import "ChooseTabbar.h"
#import "ShakeHalfView.h"
#import "ShakeMusicViewController.h"
static CGFloat moveDistance = 100.f;
static CGFloat moveAnimationDuring = 0.3f;
static CGFloat moveAnimationStopDuring = 0.1f;

@interface ShakeViewController ()<ChooseTabbarDelegate>
{
    UIImageView *imageViewWomen;
    
    ShakeHalfView *shake_frameinfo_Up;
    ShakeHalfView *shake_frameinfo_Down;
    
    
    ChooseTabbar *chooseTabbar;
}

@property (nonatomic) BOOL isBeginShake;


@property (nonatomic,strong) NSMutableArray *chooseItemArray;

@end

@implementation ShakeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    [self setUpShakeUI];
    [self setUpChooseView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginShakeing) name:@"shake" object:nil];
    
}

-(void)setUpNav{
    self.navigationItem.title = @"摇一摇";
    self.view.backgroundColor = RGBCOLOR(47, 50, 50);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(Setting)];
    
}
-(void)Setting{
    ShakeSettingViewController *shakeSettingVC = [[ShakeSettingViewController alloc] init];
    shakeSettingVC.changeBgImageBlock = ^(UIImage *bgImage){
        imageViewWomen.image = bgImage;
    };
    [self.navigationController pushViewController:shakeSettingVC animated:YES];
}
//摇一摇UI
-(void)setUpShakeUI{
    
    
    CGFloat CurrentScreenHeight = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
    
    
    
    //摇一摇背景图
    imageViewWomen = [[UIImageView alloc] initWithFrame:CGRectMake(0, (CurrentScreenHeight-SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ShakeBgImagePath]) {
        imageViewWomen.image = [UIImage imageWithContentsOfFile:ShakeBgImagePath];
    }else{
        imageViewWomen.image = [UIImage imageNamed:@"ShakeHideImg_women"];
    }
    [self.view addSubview:imageViewWomen];
    
    //上frame
    shake_frameinfo_Up = [[ShakeHalfView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CurrentScreenHeight/2) direction:ShakeDirectionUp shakeLogoIVName:@"Shake_Logo_Up" shakeLineIVName:@"Shake_Line_Up"];
    
    [self.view addSubview:shake_frameinfo_Up];
    
    //下frame
    shake_frameinfo_Down = [[ShakeHalfView alloc] initWithFrame:CGRectMake(0,CurrentScreenHeight/2, SCREEN_WIDTH, CurrentScreenHeight/2) direction:ShakeDirectionDown shakeLogoIVName:@"Shake_Logo_Down" shakeLineIVName:@"Shake_Line_Down"];
    [self.view addSubview:shake_frameinfo_Down];
    
    
    //没有开始晃动
    self.isBeginShake = NO;
    
}

#pragma mark - chooseTabbar
//加载功能选择
-(void)setUpChooseView{
    chooseTabbar = [[ChooseTabbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 60) subViewData:DS.shakeChooseSubViewData  normalColor:[UIColor grayColor] hightlightColor:RGBCOLOR(72, 165, 15)];
    [self.view addSubview:chooseTabbar];
    
}

-(void)ChooseTabbarDidSelectItem:(NSInteger)index{
    switch (index) {
            //人
        case 0:
        {
            
        }
            break;
            //音乐
        case 1:
        {
            
        }
            break;
            //电视
        case 2:
        {
            
        }
            break;
        default:
            break;
    }

}

-(void)setIsBeginShake:(BOOL)isBeginShake{
    
    imageViewWomen.hidden = !isBeginShake;
    shake_frameinfo_Up.shakeLineIV.hidden = !isBeginShake;
    shake_frameinfo_Down.shakeLineIV.hidden = !isBeginShake;
}


//开始摇一摇
-(void)beginShakeing{
   
    

    
//    //让shake_line_Up上下移动
//    CABasicAnimation *translationUp = [CABasicAnimation animationWithKeyPath:@"position"];
//    translationUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    translationUp.fromValue = [NSValue valueWithCGPoint:shake_frameinfo_Up.center];
//    translationUp.toValue = [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Up.center.x, shake_frameinfo_Up.center.y-moveDistance)];
//    translationUp.duration = moveAnimationDuring;
//    translationUp.repeatCount = 1;
////    translationUp.fillMode = kCAFillModeForwards;
//    translationUp.autoreverses = YES;
//    
//    //让shake_logo_Down上下移动
//    CABasicAnimation *translationDown = [CABasicAnimation animationWithKeyPath:@"position"];
//    translationDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    translationDown.fromValue = [NSValue valueWithCGPoint:shake_frameinfo_Down.center];
//    translationDown.toValue = [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Down.center.x, shake_frameinfo_Down.center.y+moveDistance)];
//    translationDown.duration = moveAnimationDuring;
//    translationDown.repeatCount = 1;
//    translationDown.delegate = self;
//    translationDown.autoreverses = YES;
    
    //每一帧的时间差时间差(某一帧时间为后者减前者)
    /*
     
    keyTimes 该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结合。例如，你可以传入{0.0, 0.1,0.6,0.7,1.0}，其中首尾必须分别是0和1，因此tAB=0.1-0, tCB=0.6-0.1, tDC=0.7-0.6, tED=1-0.7.....
     */
    
    
    self.isBeginShake = YES;
    
//    [WHAudioTool systemPlay:@"shake_sound_male.wav"];
    
    NSArray *keyTimes = @[
                          [NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:moveAnimationDuring],
//                          [NSNumber numberWithFloat:moveAnimationDuring+moveAnimationStopDuring]
                          ];
    
    CFTimeInterval duration = moveAnimationDuring+moveAnimationStopDuring;
    
    
    //让shake_line_Up上下移动
    CAKeyframeAnimation *translationUp = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    translationUp.values = @[
                             [NSValue valueWithCGPoint:shake_frameinfo_Up.center],
                             [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Up.center.x, shake_frameinfo_Up.center.y-moveDistance)]
                             ];
    translationUp.keyTimes = keyTimes;
    

    translationUp.autoreverses = YES;//动画回到原位
    translationUp.duration = duration;
    
    
    //让shake_logo_Down上下移动
    CAKeyframeAnimation *translationDown = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    translationDown.values = @[
                             [NSValue valueWithCGPoint:shake_frameinfo_Down.center],
                             [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Down.center.x, shake_frameinfo_Down.center.y+moveDistance)],
                             ];
    translationDown.delegate = self;
    translationDown.keyTimes = keyTimes;
    
    translationDown.autoreverses = YES;
    
    translationDown.duration = duration;
    translationDown.calculationMode = kCAAnimationLinear;
    [shake_frameinfo_Up.layer addAnimation:translationUp forKey:@"translationUp"];
    [shake_frameinfo_Down.layer addAnimation:translationDown forKey:@"translationDown"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self stopShakeing];
}

//停止摇一摇
-(void)stopShakeing{
    self.isBeginShake = NO;
    
    ShakeMusicViewController *shakeMusicVC = [[ShakeMusicViewController alloc] init];
//    [self.navigationController pushViewController:shakeMusicVC animated:YES];
    [self presentViewController:shakeMusicVC animated:YES completion:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
