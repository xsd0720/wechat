//
//  MyProfileViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/4.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MyProfileViewController.h"
#import "LXActionSheet.h"
NSString *const myProfileTableViewCellIdentifier = @"myProfileTableViewCellIdentifier";

@interface MyProfileTableViewCell : UITableViewCell

//栏目名称
@property (nonatomic, strong) UILabel *columnNameLabel;

//栏目图片(option)
@property (nonatomic, strong) UIImageView *columnImageView;

//栏目详细(option)
@property (nonatomic, strong) UILabel *columnDetailLabel;

@property (nonatomic, strong) NSDictionary *datasource;



@end


@interface MyProfileViewController ()<UITableViewDataSource, UITableViewDelegate, LXActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *myProfileTableView;

@property (nonatomic, strong) LXActionSheet *actionSheet;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;  //  相机

@end

@implementation MyProfileViewController

- (UITableView *)myProfileTableView
{
    if (!_myProfileTableView) {
        _myProfileTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myProfileTableView.delegate = self;
        _myProfileTableView.dataSource = self;
        _myProfileTableView.sectionFooterHeight = 1;
        _myProfileTableView.sectionHeaderHeight = 10;
        [_myProfileTableView registerClass:[MyProfileTableViewCell class] forCellReuseIdentifier:myProfileTableViewCellIdentifier];
    }
    return _myProfileTableView;
}


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
    
    [self setUpNav];
    
    [self.view addSubview:self.myProfileTableView];
}

- (void)setUpNav
{
    self.title = @"个人信息";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    }
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DS.myProfileTableData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[DS.myProfileTableData objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myProfileTableViewCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [[DS.myProfileTableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.datasource = dic;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.columnImageView.layer.cornerRadius = 8;
        cell.columnImageView.layer.borderWidth = 1;
    }
    else
    {
        cell.columnImageView.layer.cornerRadius = 0;
        cell.columnImageView.layer.borderWidth = 0;
    }
    
    
    return cell;
}


#pragma actionsheetdelegate

- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
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

- (void)didClickOnDestructiveButton
{
}

- (void)didClickOnCancelButton
{
    NSLog(@"cancelButton");
}


//  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //  设置头像
//    [_photoImageView setImage:image];

}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (self.imagePickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary && [navigationController.viewControllers count] <=2) {
        
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //更改头像
    if (indexPath.section == 0 && indexPath.row == 0) {
//        self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从手机相册选择"]];
        self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];

        [self.actionSheet showInView:self.view];
    }
}

@end

@implementation MyProfileTableViewCell
#define Padding   10
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //栏目名称
        _columnNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, 0, SCREEN_WIDTH, 20)];
        _columnNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_columnNameLabel];
        
        
        
        //栏目图片
        _columnImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _columnImageView.contentMode = UIViewContentModeScaleAspectFit;
        _columnImageView.clipsToBounds = YES;
        _columnImageView.layer.borderColor = [RGBCOLOR(202, 202, 202) CGColor];
        [self addSubview:_columnImageView];
        
        
        
        //栏目详情
        _columnDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 100, 0, 100, 20)];
        _columnDetailLabel.font = [UIFont systemFontOfSize:16];
        _columnDetailLabel.textAlignment = 2;
        _columnDetailLabel.textColor = RGBCOLOR(155, 155, 155);
        [self addSubview:_columnDetailLabel];
        
        _columnImageView.hidden = YES;
        _columnDetailLabel.hidden = YES;
    }
    return self;
}

- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    _columnImageView.hidden = YES;
    _columnDetailLabel.hidden = YES;
    
    NSString *text = datasource[@"text"];
    _columnNameLabel.text = text;
    
    NSString *obj = datasource[@"obj"];
    
    if ([datasource[@"type"] isEqualToString:@"1"]) {
        //图片
        _columnImageView.hidden = NO;
        _columnImageView.image = [UIImage imageNamed:obj];
    }
    else
    {
        //文字
        _columnDetailLabel.hidden = NO;
        _columnDetailLabel.text = obj;
    }

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _columnNameLabel.centerY = CGRectGetMaxY(self.bounds)/2;
    
    
    CGFloat headImageSize = CGRectGetMaxY(self.bounds)-20;
    
    _columnImageView.frame = CGRectMake(SCREEN_WIDTH - 30 - headImageSize, 10, headImageSize, headImageSize);
    _columnImageView.centerY = CGRectGetMaxY(self.bounds)/2;
    _columnDetailLabel.centerY = CGRectGetMaxY(self.bounds)/2;
}

@end
