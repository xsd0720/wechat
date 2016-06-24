//
//  CountryViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "CountryViewController.h"
#import "System.h"
#import "UINavigationItem+correct_offset.h"
#define COUNTRYTABLECELLIDENTIFIER  @"COUNTRYTABLECELLIDENTIFIER"

@interface CountryCodeCell : UITableViewCell

@property (nonatomic, strong) UILabel *phoneCodeLabel;

@end

@interface CountryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableDictionary *dicCode;
@property (nonatomic, strong) UITableView *countryTableView;

@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(238, 239, 245);
   
    [self configNav];
    
    self.dicCode = [[System sharedInstance] dicCode];
    [self.countryTableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

/**
 *  懒加载tableiview
 */
- (UITableView *)countryTableView {
    if (!_countryTableView) {
        _countryTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_countryTableView];
        
        _countryTableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        _countryTableView.dataSource = self;
        _countryTableView.delegate = self;
        _countryTableView.backgroundColor = RGB(238, 239, 245);
        _countryTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _countryTableView.sectionIndexColor = RGB(129, 129, 137);
        // 设置cell的重用
        [_countryTableView registerClass:[CountryCodeCell class] forCellReuseIdentifier:COUNTRYTABLECELLIDENTIFIER];

    }
    return _countryTableView;
}

- (void)configNav
{
    self.navigationItem.title = @"选择国家和地区";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(15, 0, 60, 44);
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem addLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
}

- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.countryTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dicCode[[NSString stringWithFormat:@"%c",(char)('A'+section)]];
    
    return array.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = [@[] mutableCopy];
    
    for ( int i = 0 ; i < 26 ; ++i )
    {
        NSString *index = [NSString stringWithFormat:@"%c",(char)('A'+i)];
        NSArray *array = self.dicCode[index];
        
        if ( array.count > 0 )
        {
            [indexArray addObject:index];
        }
    }
    
    return indexArray;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    header.textAlignment = NSTextAlignmentLeft;
    header.textColor = [UIColor blackColor];
    header.font = [UIFont boldSystemFontOfSize:14];
    header.backgroundColor = RGB(238, 239, 245);
    header.text = [NSString stringWithFormat:@"　%c",(char)('A'+section)];
    
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    char firstChar = [title characterAtIndex:0];
    return firstChar - 'A';
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:COUNTRYTABLECELLIDENTIFIER forIndexPath:indexPath];
    
    
    NSArray *array = self.dicCode[[NSString stringWithFormat:@"%c",(char)('A'+indexPath.section)]];
    
    MMCountry *c = array[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.phoneCodeLabel.text = [NSString stringWithFormat:@"%@", c.dial_code];
    cell.backgroundColor = RGB(238, 239, 245);

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChoiceCountryCode:)]) {
        NSArray *array = self.dicCode[[NSString stringWithFormat:@"%c",(char)('A'+indexPath.section)]];
        
        MMCountry *c = array[indexPath.row];
        [self.delegate didChoiceCountryCode:c];
        

        [self backButtonClick];
     
    }
}
@end

@implementation CountryCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _phoneCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-20, 0, 100, 44)];
        _phoneCodeLabel.textAlignment = NSTextAlignmentRight;
        _phoneCodeLabel.font = [UIFont systemFontOfSize:14];
        _phoneCodeLabel.textColor = RGB(184, 183, 189);
        [self addSubview:_phoneCodeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.phoneCodeLabel.height = self.bounds.size.height;
}

@end
