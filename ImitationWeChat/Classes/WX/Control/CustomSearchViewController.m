//
//  CustomSearchViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "CustomSearchViewController.h"
#import "SpeechTool.h"
#import "UIImage+Color.h"
@interface fugaiView :UIView

@end

@interface CustomSearchViewController ()

@property (nonatomic, strong) UIButton *voiceSearchStartBtn;

@property (nonatomic, strong) UITextField *searchBarTextField;

@property (nonatomic, assign) BOOL isTabbarHidden;

@property (nonatomic, strong) UIView *fuGaiSearchBarView;

@end

@implementation CustomSearchViewController


-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {

        self.isAddFriendsController = NO;
        
        self.searchBar.placeholder = @"搜索";
//        self.searchBar.backgroundImage = [UIImage imageWithColor:NAVGATIONBAR_BARTINTCOLOR frame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        self.searchBar.scopeBarBackgroundImage = [UIImage new];
        self.searchBar.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;
        self.searchBar.barTintColor = NAVGATIONBAR_BARTINTCOLOR;
        self.searchBar.layer.borderColor = [NAVGATIONBAR_BARTINTCOLOR CGColor];
        self.searchBar.tintColor = RGBCOLOR(78, 184, 82);
        self.searchBar.layer.borderWidth = 1;
        self.searchBar.delegate = self;
        
        UIImage *voiceSearchStartBtnImage = [UIImage imageNamed:@"VoiceSearchStartBtn"];
        self.voiceSearchStartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.voiceSearchStartBtn setImage:voiceSearchStartBtnImage forState:UIControlStateNormal];
        [self.voiceSearchStartBtn addTarget:self action:@selector(voiceSearchStartBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
    
}

- (void)setUpSearBarFuGaiView
{
    self.isAddFriendsController = YES;
    self.searchBar.placeholder = @"微信号/手机号";
    [self.searchBar addSubview:self.fuGaiSearchBarView];
    
}


- (UIView *)fuGaiSearchBarView
{
    if (!_fuGaiSearchBarView) {
        CGFloat sh = self.searchBar.height;
        
        _fuGaiSearchBarView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.searchBar.width, sh)];
        _fuGaiSearchBarView.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *searchIcon = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, sh, sh)];
        [searchIcon setImage:[UIImage imageNamed:@"add_friend_searchicon"] forState:UIControlStateNormal];
        [_fuGaiSearchBarView addSubview:searchIcon];
        
        UILabel *searchLabelText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchIcon.frame) + 10, 0, SCREEN_WIDTH - (CGRectGetMaxX(searchIcon.frame) + 10) , sh)];
        searchLabelText.font = [UIFont systemFontOfSize:15];
        searchLabelText.textColor = wechatGraycolor;
        searchLabelText.text = @"微信号/手机号";
        [_fuGaiSearchBarView addSubview:searchLabelText];
       
    }
    return _fuGaiSearchBarView;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (self.isAddFriendsController) {
        self.fuGaiSearchBarView.hidden = YES;
    }
    
    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    self.isTabbarHidden = tempTabBarController.tabBar.isHidden;
    if (!tempTabBarController.tabBar.isHidden) {
        tempTabBarController.tabBar.hidden = YES;
    }
    
    if (!self.isAddFriendsController) {
        if (!self.voiceSearchStartBtn.superview) {
            for (UIView *subView in self.searchBar.subviews) {
                for (UIView *subsubView in subView.subviews) {
                    if ([subsubView isKindOfClass:[UITextField class]]) {
                        [self.voiceSearchStartBtn setFrame:CGRectMake(0, 0, 30, CGRectGetMaxY(subsubView.bounds))];
                        self.voiceSearchStartBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        self.voiceSearchStartBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
                        
                        UITextField *textField = (UITextField *)subsubView;
                        self.searchBarTextField = textField;
                        textField.rightViewMode = UITextFieldViewModeAlways;
                        textField.rightView = self.voiceSearchStartBtn;
                    }
                }
            }
        }
    }
    
   
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length<=0) {
        self.searchBarTextField.rightViewMode = UITextFieldViewModeAlways;
        self.searchBarTextField.rightView = self.voiceSearchStartBtn;
    }else
    {
        
        self.searchBarTextField.rightViewMode = UITextFieldViewModeNever;
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if (self.isAddFriendsController) {
        self.fuGaiSearchBarView.hidden = NO;
    }
    
    if (self.isTabbarHidden == NO) {
        UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
        tempTabBarController.tabBar.hidden = NO;
    }
 
    
    self.searchBarTextField.rightViewMode = UITextFieldViewModeNever;
 
    
}


//点击语音搜索
- (void)voiceSearchStartBtnClick:(UIButton *)sender;
{
    sender.userInteractionEnabled = NO;
    
    [[SpeechTool defaultTool] discernBlock:^(NSString *result) {
        sender.userInteractionEnabled = YES;
        self.searchBar.text = result;
    } errorBlock:^(IFlySpeechError *error) {
        sender.userInteractionEnabled = YES;
    }];


}


-(void)dealloc{
    self.searchBar.delegate = nil;
    self.voiceSearchStartBtn = nil;
}

@end

@implementation fugaiView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.superview;
}


@end
