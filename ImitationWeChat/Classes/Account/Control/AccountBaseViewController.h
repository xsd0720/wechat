//
//  AccountBaseViewController.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/27.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "BaseViewController.h"

@interface AccountBaseViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *cancelButton;

@property(nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UIView *tableFooterView;

@property (nonatomic, strong) UIButton *operationButton;

@property (nonatomic, strong) UITableView *mainTableView;

- (NSInteger)atableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)atableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)atableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)operationButtonClick;

- (void)setUnable:(BOOL)unable;

@end
