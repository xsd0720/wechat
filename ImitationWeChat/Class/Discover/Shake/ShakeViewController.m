//
//  ShakeViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/21.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ShakeViewController.h"

#import "TabBarItem.h"

@interface ShakeViewController ()
{
    UIImageView *imageViewWomen;
    
    UIImageView *shake_frameinfo_Up;
    UIImageView *shake_frameinfo_Down;
    
    UIImageView *shake_logo_Up;
    UIImageView *shake_logo_Down;
    
    UIImageView *shake_line_Up;
    UIImageView *shake_line_Down;
    
    UIView *chooseView;
}

@property (nonatomic) BOOL isBeginShake;

@property (nonatomic,strong) NSArray *chooseSubViewData;

@property (nonatomic,strong) NSMutableArray *chooseItemArray;
@end

@implementation ShakeViewController

-(NSArray *)chooseSubViewData{
    return @[
             
             @{
                 @"imageName":@"Shake_icon_people",
                 @"imageName_HL":@"Shake_icon_peopleHL",
                 @"text":@"人"
                 },
             @{
                 @"imageName":@"Shake_icon_music",
                 @"imageName_HL":@"Shake_icon_musicHL",
                 @"text":@"歌曲"
                 },
             @{
                 @"imageName":@"Shake_icon_tv",
                 @"imageName_HL":@"Shake_icon_tvHL",
                 @"text":@"电视"
                 }
             ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    [self setUpShakeUI];
    [self setUpChooseView];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self beginShakeing];
}
-(void)setUpNav{
    self.navigationItem.title = @"摇一摇";
    self.view.backgroundColor = RGBCOLOR(47, 50, 50);
}
//摇一摇UI
-(void)setUpShakeUI{
    
    
    CGFloat CurrentScreenHeight = SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT;
    CGFloat shakeLineHeight = (SCREEN_WIDTH/320.f)*20;
    
    //背景小花
    imageViewWomen = [[UIImageView alloc] initWithFrame:CGRectMake(0, (CurrentScreenHeight-SCREEN_WIDTH)/2, SCREEN_WIDTH, SCREEN_WIDTH)];
    imageViewWomen.image = [UIImage imageNamed:@"ShakeHideImg_women"];
    [self.view addSubview:imageViewWomen];
    
    
    //frameinfo
    UIImage *imageFrameInfo = [UIImage imageNamed:@"ShakeFrameInfo"];
    imageFrameInfo = [imageFrameInfo stretchableImageWithLeftCapWidth:imageFrameInfo.size.width/2 topCapHeight:imageFrameInfo.size.height/2];
    //上frame
    shake_frameinfo_Up = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CurrentScreenHeight/2)];
    shake_frameinfo_Up.image = imageFrameInfo;
    [self.view addSubview:shake_frameinfo_Up];
    
    //下frame
    shake_frameinfo_Down = [[UIImageView alloc] initWithFrame:CGRectMake(0,CurrentScreenHeight/2, SCREEN_WIDTH, CurrentScreenHeight/2)];
    shake_frameinfo_Down.image = imageFrameInfo;
    [self.view addSubview:shake_frameinfo_Down];
    
