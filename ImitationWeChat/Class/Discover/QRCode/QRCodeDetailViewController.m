//
//  QRCodeDetailViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "QRCodeDetailViewController.h"

@interface QRCodeDetailViewController ()
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation QRCodeDetailViewController

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"识别结果";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadHTMLString:_showQrData baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
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
