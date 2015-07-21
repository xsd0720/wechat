//
//  FoundViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "FoundViewController.h"


#import "QRCodeViewController.h"
#import "ShakeViewController.h"
static NSString *DISCOVERCELLIDEITIFIER  = @"discovercellidentifier";

@interface FoundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *discoverTableView;
@property (nonatomic,strong) NSArray *discoverData;

@end

@implementation FoundViewController

-(NSArray *)discoverData{
    return @[
             @[
                 @{@"image":@"ff_IconShowAlbum",
                   @"text":@"朋友圈"}

                 ],
             @[
                 @{@"image":@"ff_IconQRCode",
                   @"text":@"扫一扫"},
                 @{@"image":@"ff_IconShake",
                   @"text":@"摇一摇"}
                 ],
             
             @[
                 @{@"image":@"ff_IconLocationService",
                   @"text":@"附近的人"},
                 @{@"image":@"ff_IconBottle",
                   @"text":@"漂流瓶"}
                 ]
             
             
             ];
}

-(UITableView *)discoverTableView{
    if (!_discoverTableView) {
        _discoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-64-44)  style:UITableViewStyleGrouped];
        [self.view addSubview:_discoverTableView];
        
        _discoverTableView.delegate = self;
        _discoverTableView.dataSource = self;
        
        [_discoverTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DISCOVERCELLIDEITIFIER];
    }
    
    return _discoverTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self.discoverTableView reloadData];
}
-(void)setUpNav{
    self.navigationItem.title = @"发现";
    
}

#pragma mark - TableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DISCOVERCELLIDEITIFIER forIndexPath:indexPath];
    NSDictionary *dic = [[self.discoverData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"text"];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //朋友圈
    if (indexPath.section == 0&&indexPath.row == 0) {
        
    }
    //扫一扫
    else if (indexPath.section == 1&&indexPath.row == 0){
        QRCodeViewController *qrCodeVc = [[QRCodeViewController alloc] init];
        qrCodeVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qrCodeVc animated:YES];
    }
    //摇一摇
    else if (indexPath.section == 1&&indexPath.row == 1){
        ShakeViewController *shakeVC = [[ShakeViewController alloc] init];
        shakeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shakeVC animated:YES];
    }
    //附近的人
    else if (indexPath.section == 2&&indexPath.row == 0){
        
    }
    //漂流瓶
    else if (indexPath.section == 2&&indexPath.row == 1){
        
    }
    
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
