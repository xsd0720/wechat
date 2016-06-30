//
//  FillSimpleInfoViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/29.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "FillSimpleInfoViewController.h"
#import "UserCenterRequest.h"
#import "LXActionSheet.h"
#import <objc/runtime.h>

static const char activeTextFieldAssociatedkey;

#define NIKENAMETEXTFIELDTAG    110
#define WECHATNUMBERTEXTFILDTAG 120
#define PASSWORDTEXTFIELDTAG    130

#define FillSimpleInfoCELLIDENTIFIER @"FillSimpleInfoCELLIDENTIFIER"


@interface FillSimpleInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titLabel;

@property (nonatomic, strong) UITextField *textField;



@end

@interface FillSimpleInfoViewController ()<LXActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) LXActionSheet *actionSheet;

@property (nonatomic, strong) NSString *nikeNameString;

@property (nonatomic, strong) NSString *wechatNumberString;

@property (nonatomic, strong) NSString *passwordString;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) UITextField *currentTextField;

@property (nonatomic, strong) UIButton *photoButton;

@end

@implementation FillSimpleInfoViewController


/**
 *  设置相机
 */
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.navigationBar.barTintColor = [UIColor blackColor];
        _imagePickerController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        
        //系统返回默认蓝色 改成白色
        _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    }
    return _imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configSuperTableData];
    
    [self registerNotifications];
}

- (void)configSuperTableData
{
    
    self.mainTableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.cancelButton setTitle:@"返回" forState:UIControlStateNormal];
    
    self.titleLabel.text = @"请设置头像，昵称，微信\n号，方便朋友认出你";
    self.titleLabel.height = 50;
    
    
    
    _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoButton.frame = CGRectMake((SCREEN_WIDTH-80)/2, 90, 80, 80);
    _photoButton.layer.cornerRadius = 5;
    _photoButton.contentMode = UIViewContentModeScaleAspectFit;
    _photoButton.layer.borderColor = [RGB(235, 235, 235) CGColor];
    _photoButton.clipsToBounds = YES;
    [_photoButton setBackgroundImage:[UIImage imageNamed:@"DefaultProfileHead"] forState:UIControlStateNormal];
    [self.tableHeaderView addSubview:_photoButton];
    _photoButton.adjustsImageWhenHighlighted = NO;
    [_photoButton addTarget:self action:@selector(choicePhotoImage) forControlEvents:UIControlEventTouchUpInside];
    self.tableHeaderView.height = 180;
    
    
    self.mainTableView.tableHeaderView = self.tableHeaderView;
    [self.operationButton setTitle:@"完成" forState:UIControlStateNormal];
    
    //regis table cell
    [self.mainTableView registerClass:[FillSimpleInfoCell class] forCellReuseIdentifier:FillSimpleInfoCELLIDENTIFIER];
    
    
    [self.mainTableView reloadData];

}


- (void)choicePhotoImage
{
    self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [self.actionSheet showInView:self.view];
}

#pragma mark - imagepickerDelgate

//  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [_photoButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //  设置头像
    //    [_photoImageView setImage:image];
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.imagePickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
        NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        navigationController.navigationBar.titleTextAttributes = dict;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        
        //        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        //        if (self.imagePickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary && [navigationController.viewControllers count] <=2) {
        //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        //        }else{
        //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        //        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

#pragma mark - Actionsheetdelegate

//点击项目
- (void)didClickOnButtonIndex:(int)buttonIndex
{
    if ((int)buttonIndex == 0) {
        
        if (![LWSystem isCanVisitCamera]) {
            return;
        }
        
        // 系统相机
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePickerController animated:YES completion:^{
        }];
    }
    else if ((int)buttonIndex == 1)
    {
        //  系统相册
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:^{
        }];
    }
}


