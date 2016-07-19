//
//  FaceCreateGroupViewController.m
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/18.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "FaceCreateGroupViewController.h"
#import "CustomNumberKeyBoard.h"


@interface FacePeoplesView : UIScrollView

@property (nonatomic, strong) UIImageView *findImageView;

@property (nonatomic, strong) UIScrollView *peoplesView;

@property (nonatomic, strong) NSArray *peoples;

@property (nonatomic, assign) BOOL  isdelchongfu;

@end

@interface fgItem : UILabel

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImageView *definePoint;

@end

@interface FaceCreateGroupViewController ()<CustomKeyBoardDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) CustomNumberKeyBoard *customNumberKeyBoard;

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, strong) UILabel *inputLabel;

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndrcatorView;

@property (nonatomic, strong) UILabel *enterGrounpLabel;

@property (nonatomic, strong) UIView *enterGroupLineView;

@property (nonatomic, strong) UIButton *enterThisGroupButton;

@property (nonatomic, strong) FacePeoplesView *enterPeoplesView;

@property (nonatomic, strong) NSArray *testdataHeadArray;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FaceCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configNav];
    
    
    
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"around-friends_bg@2x.jpg" ofType:nil];
    [_bgImageView setImage:[UIImage imageWithContentsOfFile:path]];
    [self.view addSubview:_bgImageView];
    
    
    _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+64, SCREEN_WIDTH, 50)];
    _promptLabel.font = [UIFont systemFontOfSize:14];
    _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    _promptLabel.text = @"和身边的朋友输入同样的四个数字\n进入同一个群聊";
    _promptLabel.numberOfLines = 0;
    _promptLabel.textAlignment = 1;
    [self.view addSubview:_promptLabel];
    
    
    CGFloat itemSize = 40;
    CGFloat inputViewWidth = itemSize * 4;
    
    _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-inputViewWidth)/2, CGRectGetMaxY(_promptLabel.frame)+30, inputViewWidth, itemSize)];
    _inputLabel.textColor = [UIColor clearColor];
    [self.view addSubview:_inputLabel];
    
    _inputView = [[UIView alloc] initWithFrame:_inputLabel.bounds];
    [_inputLabel addSubview:_inputView];
    
    for (int i=0; i<4; i++) {
        fgItem *f = [[fgItem alloc] initWithFrame:CGRectMake(itemSize*i, 0, itemSize, itemSize)];
        [_inputView addSubview:f];
    }
    

    _customNumberKeyBoard = [[CustomNumberKeyBoard alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-55*4+0.5, SCREEN_WIDTH, KeyBoardTotalHeight)];
    _customNumberKeyBoard.delegate = self;
    [self.view addSubview:_customNumberKeyBoard];
    
    _activityIndrcatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndrcatorView.center = CGPointMake(SCREEN_WIDTH/2, CGRectGetMaxY(_inputLabel.frame)+30);
    [self.view addSubview:_activityIndrcatorView];
    
    _enterGrounpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_inputLabel.frame)+20, SCREEN_WIDTH, 25)];
    _enterGrounpLabel.alpha = 0;
    _enterGrounpLabel.text = @"这些朋友也将进入群聊";
    _enterGrounpLabel.textAlignment = 1;
    _enterGrounpLabel.font = [UIFont systemFontOfSize:15];
    _enterGrounpLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:_enterGrounpLabel];
    
    
    _enterGroupLineView = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_enterGrounpLabel.frame), SCREEN_WIDTH-60, 1)];
    _enterGroupLineView.backgroundColor = RGB(41, 44, 46);
    _enterGroupLineView.alpha = 0;
    [self.view addSubview:_enterGroupLineView];
    
    
    _enterThisGroupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_enterThisGroupButton setTitle:@"进入该群" forState:UIControlStateNormal];
    _enterThisGroupButton.backgroundColor = RGB(92, 178, 57);
    _enterThisGroupButton.layer.cornerRadius = 5;
    _enterThisGroupButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _enterThisGroupButton.frame = CGRectMake(30, SCREEN_HEIGHT + 80, SCREEN_WIDTH-60, 44);
    _enterThisGroupButton.alpha = 0;
    [self.view addSubview:_enterThisGroupButton];
    
    
    
}

