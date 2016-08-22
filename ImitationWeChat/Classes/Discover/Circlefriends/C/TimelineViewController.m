//
//  TimelineViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/26.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "TimelineViewController.h"

#import "TZImagePickerController.h"
#import "MyNavViewController.h"
#import "SendTimeLineViewController.h"
#import "SightViewController.h"

#import "LXActionSheet.h"

#import "TimelineMsgTypeDefaultCell.h"
#import "TimelineMsgTypeTextCell.h"
#import "TimelineMsgTypeImageCell.h"
#import "TimelineMsgTypeAppCell.h"
#import "TimelineMsgTypeWebCell.h"
#import "TimelineMsgTypeMusicCell.h"
#import "TimelineMsgTypeVideoCell.h"
#import "TimeLineMsgTypeEmotionCell.h"

#import "TimelineCellHeight.h"


//CELL IDENTFIIER
//default style
static NSString *WXMESSAGETYPEDEFAULTCELLIDENTIFIER = @"WXMESSAGETYPEDEFAULTCELLIDENTIFIER";
//text style
static NSString *WXMESSAGETYPETEXTCELLIDENTIFIER    = @"WXMESSAGETYPETEXTCELLIDENTIFIER";
//image style
static NSString *WXMESSAGETYPEIMAGECELLIDENTIFIER   = @"WXMESSAGETYPEIMAGECELLIDENTIFIER";
//app style
static NSString *WXMESSAGETYPEAPPCELLIDENTIFIER     = @"WXMESSAGETYPEAPPCELLIDENTIFIER";
//web style
static NSString *WXMESSAGETYPEWEBCELLIDENTIFIER     = @"WXMESSAGETYPEWEBCELLIDENTIFIER";
//music style
static NSString *WXMESSAGETYPEMUSICCELLIDENTIFIER   = @"WXMESSAGETYPEMUSICCELLIDENTIFIER";
//video style
static NSString *WXMESSAGETYPEVIDEOCELLIDENTIFIER   = @"WXMESSAGETYPEVIDEOCELLIDENTIFIER";
//enotion style
static NSString *WXMESSAGETYPEEMOTIONCELLIDENTIFIER = @"WXMESSAGETYPEEMOTIONCELLIDENTIFIER";





static CGFloat TABLEHEADERVIEHEIGHT = 300.0f;
static CGFloat REFLASHMAXCENTERY = 100.0f;
static CGFloat REFLSAHINITCENTERY = 40.0f;

static CGFloat USERFACESIZE = 75.0f;

@interface TimelineViewController ()<UITableViewDataSource,UITableViewDelegate, LXActionSheetDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    //是否正在刷新
    BOOL isRefreshing;
    //是否可以开始刷新
    BOOL startRefreshing;
}
@property (nonatomic, strong) UITableView *timeLineTableView;
@property (nonatomic, strong) UIImageView *tableViewHeaderViewBg;


@property (nonatomic, strong) UIImageView *albumReflashImageView;
@property (nonatomic, strong) UIImageView *userFaceImageView;

@property (nonatomic, strong) UIView *tableViewHeaderView;

@property (nonatomic, strong) LXActionSheet *actionSheet;

@property (nonatomic, strong) TZImagePickerController *tzImagePickerController;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerView;
@end

@implementation TimelineViewController
@synthesize moviePlayerView;
-(UIImageView *)userFaceImageView{
    if (!_userFaceImageView) {
        _userFaceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-USERFACESIZE-10, TABLEHEADERVIEHEIGHT-USERFACESIZE/3*2,USERFACESIZE , USERFACESIZE)];
        _userFaceImageView.image = [UIImage imageNamed:@"111"];
        _userFaceImageView.userInteractionEnabled = YES;
        _userFaceImageView.layer.borderWidth = 1.5;
        _userFaceImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImageViewClick)];
        [_userFaceImageView addGestureRecognizer:tap];
        
    }
    return _userFaceImageView;
}

-(UIImageView *)albumReflashImageView{
    if (!_albumReflashImageView) {
        UIImage *relahsImage = [UIImage imageNamed:@"AlbumReflashIcon"];
        _albumReflashImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, REFLSAHINITCENTERY, relahsImage.size.width, relahsImage.size.height)];
        _albumReflashImageView.centerY = REFLSAHINITCENTERY;
        _albumReflashImageView.image = relahsImage;
    }
    return _albumReflashImageView;
}

