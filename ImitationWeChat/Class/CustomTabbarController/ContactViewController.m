//
//  ContactViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/16.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "ContactViewController.h"

static NSString *CONTACTCELLIDENTIFIER  = @"contactcellidentifier";



@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *contactTableView;

@property (nonatomic,strong) NSArray *capIndexes;
@end

@implementation ContactViewController

-(NSArray *)capIndexes
{
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    
    // [toBeReturned addObject:@"{search}"];
    for(char x = 'A'; x <='Z';x++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",x]];
    
    [toBeReturned addObject:[NSString stringWithFormat:@"%c",'#']];
    
    return toBeReturned;
}

-(UITableView *)wxTableView{
    if (!_contactTableView) {
        _contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-CustomTabarHeight) style:UITableViewStyleGrouped];
        
        
        [self.view addSubview:_contactTableView];
        
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
        _contactTableView.tableFooterView = [UIView new];
        
        [_contactTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CONTACTCELLIDENTIFIER];
    }
    return _contactTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self.contactTableView reloadData];
}
-(void)setupNav{
    self.navigationItem.title = @"通讯录";
}
#pragma mark - TableView section
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  self.capIndexes;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}


#pragma mark - TableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CONTACTCELLIDENTIFIER forIndexPath:indexPath];
    return cell;
}



@end