- (UIView *)enterPeoplesView
{
    if (!_enterPeoplesView) {
        _enterPeoplesView = [[FacePeoplesView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_enterGroupLineView.frame) + 30, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
        _enterPeoplesView.alpha = 0;
    }
    return _enterPeoplesView;
}

- (void)didClickItem:(KeyBoardItem *)item isDelete:(BOOL)del
{
    NSString *str = _inputLabel.text;
    
    if (del) {
        if (str.length >0) {
            str = [str substringToIndex:str.length - 1];
            [self updateInputText:str];
        }
    }
    else
    {
        if (str.length>0) {
            str = [NSString stringWithFormat:@"%@%@", str, item.content];
        }else
        {
            str = item.content;
        }
        
        [self updateInputText:str];
    }
    
    
    
}

- (void)configNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"aroundfriends_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleView.text = @"面对面建群";
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = 1;
    titleView.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = titleView;
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(15, 0, 60, 44);
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem addLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateInputText:(NSString *)text
{
    
    if (text.length >4) {
        return;
    }
 
    _inputLabel.text = text;
    
    for (int i=0; i<_inputLabel.text.length; i++) {
        NSString *pwd = [_inputLabel.text substringWithRange:NSMakeRange(i, 1)];
        fgItem *f = [_inputView.subviews objectAtIndex:i];
        f.content = pwd;
    }
    
    
    
    for (int i=(int)_inputLabel.text.length; i<4; i++) {
        fgItem *f = [_inputView.subviews objectAtIndex:i];
        f.content = @"";
    }
    
    
    if (text.length >3) {
        [_activityIndrcatorView startAnimating];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animationStart];
        });
    }
    
    
    
}

- (void)animationStart
{
    [_activityIndrcatorView stopAnimating];
    [self.view addSubview:self.enterPeoplesView];
    [UIView animateWithDuration:0.8 animations:^{
        _promptLabel.alpha = 0;
        _enterGrounpLabel.alpha = 1;
        _enterGroupLineView.alpha = 1;
        _customNumberKeyBoard.alpha = 0;
        _enterThisGroupButton.alpha = 1;
        self.navigationItem.titleView.alpha = 0;
        self.enterPeoplesView.alpha = 1;
        
        
        _inputLabel.originY = 70;
        _enterGrounpLabel.originY = CGRectGetMaxY(_inputLabel.frame) + 10;
        _enterGroupLineView.originY = CGRectGetMaxY(_enterGrounpLabel.frame) + 10;
        _enterPeoplesView.originY = CGRectGetMaxY(_enterGroupLineView.frame) + 30;
        _enterThisGroupButton.originY = SCREEN_HEIGHT-88;
        
        
    } completion:^(BOOL finished) {
        _testdataHeadArray = @[@"head1.jpg",@"head2.jpg",@"head3.jpg",@"head4.jpg",@"head5.jpg",@"head6.jpg",@"head7.jpg",@"head8.jpg",@"head9.jpg",@"head0.jpg"];
        self.enterPeoplesView.peoples = @[@"head1.jpg"];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(abc) userInfo:nil repeats:YES];
        
    }];
    
}
- (void)abc
{
    if (_enterPeoplesView.peoplesView.subviews.count > 50) {
        [_timer invalidate];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.enterPeoplesView.peoples];
    [arr addObject:_testdataHeadArray[arc4random()%(_testdataHeadArray.count-1)]];
    
    self.enterPeoplesView.peoples = arr;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_timer invalidate];
}

@end

@implementation fgItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont fontWithName:@"Courier New" size:35];
//        NSMutableAttributedString
        self.textColor = [UIColor getColor:@"29d43b"];
        self.textAlignment = 1;
        
        _definePoint = [[UIImageView alloc] initWithFrame:self.bounds];
        _definePoint.height = 15;
        _definePoint.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [_definePoint setImage:[UIImage imageNamed:@"around-friends_point"]];
        _definePoint.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_definePoint];
        
    }
    return self;
}
- (void)setContent:(NSString *)content
{
    _content = content;
    
    self.text = content;
    _definePoint.hidden = content.length>0;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 3);
    CGContextSetLineJoin(c, kCGLineJoinBevel);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [[UIColor getColor:@"0e5415"] colorWithAlphaComponent:0.3];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    [super drawTextInRect:rect];

    
    self.shadowOffset = shadowOffset;
}

