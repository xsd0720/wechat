//
//  SendTimeLineViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "SendTimeLineViewController.h"
#import "UIPlaceHolderTextView.h"
#import "TZImagePickerController.h"
#import "SafePhotoViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import <objc/runtime.h>
#define SENDTIMELINETABLECELLIDENTIFIER @"SENDTIMELINETABLECELLIDENTIFIER"
#define SENDTIMELINETCOLLECTIONVIEWIDEIFIER @"SENDTIMELINETCOLLECTIONVIEWIDEIFIER"

#define MAXSELECTEDIMAGECOUNT   9
#define COLLECTIONITEMSIZE      65
@interface PhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *buttonImageView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@interface SendTimeLineViewController()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, TZImagePickerControllerDelegate, UICollectionViewDelegateFlowLayout, SafePhotoViewControllerDelegate>

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UIPlaceHolderTextView *sendTextView;

@property (nonatomic, strong) UITableView *sendTimeLineTableView;

@property (nonatomic, strong) UICollectionView  *photosCollectionView;

@property (nonatomic, strong) TZImagePickerController *tzImagePickerController;

@end

@implementation SendTimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self initData];
    [self refreshCollectionView];
    
    [self.view addSubview:self.sendTimeLineTableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (UITextView *)sendTextView
{
    if (!_sendTextView) {
        _sendTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 75)];
        _sendTextView.font = [UIFont systemFontOfSize:15];
        _sendTextView.placeholder = @"这一刻的想法...";
        _sendTextView.textContainerInset = UIEdgeInsetsZero;
        _sendTextView.showsVerticalScrollIndicator = NO;
        _sendTextView.showsHorizontalScrollIndicator = NO;
    }
    return _sendTextView;
}


- (UICollectionView *)photosCollectionView
{
    if (!_photosCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.itemSize = CGSizeMake(COLLECTIONITEMSIZE, COLLECTIONITEMSIZE);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        
        _photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sendTextView.frame)+10, SCREEN_WIDTH, 65) collectionViewLayout:flowLayout];
        _photosCollectionView.backgroundColor = RGBCOLOR(233, 233, 233);
        _photosCollectionView.delegate = self;
        _photosCollectionView.dataSource = self;
        _photosCollectionView.scrollEnabled = NO;
        _photosCollectionView.backgroundColor = [UIColor whiteColor];
        _photosCollectionView.showsVerticalScrollIndicator = NO;
        _photosCollectionView.showsHorizontalScrollIndicator = NO;
        [_photosCollectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:SENDTIMELINETCOLLECTIONVIEWIDEIFIER];

    }
    return _photosCollectionView;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:self.sendTextView];
        [_tableHeaderView addSubview:self.photosCollectionView];
    }
    return _tableHeaderView;
}

- (UITableView *)sendTimeLineTableView
{
    if (!_sendTimeLineTableView) {
        _sendTimeLineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _sendTimeLineTableView.delegate = self;
        _sendTimeLineTableView.dataSource = self;
        _sendTimeLineTableView.tableHeaderView = self.tableHeaderView;
        _sendTimeLineTableView.tableFooterView = [UIView new];
        [_sendTimeLineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SENDTIMELINETABLECELLIDENTIFIER];
        _sendTimeLineTableView.sectionFooterHeight = 10;
        _sendTimeLineTableView.sectionHeaderHeight = 10;
    }
    return _sendTimeLineTableView;
}
- (void)initData
{
    if (!self.photosArray) {
        self.photosArray = [[NSMutableArray alloc] init];
    }
}
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_back setTitle:@"取消" forState:UIControlStateNormal];
    [button_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button_back.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_back.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_back addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button_send= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    [button_send setTitle:@"发送" forState:UIControlStateNormal];
    [button_send setTitleColor:RGBCOLOR(28, 218, 65) forState:UIControlStateNormal];
    [button_send.titleLabel setTextAlignment:NSTextAlignmentCenter];
    button_send.titleLabel.font = [UIFont systemFontOfSize:16];
    [button_send addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                      target :nil action:nil];
    leftnegativeSpacer.width = -10;
    
    UIBarButtonItem *rightnegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                          target : nil action : nil ];
    rightnegativeSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_back]];
    
    self.navigationItem.rightBarButtonItems =  @[rightnegativeSpacer, [[UIBarButtonItem alloc]initWithCustomView:button_send]];
}

