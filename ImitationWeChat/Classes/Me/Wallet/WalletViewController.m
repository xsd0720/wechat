//
//  WalletViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/1/15.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletCollectionViewCell.h"
#import "WalletHeaderView.h"
#import "WalletCollectionHeaderCell.h"
static NSString *const WalletCollectionViewCellIdentifier = @"WalletCollectionViewCellIdentifier";
static NSString *const WalletCollectionViewHeaderIdentifier = @"WalletCollectionViewHeaderIdentifier";

static NSString *const WalletCollectionViewHeaderCellIdentifier = @"WalletCollectionViewHeaderCellIdentifier";

@interface WalletCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@interface WalletViewController()<UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *walletCollectionView;

@end


@implementation WalletViewController

- (UICollectionView *)walletCollectionView
{
    if (!_walletCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;

        
        _walletCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
        _walletCollectionView.backgroundColor = RGBCOLOR(233, 233, 233);
        _walletCollectionView.delegate = self;
        _walletCollectionView.dataSource = self;
        _walletCollectionView.showsVerticalScrollIndicator = NO;
        _walletCollectionView.showsHorizontalScrollIndicator = NO;
        [_walletCollectionView registerClass:[WalletCollectionViewCell class] forCellWithReuseIdentifier:WalletCollectionViewCellIdentifier];
        [_walletCollectionView registerClass:[WalletCollectionHeaderCell class] forCellWithReuseIdentifier:WalletCollectionViewHeaderCellIdentifier];
        [_walletCollectionView registerClass:[WalletHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WalletCollectionViewHeaderIdentifier];
    }
    return _walletCollectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"钱包";
    
    self.view.backgroundColor = RGBCOLOR(104, 111, 121);
    [self.view addSubview:self.walletCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

/**
 *  设置collectionView的行数
 *
 *  @return 数据源数组中对象的个数
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 10;
    }
    return 6;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, CELLSIZEHEIGHT);
    }
    return CGSizeMake(CELLSIZEWIDTH, CELLSIZEHEIGHT);
}
/**
 *  设置 cell 的相关属性
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    if (indexPath.section == 0) {
        WalletCollectionHeaderCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:WalletCollectionViewHeaderCellIdentifier forIndexPath:indexPath];
        headerCell.backgroundColor = RGBCOLOR(104, 111, 121);
        return headerCell;
    }
    
    NSDictionary *dic = DS.walletData[indexPath.section][indexPath.row];
    WalletCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WalletCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.iconTextLabel.text = @"手机充值";
//    [cell.iconImageView setImage:[UIImage imageNamed:@"wallet"] forState:UIControlStateNormal];
    cell.datasource = dic;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            return nil;
        }
        WalletHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind :UICollectionElementKindSectionHeader withReuseIdentifier:WalletCollectionViewHeaderIdentifier forIndexPath:indexPath];
        if (indexPath.section == 1) {
            headerView.wtitleLabel.text=@"腾讯服务";
        }else if(indexPath.section == 2){
            headerView.wtitleLabel.text=@"第三方服务";
        }
        return headerView;
    }
    return nil;
}
@end


@implementation WalletCollectionViewFlowLayout

- (UIEdgeInsets)sectionInset
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)minimumInteritemSpacing {
    return 0;
}

- (CGFloat)minimumLineSpacing
{
    return 0;
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    //从第二个循环到最后一个
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 0;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return attributes;
}

@end