@end


@implementation FacePeoplesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _peoplesView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 0, self.size.width-40, self.bounds.size.height)];
        [self addSubview:_peoplesView];
        
        

        CGFloat padding = 10;
        
        CGFloat buttonSize = 60;
        
        int maxCount = _peoplesView.width/(buttonSize+padding);
        CGFloat definePadding = (_peoplesView.width-(buttonSize*maxCount+padding*(maxCount-1)))/2;
        
        _findImageView = [[UIImageView alloc] initWithFrame:CGRectMake(definePadding, definePadding, 60, 60)];
        _findImageView.image = [UIImage imageNamed:@"aroundfriends_member_2"];
        [_peoplesView addSubview:_findImageView];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
        animation.fromValue = [NSNumber numberWithFloat:1.0f];
        animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
        animation.autoreverses = YES;
        animation.duration = 1.5;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
        [_findImageView.layer addAnimation:animation forKey:@"findImageViewAnimation"];
        
    }
    return self;
}



- (void)setPeoples:(NSArray *)peoples
{
    
    if (_peoples.count == peoples.count) {
        
    }
    else
    {
       
        
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        CGFloat padding = 10;
        
        CGFloat buttonSize = 60;
        
        int maxCount = _peoplesView.width/(buttonSize+padding);
        CGFloat definePadding = (_peoplesView.width-(buttonSize*maxCount+padding*(maxCount-1)))/2;
        
        if (_isdelchongfu) {
            
            NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", _peoples];
            NSArray *unableEditArray = [peoples filteredArrayUsingPredicate:thePredicate];
            
            for (int i = 0; i<unableEditArray.count; i++) {
                
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                bt.frame = _findImageView.frame;
                bt.layer.cornerRadius = 5;
                bt.clipsToBounds = YES;
                [bt setImage:[UIImage imageNamed:peoples[i]] forState:UIControlStateNormal];
                [_peoplesView addSubview:bt];
                
                bt.alpha = 0;
                [UIView animateWithDuration:0.4 animations:^{
                    bt.alpha = 1;
                }];
                
                
                buttonX = (CGRectGetMaxX(_findImageView.frame) + padding + buttonSize) > _peoplesView.width?definePadding:(CGRectGetMaxX(_findImageView.frame) + padding);
                buttonY = (CGRectGetMaxX(_findImageView.frame) + padding + buttonSize) > _peoplesView.width?(CGRectGetMaxY(_findImageView.frame)+padding):_findImageView.originY;
                
                _findImageView.frame = CGRectMake(buttonX, buttonY, buttonSize, buttonSize);
                
            }

        }else
        {
            for (int i = (int)_peoples.count; i<peoples.count; i++) {
                
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                bt.frame = _findImageView.frame;
                bt.layer.cornerRadius = 5;
                bt.clipsToBounds = YES;
                [bt setImage:[UIImage imageNamed:peoples[i]] forState:UIControlStateNormal];
                [_peoplesView addSubview:bt];
                
                bt.alpha = 0;
                [UIView animateWithDuration:0.4 animations:^{
                    bt.alpha = 1;
                }];
              

                buttonX = (CGRectGetMaxX(_findImageView.frame) + padding + buttonSize) > _peoplesView.width?definePadding:(CGRectGetMaxX(_findImageView.frame) + padding);
                buttonY = (CGRectGetMaxX(_findImageView.frame) + padding + buttonSize) > _peoplesView.width?(CGRectGetMaxY(_findImageView.frame)+padding):_findImageView.originY;
            
                _findImageView.frame = CGRectMake(buttonX, buttonY, buttonSize, buttonSize);
                
            }

        }
           
        _peoplesView.contentSize = CGSizeMake(_peoplesView.width, MAX(CGRectGetMaxY(_findImageView.frame)+ definePadding, _peoplesView.height));
        [_peoplesView setContentOffset:CGPointMake(0, _peoplesView.contentSize.height-_peoplesView.height) animated:YES];
//        [_peoplesView scrollRectToVisible:CGRectMake(_peoplesView.contentSize.width - 1,_peoplesView.contentSize.height - 1, 1, 1) animated:YES];

        
        
        _peoples = peoples;
        
    }
    
    
    
    
   
    
    

    
    
}


@end
