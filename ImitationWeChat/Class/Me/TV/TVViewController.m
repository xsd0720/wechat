//
//  FirstViewController.m
//  KRVideoPlayer
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

#import "TVViewController.h"
#import "KRVideoPlayerController.h"

@interface TVViewController ()

@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation TVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupNav];
    [self playRemoteVideo];
    
}
-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)playRemoteVideo
{
    
    
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    [self playVideoWithURL:videoURL];
    
//    NSURL *videoURL = [NSURL URLWithString:@"http://219.232.160.143:5080/hls/79f11bbdc29595b03cde2c26c8e64f1d.m3u8"];
//    [self playVideoWithURL:videoURL];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}
-(void)dealloc{
    
}
@end