//    //上logo
//    UIImage *LogoUpImage = [UIImage imageNamed:@"Shake_Logo_Up"];
//    CGFloat logoUpImageW = LogoUpImage.size.width;
//    CGFloat logoUpImageH = LogoUpImage.size.height;
//    shake_logo_Up = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-logoUpImageW)/2, CurrentScreenHeight/2-logoUpImageH, logoUpImageW, logoUpImageH)];
//    shake_logo_Up.image = LogoUpImage;
//    [self.view addSubview:shake_logo_Up];
//    
//    //上logo
//    UIImage *LogoDownImage = [UIImage imageNamed:@"Shake_Logo_Down"];
//    CGFloat logoDownImageW = LogoDownImage.size.width;
//    CGFloat logoDownImageH = LogoDownImage.size.height;
//    shake_logo_Down = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-logoDownImageW)/2, CurrentScreenHeight/2, logoDownImageW, logoDownImageH)];
//    shake_logo_Down.image = LogoDownImage;
//    [self.view addSubview:shake_logo_Down];
//    
//    //上line
//    UIImage *lineUp = [UIImage imageNamed:@"Shake_Line_Up"];
//    lineUp = [lineUp stretchableImageWithLeftCapWidth:lineUp.size.width/2 topCapHeight:lineUp.size.height/2];
//    shake_line_Up = [[UIImageView alloc] initWithFrame:CGRectMake(-shake_logo_Up.originX, shake_logo_Up.height, SCREEN_WIDTH, shakeLineHeight)];
//    shake_line_Up.image = lineUp;
//    [shake_logo_Up addSubview:shake_line_Up];
//    
//    
//    //下line
//    
//    UIImage *lineDown = [UIImage imageNamed:@"Shake_Line_Down"];
//    lineDown = [lineDown stretchableImageWithLeftCapWidth:0 topCapHeight:0];
//    shake_line_Down = [[UIImageView alloc] initWithFrame:CGRectMake(-shake_logo_Down.originX, -shakeLineHeight, SCREEN_WIDTH, shakeLineHeight)];
//    shake_line_Down.image = lineDown;
//    [shake_logo_Down addSubview:shake_line_Down];
    
    //没有开始晃动
    self.isBeginShake = NO;
    
}
//加载功能选择
-(void)setUpChooseView{
    chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
//    chooseView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    [self.view addSubview:chooseView];
    
    //    CGFloat padding = 10;
    CGFloat w = chooseView.frame.size.width/self.chooseSubViewData.count;
    CGFloat h = chooseView.frame.size.height;
    
    
    _chooseItemArray = [NSMutableArray array];
    
    for (int i=0; i<self.chooseSubViewData.count; i++) {
        TabBarItem *tabbrItem = [[TabBarItem alloc] initWithFrame:CGRectMake(i*w,0, w, h)];
        // [tabbrItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        tabbrItem.button.frame = CGRectMake(0,0, w, h-12);
        [tabbrItem.button setImage:[UIImage imageNamed:self.chooseSubViewData[i][@"imageName"]] forState:UIControlStateNormal];
        [tabbrItem.button setImage:[UIImage imageNamed:self.chooseSubViewData[i][@"imageName_HL"]] forState:UIControlStateSelected];
        tabbrItem.label.text = self.chooseSubViewData[i][@"text"];
        tabbrItem.label.frame  = CGRectMake(0, tabbrItem.frame.size.height-12, w, 8);
        [chooseView addSubview:tabbrItem];
        tabbrItem.tag = i;
        [tabbrItem addTarget:self action:@selector(chooseViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_chooseItemArray addObject:tabbrItem];
        
        if (i == 0) {
            tabbrItem.selected = YES;
        }
    }
    
    
}
//功能选择
-(void)chooseViewClick:(UIButton *)button{
    
    [_chooseItemArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
    }];
    button.selected = YES;
    
    switch (button.tag) {
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
    shake_line_Up.hidden = !isBeginShake;
    shake_line_Down.hidden = !isBeginShake;
}


//开始摇一摇
-(void)beginShakeing{
    self.isBeginShake = YES;
    
    [WHAudioTool systemPlay:@"shake_sound_male.wav"];
    
    
    CGFloat moveDistance = 80;
    
    //让shake_line_Up上下移动
    CABasicAnimation *translationUp = [CABasicAnimation animationWithKeyPath:@"position"];
    translationUp.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translationUp.fromValue = [NSValue valueWithCGPoint:shake_frameinfo_Up.center];
    translationUp.toValue = [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Up.center.x, shake_frameinfo_Up.center.y-moveDistance)];
    translationUp.duration = 0.4;
    translationUp.repeatCount = 1;
//    translationUp.fillMode = kCAFillModeForwards;
    translationUp.autoreverses = YES;
    
    //让shake_logo_Down上下移动
    CABasicAnimation *translationDown = [CABasicAnimation animationWithKeyPath:@"position"];
    translationDown.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translationDown.fromValue = [NSValue valueWithCGPoint:shake_frameinfo_Down.center];
    translationDown.toValue = [NSValue valueWithCGPoint:CGPointMake(shake_frameinfo_Down.center.x, shake_frameinfo_Down.center.y+moveDistance)];
    translationDown.duration = 0.4;
    translationDown.repeatCount = 1;
    translationDown.delegate = self;
    translationDown.autoreverses = YES;
    
    [shake_frameinfo_Up.layer addAnimation:translationUp forKey:@"translationUp"];
    [shake_frameinfo_Down.layer addAnimation:translationDown forKey:@"translationUp"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.isBeginShake = NO;
}
//停止摇一摇
-(void)stopShakeing{
    
}
-(void)dealloc{
    
}
@end
