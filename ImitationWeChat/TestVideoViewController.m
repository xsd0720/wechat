//
//  TestVideoViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/8/2.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TestVideoViewController.h"
#import "GPUImage.h"
#import "WXMoviePlayerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface TestVideoViewController ()
{
    
    GPUImageMovie *_movieFile;
    GPUImageOutput<GPUImageInput> *_filter;
    GPUImageMovieWriter *_movieWriter;
 
}

    
@property (retain, nonatomic) GPUImageMovie *movieFile;
@property (retain, nonatomic) GPUImageOutput<GPUImageInput> *filter;
@property (retain, nonatomic) GPUImageMovieWriter *movieWriter;
@end

@implementation TestVideoViewController
@synthesize movieFile = _movieFile;
@synthesize filter = _filter;
@synthesize movieWriter = _movieWriter;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    player =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//    player.controlStyle=MPMovieControlStyleDefault;
//    [player prepareToPlay];
//    [player.view setFrame:self.view.bounds];  // player的尺寸
//    [self.view addSubview: player.view];
//    player.shouldAutoplay=YES;
    
    
    WXMoviePlayerController *wxMovide = [[WXMoviePlayerController alloc] initWithContentURL:nil];
    wxMovide.view.frame = CGRectMake(0, 0, 320, 180);
    [self.view addSubview:wxMovide.view];


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
