//
//  ShakeSettingViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/23.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ShakeSettingViewController.h"

static NSString *SHAKESETTABLECELLIDENTIFIER = @"shakeSetTableCellIdentifier";

@interface ShakeSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *shakeSetTableView;
@property (nonatomic,strong) UISwitch *accessorySwitch;

@property (nonatomic,strong) UIImagePickerController  *imagepicker;


@end

@implementation ShakeSettingViewController
-(UIImagePickerController *)imagepicker{
    if (!_imagepicker) {
        _imagepicker = [[UIImagePickerController alloc]init];
        _imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagepicker.allowsEditing = YES;
        _imagepicker.delegate = self;
        _imagepicker.navigationBar.barTintColor = [UIColor blackColor];
        _imagepicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
        
        //系统返回默认蓝色 改成白色
        _imagepicker.navigationBar.tintColor = [UIColor whiteColor];
    }
    return _imagepicker;
}

#pragma mark - accessorySwitch

-(UISwitch *)accessorySwitch{
    if (!_accessorySwitch) {
        _accessorySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [_accessorySwitch addTarget:self action:@selector(accessorySwitchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _accessorySwitch;
}
-(void)accessorySwitchChange:(UISwitch *)sw{
    if (sw.on) {
        NSLog(@"audio on");
        [[NSUserDefaults standardUserDefaults] setValue:@"on" forKey:SHAKEAUDIOSTATUS];
    }else{
        NSLog(@"audio off");
        [[NSUserDefaults standardUserDefaults] setValue:@"off" forKey:SHAKEAUDIOSTATUS];
    }
}


-(UITableView *)shakeSetTableView{
    if (!_shakeSetTableView) {
        _shakeSetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)  style:UITableViewStyleGrouped];
        [self.view addSubview:_shakeSetTableView];
        
        _shakeSetTableView.delegate = self;
        _shakeSetTableView.dataSource = self;
        
        [_shakeSetTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SHAKESETTABLECELLIDENTIFIER];
    }
    return _shakeSetTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"摇一摇设置";
    [self.shakeSetTableView reloadData];
}

#pragma mark - TableView Delegate,Datasource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return DS.shakeSetTableData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[DS.shakeSetTableData objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHAKESETTABLECELLIDENTIFIER forIndexPath:indexPath];
    NSDictionary *dic = DS.shakeSetTableData[indexPath.section][indexPath.row];
    NSString *text = dic[@"text"];
    NSString *type = dic[@"type"];
    cell.textLabel.text = text;
    if ([type isEqualToString:@"arrow"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if ([type isEqualToString:@"switch"]){
        cell.accessoryView = self.accessorySwitch;
        NSString *shakesoundstatus = [[NSUserDefaults standardUserDefaults] valueForKey:SHAKEAUDIOSTATUS];
        if ([shakesoundstatus isEqualToString:@"on"]) {
            self.accessorySwitch.on = YES;
        }
        
        
    }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //使用默认背景图片
    if (indexPath.section == 0&&indexPath.row == 0) {
        UIImage *defaultImage = [UIImage imageNamed:@"ShakeHideImg_women"];
        NSData *data = UIImagePNGRepresentation(defaultImage);
        [data writeToFile:ShakeBgImagePath atomically:YES];
        
        if (_changeBgImageBlock) {
            _changeBgImageBlock(defaultImage);
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已恢复默认背景图" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];

    }
    //换张背景图片
    else if (indexPath.section == 0&&indexPath.row == 1){
        [self ChangeBackgroundImage];
    }
    //音效
    else if (indexPath.section == 0&&indexPath.row == 2){
        
    }
    //打招呼的人
    else if (indexPath.section == 1&&indexPath.row == 0){
        
    }
    //摇到的历史
    else if (indexPath.section == 1&&indexPath.row == 1){
        
    }
    //摇一摇消息
    else if (indexPath.section == 2&&indexPath.row == 0){
        
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *editedImage=nil;
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            editedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(editedImage, self, nil, nil);
            
        }else
        {
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *data = UIImagePNGRepresentation(editedImage);
            [data writeToFile:ShakeBgImagePath atomically:YES];
            
            if (_changeBgImageBlock) {
                _changeBgImageBlock(editedImage);
            }

            [self dismissViewControllerAnimated:YES completion:nil];
        });

    });
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    
    NSLog(@"saved..");
}
-(void)ChangeBackgroundImage{
    [self presentViewController:self.imagepicker animated:YES completion:nil];
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
