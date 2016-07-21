//
//  QunViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/1.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "MassAssistantViewController.h"
#import "UINavigationItem+correct_offset.h"
#import "TableViewTimeCell.h"
#import "MassAssistantCell.h"
#import "WJPhotoTool.h"
#define MASSASSISTANTCELLIDENTIFIER @"MASSASSISTANTCELLIDENTIFIER"
#define TIMECELLIDENTIFIER  @"TIMECELLIDENTIFIER"

@interface MassAssistantViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIImage *imim;

@property (nonatomic, assign) BOOL isopen;

@end

@implementation MassAssistantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNav];
    [self configCreateNewButton];
    
    _isopen = NO;
    
    [WJPhotoTool latestAsset:^(WJAsset * _Nullable asset) {
        self.imim = asset.image;
        [self.mainTableView reloadData];
    }];

    
}


- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT-45) style:UITableViewStylePlain];
        [self.view addSubview:_mainTableView];
        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;

        
        [_mainTableView registerClass:[MassAssistantCell class] forCellReuseIdentifier:MASSASSISTANTCELLIDENTIFIER];
        [_mainTableView registerClass:[TableViewTimeCell class] forCellReuseIdentifier:TIMECELLIDENTIFIER];
    }
    return _mainTableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_createNewButton];
}


- (void)configNav
{
    self.title = @"群发助手";
    
    UIButton *rightBarItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarItemButton.frame = CGRectMake(0, 0, 30, 30);
    [rightBarItemButton setImage:[UIImage imageNamed:@"barbuttonicon_set-new"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarItemButton];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set-new"] style:UIBarButtonItemStylePlain target:self action:@selector(barbuttonicon_setClick)];
    [self.navigationItem addRightBarButtonItem:rightBarItem];
}

- (void)configCreateNewButton
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGB(206, 206, 206);
    
    _createNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _createNewButton.frame = CGRectMake(0, SCREEN_HEIGHT-45, SCREEN_WIDTH, 45);
    [_createNewButton setTitle:@"新建群发" forState:UIControlStateNormal];
    _createNewButton.backgroundColor = RGB(250, 250, 250);
    _createNewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_createNewButton setTitleColor:RGB(19, 174, 36) forState:UIControlStateNormal];
    [_createNewButton addSubview:lineView];
    [self.view addSubview:_createNewButton];
    
}

- (void)barbuttonicon_setClick
{
    
}



#pragma mark -- 
#pragma mark -- tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row %2 == 0) {
        return 40;
    }
    
    
    NSString *receivePeoplesStr = @"93位收信人:\n┌溡緔メ籹↘,柒染划破泪浅,___两个人的真情,又帅又能操,稳坐江山,Ghost゜湛蓝,煮茶煮酒煮时光,誰丶是我独家的记忆ゝ,Journey（旅程）,champion,比花还妖艳的笑容,以為`你爱我づ,谁惊艳了岁月,放肆的年华╰╯,﹏冷却の心,江湖浪人,我歌月徘徊,≮复仇★之怒≯,寻遍,ホ€思随颩散﹏.,副歌DI一句-,遥迢流年,仅 缺  份,凝眸处，又添一段新愁,即使我那么爱你-,生命在聆听,祝我万瘦不胖,某人，曾为伱哭泣,″　　兽性打败理性　-/g,甜蜜爱恋。Δ,假情。,冬至心凉。,流年割容颜※,某只小帅比,星星不说话★,…gū唇洧dú,看的见的阳光,恋爱记事簿,我很好比你好,我活得很好,Kiss or hugs,讓愛下地獄,等我变优秀,嘻哈body,咆哮着唱call me baby,宸墨诚星城拾光,外純內騷,小法师的忧伤,放肆的落寞〞,°越是想念，越是依赖,浪游,患得患失的情,瞳話嘟4噓ωёìの,Doctor异乡人。,喂.别犯贱,太平长安。,糟老头孑丶,柠檬仔℃,丶偷心少年丶,┉風彺Ьēīδ欠~`,丑的别致 ㄟ,果酱╰,ゆ我亵读了你的温存て,你不属于我i,柠檬片片,-海单纯洁白°,思念在发烫#,泪水无色,灿泪i,哲学式、演绎,抽煙菂渘情少年,っ心已麻木ン怎会痛゜,只想要你陪,感染你的气息﹌,夜 、唯美,装萌小可爱℡,无谓姑娘";
    
    CGSize size = CGSizeMake(SCREEN_WIDTH-40-16-37,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelsize = [receivePeoplesStr boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    if (![LocalManager sharedManager].isopen) {
        labelsize.height = 15*3;
    }
    
    CGSize resultSize = [self.imim limitMaxWidthHeight:SCREEN_WIDTH-120 maxH:SCREEN_WIDTH-120];
    
    return 10+10+labelsize.height+10+20+resultSize.height+20+25+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0) {
        TableViewTimeCell *timecell = [tableView dequeueReusableCellWithIdentifier:TIMECELLIDENTIFIER forIndexPath:indexPath];
        return timecell;
    }
    else
    {
        MassAssistantCell *cell = [tableView dequeueReusableCellWithIdentifier:MASSASSISTANTCELLIDENTIFIER forIndexPath:indexPath];
        cell.isopen = _isopen;
        cell.datasource = @{};
        cell.sendContentImage = self.imim;
        return cell;
    }
}

@end
