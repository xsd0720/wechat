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
@interface CustomSearchViewController ()

@property (nonatomic, strong) UIButton *voiceSearchStartBtn;

@property (nonatomic, strong) UITextField *searchBarTextField;

@end

@implementation CustomSearchViewController


-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {

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

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    tempTabBarController.tabBar.hidden = YES;
    
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
    UITabBarController *tempTabBarController = (UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    tempTabBarController.tabBar.hidden = NO;
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
