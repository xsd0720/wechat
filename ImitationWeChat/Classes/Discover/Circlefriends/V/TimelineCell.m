//
//  TimelineCell.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/20.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "TimelineCell.h"
#import "UIImage+Antialiase.h"

#define TIMELINECELLCOLLECTIONCELLIDENTIFIER @"TIMELINECELLCOLLECTIONCELLIDENTIFIER"


@interface TimelineCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSString *imageName;

@end

@interface TimelineCell()

@property (nonatomic, strong) NSArray *imageDataSource;

@end

@implementation TimelineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = RGB(92, 98, 139);
        self.textLabel.font = [UIFont boldSystemFontOfSize:13];
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.font = timeLineDetailTextLabelFont;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)delButton
{
    if (!_delButton) {
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton setTitle:@"删除" forState:UIControlStateNormal];
        _delButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_delButton setTitleColor:RGB(128, 130, 146) forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(delButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delButton];
    }
    return _delButton;
}

- (UIImageView *)onlyImageView
{
    if (!_onlyImageView) {
        _onlyImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_onlyImageView];
    }
    return _onlyImageView;
}

- (UICollectionView *)moreImageCollectionView
{
    if (!_moreImageCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.itemSize = CGSizeMake(timeLineCollectionItemSize, timeLineCollectionItemSize);
        _moreImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 235, 75) collectionViewLayout:flowLayout];
        _moreImageCollectionView.scrollsToTop = NO; //关闭小scrollview top回顶部
        _moreImageCollectionView.showsHorizontalScrollIndicator = NO;
        _moreImageCollectionView.bounces = NO;
        _moreImageCollectionView.dataSource = self;
        _moreImageCollectionView.delegate = self;
        [_moreImageCollectionView setBackgroundColor:[UIColor whiteColor]];
        //注册Cell，必须要有
        [_moreImageCollectionView registerClass:[TimelineCollectionCell class] forCellWithReuseIdentifier:TIMELINECELLCOLLECTIONCELLIDENTIFIER];
        [self addSubview:_moreImageCollectionView];

    }
    return _moreImageCollectionView;
}

//- (MPMoviePlayerViewController *)playView
//{
//    if (!_playView) {
//        _playView = [[MPMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
//        _playView.backgroundColor = [UIColor cyanColor];
//        [self addSubview:_playView];
//        
//        
////        NSString *file = [[NSBundle mainBundle] pathForResource:@"150511_JiveBike" ofType:@"mov"];
////        NSURL *url = [NSURL fileURLWithPath:file];
////        if (_moviePlayer == nil) {
////            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
////        }else {
////            [_moviePlayer setContentURL:url];
////        }
////        _moviePlayer.controlStyle = MPMovieControlStyleNone;
////        _moviePlayer.shouldAutoplay = YES;
////        _moviePlayer.repeatMode = MPMovieRepeatModeOne;
////        [_moviePlayer setFullscreen:YES animated:YES];
////        _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
////        [_moviePlayer play];
////        [_playView addSubview:_moviePlayer.view];
//
//        NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"150511_JiveBike" ofType:@"mov"];
//        self.player = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:videoPath]];
//        // 网络视频使用
//        // NSURL*videoPath = [NSURL URLWithString:@"http://www.xxx.com/1.mp4"]
//        self.player.view.frame = _playView.bounds;
//        [_playView addSubview:self.player.view];
//        // 不需要进度条
//        self.player.controlStyle = MPMovieControlStyleNone;
//        // 是否自动播放（默认为YES）
//        self.player.shouldAutoplay = YES;
//        // 播放本地视频时需要
//        self.player.movieSourceType = MPMovieSourceTypeFile;
//        // 开始播放
//        [self.player play];
//
//    
//    }
//    return _playView;
//}

- (UIView *)linkView
{
    if (!_linkView) {
        _linkView = [[UIView alloc] initWithFrame:CGRectZero];
        _linkView.backgroundColor = RGB(243, 243, 244);
        [self addSubview:_linkView];
    }
    return _linkView;
}




