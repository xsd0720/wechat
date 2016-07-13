//
//  MultiLanguageViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/12.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MultiLanguageViewController.h"
#import "UINavigationItem+correct_offset.h"
@interface MultiLanguageViewController ()

@end

@implementation MultiLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNav];
    
    self.baseDataSource = DS.multiLanguageData;

    NSArray *arr = [self.settingBaseTableView visibleCells];
    UITableViewCell *cell = arr[0];
    cell.accessoryView.hidden = NO;
}

- (void)configNav
{
    self.navigationItem.title = @"多语言";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(15, 0, 60, 44);
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem addLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
    
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    saveButton.frame = CGRectMake(15, 0, 60, 44);
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem addRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:saveButton]];
    
}


- (void)basetableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [tableView visibleCells];
    for (UITableViewCell *cell in arr) {
        cell.accessoryView.hidden = YES;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = NO;
}


- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonClick
{
    
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
