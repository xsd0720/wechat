//
//  MyQRCodeViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "LXActionSheet.h"
#import "QRCode.h"
#import "MyQRCodeView.h"
@interface MyQRCodeViewController()<LXActionSheetDelegate>
@property (nonatomic, strong) LXActionSheet *actionSheet;

@property (nonatomic, strong) MyQRCodeView *myQrCodeView;

@end

@implementation MyQRCodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadNav];
 
    [self configMainUI];
    
   
}

- (void)configMainUI
{
    _myQrCodeView = [[MyQRCodeView alloc] initWithFrame:CGRectMake(22, 60+64, (SCREEN_WIDTH - 44), (SCREEN_HEIGHT-120 - 64))];
    [self.view addSubview:_myQrCodeView];
}


-(void)loadNav{
    self.view.backgroundColor = RGBCOLOR(45, 49, 50);
    
    self.navigationItem.title = @"我的二维码";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_moreClick)];
    
}

- (void)barbuttonicon_moreClick
{
    self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"换个样式", @"保存图片", nil];
    
    [self.actionSheet showInView:self.view];
}


#pragma mark - Actionsheetdelegate

//点击项目
- (void)didClickOnButtonIndex:(int)buttonIndex
{
    if ((int)buttonIndex == 0) {
        
        // 换个样式

    }
    else if ((int)buttonIndex == 1)
    {
        //  保存图片
        UIGraphicsBeginImageContextWithOptions(_qrCodeBackgroundView.bounds.size, NO, 0);
        [_qrCodeBackgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*  viewImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage,nil,nil,nil);
        
        [self.view makeToast:@"保存成功"];
    }
}

//点击取消
- (void)didClickOnCancelButton
{
    NSLog(@"cancelButton");
}




@end