- (void)setDatasource:(NSDictionary *)datasource
{
    _datasource = datasource;
    
    NSString *imageName = datasource[@"image"];
    NSString *username = datasource[@"username"];
    NSString *detailtext = datasource[@"detail"];
    NSString *timestr = datasource[@"time"];
    NSString *mediaType = datasource[@"mediaType"];
    
    
    self.imageView.image = [UIImage imageNamed:imageName];
    self.textLabel.text = username;
    self.detailTextLabel.text = detailtext;
    self.timeLabel.text = timestr;
    
    
    if (_moreImageCollectionView) {
        _moreImageCollectionView.hidden = YES;
    }
    
    if (_onlyImageView) {
        _onlyImageView.hidden = YES;
    }
    if (_playView) {
        _playView.hidden = YES;
    }
    
    if (_linkView) {
        _linkView.hidden = YES;
    }
    
    if ([mediaType isEqualToString:@"image"]) {
        _imageDataSource = datasource[@"data"];
        if (_imageDataSource.count>0) {
            if (_imageDataSource.count > 1) {
                
                int rowCount = 0;
                if (_imageDataSource.count % 3 ==0) {
                    rowCount = (int)_imageDataSource.count/3;
                }else
                {
                    rowCount = (int)_imageDataSource.count/3+1;
                }
                if (rowCount > 9) {
                    rowCount = 9;
                }
                self.moreImageCollectionView.height = rowCount*timeLineCollectionItemSize+((rowCount-1)*timeLineCollectionItemPadding);
                self.moreImageCollectionView.hidden = NO;
                 [self reloadCollectionView:self.moreImageCollectionView animated:NO];
            }
            else
            {
                UIImage *onlyImage = [UIImage imageNamed:_imageDataSource[0]];
                
                CGSize onlysize = [onlyImage limitMaxWidthHeight:150 maxH:150];
                self.onlyImageView.image = [UIImage scaleToSize:onlyImage size:onlysize];
                self.onlyImageView.frame = CGRectMake(0, 0, onlysize.width, onlysize.height);
                self.onlyImageView.hidden = NO;
            }
            
           
        }

       
    }
    
    else if ([mediaType isEqualToString:@"video"])
    {
        self.playView.hidden = NO;
        self.playView.backgroundColor = [UIColor cyanColor];
    }
    
    
    else if ([mediaType isEqualToString:@"link"])
    {
        self.linkView.hidden = NO;
        self.linkView.backgroundColor = RGB(243, 243, 244);
    }
    
}

//刷新collectionView
- (void)reloadCollectionView:(UICollectionView *)collectionView animated:(BOOL)animated
{
    [UIView setAnimationsEnabled:animated];
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        [UIView setAnimationsEnabled:YES];
    }];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageDataSource.count;
}

////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return 6;
//}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TimelineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TIMELINECELLCOLLECTIONCELLIDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.imageName = _imageDataSource[indexPath.row];
    return cell;
    
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



- (void)delButtonClick
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"删除",@"取消", nil];
    [alertView show];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(timeLineImageOrginX, timeLineImageOrginY, timeLineImageSize, timeLineImageSize);
    
    self.textLabel.frame = CGRectMake(timeLineTextLabelOrginX, timeLineTextLabelOrginY, timeLineTextLabelWidth, timeLineTextLabelHeight);

    
    CGFloat detailTextLabelHeight = [self.detailTextLabel.text CalculationStringSizeWithWidth:timeLineDetailTextLabelWidth font:self.detailTextLabel.font space:0].height;
    self.detailTextLabel.frame = CGRectMake(timeLineDetailTextLabelOrginX, timeLineDetailTextLabelOrginY, timeLineDetailTextLabelWidth, detailTextLabelHeight);
    
    CGFloat startOrginY = CGRectGetMaxY(self.detailTextLabel.frame);
    
    if (_moreImageCollectionView && _moreImageCollectionView.hidden == NO) {
        CGFloat moreImageCollectionViewHeight = _moreImageCollectionView.frame.size.height;
        self.moreImageCollectionView.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+8, 235, moreImageCollectionViewHeight);
        startOrginY = CGRectGetMaxY(self.moreImageCollectionView.frame);
    }

    if (_onlyImageView && _onlyImageView.hidden == NO) {
        self.onlyImageView.originY = startOrginY+8;
        self.onlyImageView.originX = CGRectGetMinX(self.textLabel.frame);
        startOrginY = CGRectGetMaxY(self.onlyImageView.frame);
    }
    
    if (_playView && _playView.hidden == NO) {
        self.playView.originX = CGRectGetMinX(self.textLabel.frame);;
        self.playView.originY = startOrginY+8;
        startOrginY = CGRectGetMaxY(self.playView.frame);
    }
    
    if (_linkView && _linkView.hidden == NO) {
        self.linkView.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+8, SCREEN_WIDTH-CGRectGetMinX(self.textLabel.frame)-10, 50);
        startOrginY = CGRectGetMaxY(self.linkView.frame);
    }
    
    CGFloat timeLabelWidth = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName: self.timeLabel.font}].width;
    self.timeLabel.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame), startOrginY+8, timeLabelWidth+20, timeLineTimeLabelHeight);
    
    self.delButton.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), CGRectGetMinY(self.timeLabel.frame), 50, 15);
    self.delButton.centerY = self.timeLabel.centerY;
}

- (void)willDisplayCell
{
    NSLog(@"willDisplayCell");
}

- (void)didEndDisplayingCell
{
    NSLog(@"didEndDisplayingCell");
}

@end

@implementation TimelineCollectionCell

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
    _imageName = imageName;
    
    _imageView.image = [UIImage scaleToSize:_imageView.bounds.size cut:0 image:[UIImage imageNamed:imageName]];
    
}

@end
