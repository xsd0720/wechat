//
//  PaymentReceiptDetailViewController.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/7/13.
//  Copyright © 2016年 wany. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, MoneyType) {
    MoneyTypePay       = 1 << 0,
    MoneyTypeReceive   = 1 << 1,
};

@interface PaymentReceiptDetailViewController : BaseViewController

@property (nonatomic) MoneyType moneyType;

@end
