//
//  CustomSearchViewController.m
//  ImitationWeChat
//
//  Created by wany on 15/7/17.
//  Copyright (c) 2015年 wany. All rights reserved.
//

#import "CustomSearchViewController.h"

@interface CustomSearchViewController ()

@end

@implementation CustomSearchViewController


-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
        self.view.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;
    
        
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, self.searchBar.frame.size.width, 44.0);
        self.searchBar.backgroundImage = [UIImage new];

        self.searchBar.backgroundColor = NAVGATIONBAR_BARTINTCOLOR;
        self.searchBar.barTintColor = NAVGATIONBAR_BARTINTCOLOR;
        
        self.searchBar.delegate = self;

    }
    return self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.searchBar.delegate = nil;
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