-(UIImageView *)tableViewHeaderViewBg{
    if (!_tableViewHeaderViewBg) {
        _tableViewHeaderViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLEHEADERVIEHEIGHT)];
        _tableViewHeaderViewBg.contentMode = UIViewContentModeScaleAspectFill;
        _tableViewHeaderViewBg.clipsToBounds = YES;
        _tableViewHeaderViewBg.userInteractionEnabled = YES;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"coffe" ofType:@"jpg"];
        _tableViewHeaderViewBg.image = [UIImage imageWithContentsOfFile:path];
    }
    return _tableViewHeaderViewBg;
}

- (UIView *)tableViewHeaderView
{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLEHEADERVIEHEIGHT+50.0f)];
        _tableViewHeaderView.backgroundColor = [UIColor whiteColor];
        [_tableViewHeaderView addSubview:self.tableViewHeaderViewBg];
    }
    return _tableViewHeaderView;
}

-(UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
        _imagePickerController.navigationBar.barTintColor = [UIColor blackColor];
        _imagePickerController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        
        //系统返回默认蓝色 改成白色
        _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    }
    return _imagePickerController;
}


#pragma mark -
#pragma mark - tableview lazy load

-(UITableView *)timeLineTableView{
    if (!_timeLineTableView) {
        _timeLineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT+STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
        [self.view addSubview:_timeLineTableView];
        
        _timeLineTableView.delegate = self;
        _timeLineTableView.dataSource = self;
        
        _timeLineTableView.separatorInset = UIEdgeInsetsZero;
        _timeLineTableView.layoutMargins = UIEdgeInsetsZero;
        _timeLineTableView.sectionIndexColor = [UIColor grayColor];
        _timeLineTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        _timeLineTableView.backgroundColor = self.view.backgroundColor;
        
        _timeLineTableView.tableHeaderView = self.tableViewHeaderView;
        
        
        [_timeLineTableView registerClass:[TimelineMsgTypeDefaultCell class] forCellReuseIdentifier:WXMESSAGETYPEDEFAULTCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeTextCell class] forCellReuseIdentifier:WXMESSAGETYPETEXTCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeImageCell class] forCellReuseIdentifier:WXMESSAGETYPEIMAGECELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeAppCell class] forCellReuseIdentifier:WXMESSAGETYPEAPPCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeWebCell class] forCellReuseIdentifier:WXMESSAGETYPEWEBCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeMusicCell class] forCellReuseIdentifier:WXMESSAGETYPEMUSICCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimelineMsgTypeVideoCell class] forCellReuseIdentifier:WXMESSAGETYPEVIDEOCELLIDENTIFIER];
        [_timeLineTableView registerClass:[TimeLineMsgTypeEmotionCell class] forCellReuseIdentifier:WXMESSAGETYPEEMOTIONCELLIDENTIFIER];
        
    }
    return _timeLineTableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
//    moviePlayerView = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:      [[NSBundle mainBundle]pathForResource:@"150511_JiveBike" ofType:@"mov"]]];
//    //设定播放模式
////    MPMoviePlayerController.controlStyle = MPMovieControlStyleFullscreen;
//    //控制模式(触摸)
////    MPMoviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
//    moviePlayerView.controlStyle = MPMovieControlStyleFullscreen;
//    [self.view addSubview:moviePlayerView.view];
//    moviePlayerView.view.frame = self.view.bounds;
//    
//    [moviePlayerView play];
    
    
    startRefreshing = NO;
    isRefreshing = NO;
  
    //加载导航设置
    [self setUpNav];
    
    self.datasource = DS.timeLineData[requestResult];
    
    [self.timeLineTableView reloadData];
    [self.view addSubview:self.albumReflashImageView];
    [self.tableViewHeaderView addSubview:self.userFaceImageView];
}
-(void)setUpNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"朋友圈";
    
    UIBarButtonItem *cameraButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"] style:UIBarButtonItemStylePlain target:self action:@selector(cameraBarButtonClick)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -6;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, cameraButtonItem];
    
}

//照相机
-(void)cameraBarButtonClick{
    self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"小视频", @"拍照", @"从手机相册选择", nil];
    
    [self.actionSheet showInView:self.view];

}

#pragma mark - LxActionSheetDelegate
- (void)didClickOnButtonIndex:(int)buttonIndex
{
    switch ((int)buttonIndex) {
        case 0:
        {
            NSLog(@"小视频");
            SightViewController *sightViewController = [[SightViewController alloc] init];
            MyNavViewController *signtMyNav = [[MyNavViewController alloc] initWithRootViewController:sightViewController];
            [self presentViewController:signtMyNav animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            NSLog(@"拍照");
            if (![LWSystem isCanVisitCamera]) {
                return;
            }
            
            // 系统相机
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePickerController animated:YES completion:^{
            }];
            
        }
            break;
        case 2:
        {
            NSLog(@"从手机相册选择");
            _tzImagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//            _tzImagePickerController.allowPickingVideo = NO;
//            _tzImagePickerController.allowPickingOriginalPhoto = NO;
            _tzImagePickerController.delegate = self;
            [self presentViewController:_tzImagePickerController animated:YES completion:nil];
            
            
        }
            break;
        default:
            break;
    }
}