#pragma mark --
#pragma mark -- heavy load superclass table method
- (NSInteger)atableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)atableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FillSimpleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:FillSimpleInfoCELLIDENTIFIER forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    if (indexPath.row == 0) {
        cell.titLabel.text = @"昵称";
        cell.textField.placeholder = @"请输入昵称";
        cell.textField.secureTextEntry = NO;
        cell.textField.tag = NIKENAMETEXTFIELDTAG;
    }else if(indexPath.row == 1)
    {
        
        cell.titLabel.text = @"微信号";
        cell.textField.placeholder = @"请输入微信号";
        cell.textField.secureTextEntry = NO;
        cell.textField.tag = WECHATNUMBERTEXTFILDTAG;
    }
    else if(indexPath.row == 2)
    {
        
        cell.titLabel.text = @"密码";
        cell.textField.placeholder = @"请输入密码";
        cell.textField.secureTextEntry = NO;
        cell.textField.tag = PASSWORDTEXTFIELDTAG;
    }
    else
    {
        cell.userInteractionEnabled = NO;
    }
    return cell;
}


- (void)operationButtonClick
{
    if (self.nikeNameString.length <= 0 || self.wechatNumberString.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"字符为空" message:@"请输入昵称，微信号，密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.passwordString.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"密码少于6位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [UserCenterRequest registerWithUserName:self.nikeNameString mobile:self.mobile wechatNumber:self.wechatNumberString password:self.passwordString success:^(LoginResponse *responsObject)
    {
//        NSLog(@"%@", responsObject);
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate loginIn];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark --
#pragma mark -- keyboard notification
- (void)registerNotifications
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}


#pragma mark --
#pragma mark -- textfield delegate
- (void)textFieldChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)[notification object];
    
    
    
    switch (textField.tag) {
        case NIKENAMETEXTFIELDTAG:
        {
            self.nikeNameString = textField.text;
        }
            break;
        case WECHATNUMBERTEXTFILDTAG:
        {
            self.wechatNumberString = textField.text;
        }
            break;
            
        case PASSWORDTEXTFIELDTAG:
        {
            self.passwordString = textField.text;
        }
            break;
        default:
            break;
    }


    self.operationButton.userInteractionEnabled = (self.nikeNameString.length>0 && self.wechatNumberString.length>0&& self.passwordString.length>0);
}


- (void)textDidBeginEditing:(NSNotification *)notification
{
    UITextField *textField = [notification object];
    self.currentTextField = textField;

//    objc_setAssociatedObject(self, &activeTextFieldAssociatedkey, [NSString stringWithFormat:@"%f", p.y], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardOrginY = keyboardRect.origin.y;

    
    CGPoint currentTextFieldOrgin = [self.currentTextField.superview convertPoint:self.currentTextField.origin toView:getWindow];
//    CGFloat currentTextFieldOrginY = [objc_getAssociatedObject(self, &activeTextFieldAssociatedkey) floatValue]+50;
    CGFloat currentTextFieldOrginY = currentTextFieldOrgin.y+50;
    

    
    
    if (keyboardOrginY < currentTextFieldOrginY) {
        //需要调整位置
        CGFloat cha = currentTextFieldOrginY - keyboardOrginY;
        CGFloat currentTop = self.mainTableView.contentInset.top;
        currentTop -= cha;
        [UIView animateWithDuration:0.3 animations:^{
            self.mainTableView.contentInset = UIEdgeInsetsMake(currentTop, 0, 0, 0);
        }];
        
    }
    
    
    
//    NSLog(@"hight_hitht:%f",kbSize.height);
//    if(kbSize.height == 216)
//    {
//        keyboardhight = 0;
//    }
//    else
//    {
//        keyboardhight = 36;   //252 - 216 系统键盘的两个不同高度
//    }
//    //输入框位置动画加载
//    [self begainMoveUpAnimation:keyboardhight];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    self.mainTableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.operationButton removeObserver:self forKeyPath:@"userInteractionEnabled"];
    
}

@end

@implementation FillSimpleInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
        _titLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_titLabel];
        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titLabel.frame)+5, 0, SCREEN_WIDTH-(CGRectGetMaxX(_titLabel.frame)+5), 44)];
        [self addSubview:_textField];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _titLabel.height = self.bounds.size.height;
}
@end
