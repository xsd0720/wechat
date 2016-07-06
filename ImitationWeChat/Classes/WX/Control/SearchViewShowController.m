//
//  SearchViewShowController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/5.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SearchViewShowController.h"
#import "WxTableCell.h"


NSString *const SEARCHSHOWTABLECELLIDENTIFIER = @"SEARCHSHOWTABLECELLIDENTIFIER";

@interface SearchViewShowController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *searchShowTableView;

@end

@implementation SearchViewShowController


-(UITableView *)searchShowTableView{
    if (!_searchShowTableView) {
        _searchShowTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+CustomTabarHeight)];
        
        
        [self.view addSubview:_searchShowTableView];
        
        _searchShowTableView.delegate = self;
        _searchShowTableView.dataSource = self;
        _searchShowTableView.tableFooterView = [UIView new];
        
        [_searchShowTableView registerClass:[WxTableCell class] forCellReuseIdentifier:SEARCHSHOWTABLECELLIDENTIFIER];
        _searchShowTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    }
    return _searchShowTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.searchShowTableView reloadData];
}

#pragma mark - tableview delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELLHEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WxTableCell *cell = [tableView dequeueReusableCellWithIdentifier:SEARCHSHOWTABLECELLIDENTIFIER forIndexPath:indexPath];
    cell.dic = @{@"head":@"",@"name":@"大头娃娃",@"msg":@"今天天气不错"};
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
