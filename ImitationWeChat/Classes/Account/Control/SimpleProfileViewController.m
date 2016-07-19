//
//  SimpleProfileViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/19.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SimpleProfileViewController.h"
#import "SimpleProfileHeaderCell.h"
#import "SimpleProfileAlbumCell.h"

static NSString *SIMPLEPROFILEDEFINCELLIDENTIFIER = @"SIMPLEPROFILEDEFINCELLIDENTIFIER";
static NSString *SIMPLEPROFILEHEADERCELLIDENTIFIER = @"SIMPLEPROFILEHEADERCELLIDENTIFIER";
static NSString *SIMPLEPROFILEALBUMCELLIDENTIFIER = @"SIMPLEPROFILEALBUMCELLIDENTIFIER";

@interface SimpleProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation SimpleProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
}

/**
 *  懒加载tableiview
 */
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];

        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SIMPLEPROFILEDEFINCELLIDENTIFIER];
        [_mainTableView registerClass:[SimpleProfileHeaderCell class] forCellReuseIdentifier:SIMPLEPROFILEHEADERCELLIDENTIFIER];
        [_mainTableView registerClass:[SimpleProfileAlbumCell class] forCellReuseIdentifier:SIMPLEPROFILEALBUMCELLIDENTIFIER];
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
    }
    return _mainTableView;
}

- (void)setUpNav
{
    self.title = @"详细资料";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SIMPLEPROFILEDEFINCELLIDENTIFIER forIndexPath:indexPath];
    return cell;
//    if (indexPath.section == 0) {
//        
//    }
//    else if (indexPath.section == 1)
//    {
//        
//    }
//    else
//    {
//        
//    }
    
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
