//
//  TimelineMsgTypeImageCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineMsgTypeImageCell.h"

static NSString *TIMELINECELLCOLLECTIONCELLIDENTIFIER = @"TIMELINECELLCOLLECTIONCELLIDENTIFIER";


@interface TimelineMsgTypeImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSString *imageName;

@end

@implementation TimelineMsgTypeImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    _imageView.frame = self.bounds;
    _imageView.image = [UIImage scaleToSize:_imageView.bounds.size cut:0 image:[UIImage imageNamed:imageName]];
}

@end



@interface TimelineMsgTypeImageCell()

@property (nonatomic, strong) NSArray *imageDataSource;

@property (nonatomic, assign) CGSize  oneImageSize;

@end

@implementation TimelineMsgTypeImageCell

- (UICollectionView *)moreImageCollectionView
{
    if (!_moreImageCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        _moreImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 235, 75) collectionViewLayout:flowLayout];
        _moreImageCollectionView.scrollsToTop = NO; //关闭小scrollview top回顶部
        _moreImageCollectionView.showsHorizontalScrollIndicator = NO;
        _moreImageCollectionView.bounces = NO;
        _moreImageCollectionView.dataSource = self;
        _moreImageCollectionView.delegate = self;
        [_moreImageCollectionView setBackgroundColor:[UIColor whiteColor]];
        //注册Cell，必须要有
        [_moreImageCollectionView registerClass:[TimelineMsgTypeImageCollectionCell class] forCellWithReuseIdentifier:TIMELINECELLCOLLECTIONCELLIDENTIFIER];
        [self addSubview:_moreImageCollectionView];
        
    }
    return _moreImageCollectionView;
}


#pragma mark - 
#pragma mark -- heavy load
- (void)setDatasource:(NSDictionary *)datasource
{
    [super setDatasource:datasource];
    
    NSArray *images = datasource[WXMessageTypeDataKey];
    _imageDataSource = images;
    
    
    CGSize size = [TimelineCellHeight imagesHeight:datasource];
    self.oneImageSize = size;
    
    self.moreImageCollectionView.height = size.height;
    self.moreImageCollectionView.width = size.width;
    
    [self reloadCollectionView:self.moreImageCollectionView animated:NO];

}


- (CGFloat)MsgTypeHeight:(CGFloat)startOrginY
{
    CGFloat moreImageCollectionViewWidth = self.moreImageCollectionView.frame.size.width;
    CGFloat moreImageCollectionViewHeight = self.moreImageCollectionView.frame.size.height;
    
    self.moreImageCollectionView.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+MsgTypeMarginTop, moreImageCollectionViewWidth, moreImageCollectionViewHeight);
    return  CGRectGetMaxY(self.moreImageCollectionView.frame);
}

#pragma mark -
#pragma mark -- collectionview delegate and datasource
//刷新collectionView(为了加速,比reload流畅)
- (void)reloadCollectionView:(UICollectionView *)collectionView animated:(BOOL)animated
{
    [UIView setAnimationsEnabled:animated];
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        [UIView setAnimationsEnabled:YES];
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_imageDataSource.count > 1) {
       return CGSizeMake(timeLineCollectionItemSize, timeLineCollectionItemSize);
    }else
    {
        return self.oneImageSize;
    }
    
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageDataSource.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (_imageDataSource.count > 1) {
        TimelineMsgTypeImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TIMELINECELLCOLLECTIONCELLIDENTIFIER forIndexPath:indexPath];
        cell.imageName = _imageDataSource[indexPath.row];
        return cell;
//    }
//    TimelineOneMsgTypeImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TIMELINEONECELLCOLLECTIONCELLIDENTIFIER forIndexPath:indexPath];
//    cell.imageName = _imageDataSource[indexPath.row];
//    return cell;
    
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
