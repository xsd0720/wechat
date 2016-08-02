//
//  SendSigntViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/25.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SendSigntViewController.h"
#import "UIPlaceHolderTextView.h"
@interface SendSigntViewController ()<UITextViewDelegate>
@property (nonatomic, strong) AVPlayer *avPlayer;

@property (nonatomic, strong) AVPlayerItem *mPlayerItem;

@property (nonatomic, strong) UIPlaceHolderTextView *textView;

@property (nonatomic, strong) UIView *keyBoardToolBar;
@end

@implementation SendSigntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [self configNav];
    
    [self configUI];
}

- (UIView *)keyBoardToolBar
{
    if (!_keyBoardToolBar) {
        _keyBoardToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _keyBoardToolBar.backgroundColor = [UIColor redColor];
    }
    return _keyBoardToolBar;
}

- (void)configNav
{
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"朋友圈";
    
    UIButton * button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_back setTitle:@"取消" forState:UIControlStateNormal];
    [button_back setTitleColor:RGBCOLOR(28, 218, 65) forState:UIControlStateNormal];
    [button_back.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_back.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_back addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button_send= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_send setTitle:@"发送" forState:UIControlStateNormal];
    [button_send setTitleColor:RGBCOLOR(28, 218, 65) forState:UIControlStateNormal];
    [button_send.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_send.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_send addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                         target :nil action:nil];
    leftnegativeSpacer.width = -10;
    
    UIBarButtonItem *rightnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                           target : nil action : nil ];
    rightnegativeSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_back]];
    
    self.navigationItem.rightBarButtonItems =  @[rightnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_send]];

}

- (void)configUI
{
    self.textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(15, STATUS_AND_NAV_BAR_HEIGHT+14, SCREEN_WIDTH-30-91-15, 380/2)];
    self.textView.textContainerInset = UIEdgeInsetsZero;
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:17];
    self.textView.placeholder = @"这一刻的想法";
    self.textView.keyboardAppearance = UIKeyboardAppearanceDark;
    self.textView.inputAccessoryView = self.keyBoardToolBar;
    
    [self.view addSubview:self.textView];
    
    [self configAVPlayer];
}

- (void)configAVPlayer
{
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:self.playPathURL options:nil];
    _mPlayerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    _avPlayer = [AVPlayer playerWithPlayerItem:_mPlayerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    playerLayer.frame = CGRectMake(SCREEN_WIDTH-14-(182/2), STATUS_AND_NAV_BAR_HEIGHT+14, (182/2), (136/2));
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];
    [_avPlayer play];
    //播放完以后
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.mPlayerItem];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)backButtonClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendButtonClick
{
    
}


/**
 *  播放结束
 *
 *  @param notification 消息
 */
- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    [self.avPlayer seekToTime:kCMTimeZero];
    [self.avPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
