//
//  CountryViewController.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/24.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "BaseViewController.h"
#import "MMCountry.h"
@protocol CountryChoiceDelegate <NSObject>

- (void)didChoiceCountryCode:(MMCountry *)MMCountry;

@end

@interface CountryViewController : BaseViewController

@property (nonatomic, assign) id<CountryChoiceDelegate> delegate;

@end