#pragma mark - imagepickerDelgate

//  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        SendTimeLineViewController *sendTimeLineVC = [[SendTimeLineViewController alloc] init];
        sendTimeLineVC.photosArray = [NSMutableArray arrayWithArray:@[image]];
        MyNavViewController *sendNav = [[MyNavViewController alloc] initWithRootViewController:sendTimeLineVC];
        [self.navigationController presentViewController:sendNav animated:YES completion:nil];
    }];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SendTimeLineViewController *sendTimeLineVC = [[SendTimeLineViewController alloc] init];
        sendTimeLineVC.photosArray = [NSMutableArray arrayWithArray:photos];
        MyNavViewController *sendNav = [[MyNavViewController alloc] initWithRootViewController:sendTimeLineVC];
        [self.navigationController presentViewController:sendNav animated:YES completion:nil];
    });
  
}


#pragma mark -  faceImgeViewCick
-(void)faceImageViewClick{
    [self.view makeToast:@"头像"];
}


#pragma mark - TableView Delegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(TimelineBaseCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell willDisplayCell];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(TimelineBaseCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell didEndDisplayingCell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TimelineCellHeight height:_datasource[indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _datasource[indexPath.row];
    NSString *messageType = dic[WXMessageTypeKey];
 
    switch (messageType.intValue) {
        case WXMessageTypeText:
        {
            TimelineMsgTypeTextCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPETEXTCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeImage:
        {
            TimelineMsgTypeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEIMAGECELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeApp:
        {
            TimelineMsgTypeAppCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEAPPCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeWeb:
        {
            TimelineMsgTypeWebCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEWEBCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeMusic:
        {
            TimelineMsgTypeMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEMUSICCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeVideo:
        {
            TimelineMsgTypeVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEVIDEOCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
        case WXMessageTypeEmotion:
        {
            TimeLineMsgTypeEmotionCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEEMOTIONCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
            
        default:
        {
            TimelineMsgTypeTextCell *cell = [tableView dequeueReusableCellWithIdentifier:WXMESSAGETYPEDEFAULTCELLIDENTIFIER forIndexPath:indexPath];
            cell.datasource =_datasource[indexPath.row];
            return cell;
        }
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    
    if (point.y<0) {
        
        if (isRefreshing) {
            return;
        }
        
      
        CGFloat rate  = point.y/10;
        CGFloat centerY = REFLSAHINITCENTERY+fabs(point.y)-STATUS_AND_NAV_BAR_HEIGHT;
        
        if (centerY>REFLASHMAXCENTERY) {
            
            self.albumReflashImageView.centerY = REFLASHMAXCENTERY;
            
            startRefreshing = YES;
        }else{
            self.albumReflashImageView.centerY = centerY;
            startRefreshing = NO;
        }
        //旋转刷新图标
        self.albumReflashImageView.transform = CGAffineTransformMakeRotation(rate);
    }
    
 

    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (startRefreshing) {
        [self startRotate];
    }else{
        self.albumReflashImageView.centerY = REFLSAHINITCENTERY;
        
    }

}


/*
 
 下面来讲各个fillMode的意义
 kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
 kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
 kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
 kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
 
 */
-(void)startRotate{
    if (![self.albumReflashImageView.layer animationForKey:@"animation"]) {
     
        
        CABasicAnimation *animationImage = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animationImage.fromValue = [NSNumber numberWithFloat:0];
        animationImage.toValue = [NSNumber numberWithFloat:M_PI *2.0];
        animationImage.duration = 1;
        
        animationImage.repeatCount =HUGE_VALF;
        animationImage.fillMode = kCAFillModeForwards;
        [self.albumReflashImageView.layer addAnimation:animationImage forKey:@"animation"];
        
        [self performSelector:@selector(endRotate) withObject:nil afterDelay:2];
        
        isRefreshing = YES;
    }


}
-(void)endRotate{
    //上升隐藏
    [UIView animateWithDuration:0.2 animations:^{
        self.albumReflashImageView.centerY = REFLSAHINITCENTERY;
    } completion:^(BOOL finished) {
        startRefreshing = NO;
        isRefreshing = NO;
        [self.albumReflashImageView.layer removeAllAnimations];
    }];

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
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