#pragma mark - tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return DS.sendTimeLineTableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DS.sendTimeLineTableData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SENDTIMELINETABLECELLIDENTIFIER forIndexPath:indexPath];
    NSDictionary *dic = DS.sendTimeLineTableData[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"text"];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - collectionviewdelegate
/**
 *  设置collectionView的行数
 *
 *  @return 数据源数组中对象的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count + (self.photosArray.count == MAXSELECTEDIMAGECOUNT?0:1);
}

/**
 *  设置 cell 的相关属性
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SENDTIMELINETCOLLECTIONVIEWIDEIFIER forIndexPath:indexPath];
    if (indexPath.row > self.photosArray.count-1 || self.photosArray.count == 0) {
        [cell.buttonImageView setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.buttonImageView setImage:self.photosArray[indexPath.row] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.photosArray.count-1 || self.photosArray.count == 0) {
        PhotosCollectionViewCell *cell = (PhotosCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.buttonImageView setImage:[UIImage imageNamed:@"AlbumAddBtnHL"] forState:UIControlStateNormal];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.photosArray.count-1 || self.photosArray.count == 0) {
        PhotosCollectionViewCell *cell = (PhotosCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell.buttonImageView setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row > self.photosArray.count-1 || self.photosArray.count == 0) {
        if (self.photosArray.count == MAXSELECTEDIMAGECOUNT) {
            return;
        }
        _tzImagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:(MAXSELECTEDIMAGECOUNT-self.photosArray.count) delegate:self];
        _tzImagePickerController.allowPickingVideo = NO;
        _tzImagePickerController.allowPickingOriginalPhoto = NO;
        [self presentViewController:_tzImagePickerController animated:YES completion:nil];
    }
    else
    {
        SafePhotoViewController *safePhotoVC = [[SafePhotoViewController alloc] init];
        safePhotoVC.photos = self.photosArray;
        safePhotoVC.currentPhotoIndex = indexPath.row;
        safePhotoVC.delegate = self;
        [self.navigationController pushViewController:safePhotoVC animated:YES];
    }
}

- (void)deletePhotosIndex:(NSInteger)index
{
    [self refreshCollectionView];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets
{
    [self.photosArray addObjectsFromArray:photos];
    
    [self refreshCollectionView];
    
}


- (void)backButtonClick
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出本次编辑" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alert show];
   
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ((int)buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)sendButtonClick
{
    NSLog(@"发送");
}

- (void)refreshCollectionView
{
    if (self.photosArray.count == MAXSELECTEDIMAGECOUNT) {
        int photoArrayCount = (int)self.photosArray.count;
        int rowMaxCount = SCREEN_WIDTH/(COLLECTIONITEMSIZE+10);
        int column = photoArrayCount / rowMaxCount;
        
        if (photoArrayCount % rowMaxCount != 0) {
            column += 1;
        }
        self.photosCollectionView.height = (COLLECTIONITEMSIZE)*column+10*(column-1);
    }
    else
    {
        int photoArrayCount = (int)self.photosArray.count+1;
        int rowMaxCount = SCREEN_WIDTH/(COLLECTIONITEMSIZE+10);
        int column = photoArrayCount / rowMaxCount;
        
        if (photoArrayCount % rowMaxCount != 0) {
            column += 1;
        }
        self.photosCollectionView.height = (COLLECTIONITEMSIZE)*column+10*(column-1);
    }
    self.tableHeaderView.height = CGRectGetMaxY(self.photosCollectionView.frame)+15;
    self.sendTimeLineTableView.tableHeaderView = self.tableHeaderView;
    
    [self.photosCollectionView reloadData];
}

@end

@implementation PhotosCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.clipsToBounds = YES;
//        [self.contentView addSubview:_imageView];
        
        _buttonImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _buttonImageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _buttonImageView.clipsToBounds = YES;
        _buttonImageView.userInteractionEnabled = NO;
        [self.contentView addSubview:_buttonImageView];
        
    }
    return self;
}

@end
