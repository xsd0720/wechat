//
//  TestViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/29.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TestViewController.h"
#import "UIImage+Category.h"
#import "WJPhotoTool.h"
@interface TestViewController ()

@property (nonatomic, strong)  UIImageView *coverImageView;

@property (nonatomic, strong) UIImageView *baseImageView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    UIBarButtonItem *cameraButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"载入" style:UIBarButtonItemStylePlain target:self action:@selector(aaaaaa)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -6;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, cameraButtonItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:UIBarButtonItemStylePlain target:self action:@selector(bbbbbb)];
//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:UIBarButtonItemStylePlain target:self action:@selector(cccccc)];
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    
    self.baseImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.baseImageView];
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.coverImageView.image = [UIImage imageNamed:@"00"];
    [self.baseImageView addSubview:self.coverImageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self.navigationController setNavigationBarHidden:NO];
    }else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setNavigationBarHidden:YES];
    }
}
- (void)bbbbbb
{
    [self fullScreenshots];
}

- (void)aaaaaa
{
    [WJPhotoTool latestAsset:^(WJAsset * _Nullable asset) {
        [self.baseImageView setImage:asset.image];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)fullScreenshots{
    
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, YES, 0);
    
    [self.baseImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    
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
