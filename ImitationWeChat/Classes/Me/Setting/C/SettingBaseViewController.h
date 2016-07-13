//
//  SettingBaseViewController.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/11.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingBaseViewController : BaseViewController

@property (nonatomic, strong) UITableView *settingBaseTableView;

@property (nonatomic, strong) NSArray *baseDataSource;

- (void)basetableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
