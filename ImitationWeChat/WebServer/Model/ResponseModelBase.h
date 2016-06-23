//
//  ResponseModelBase.h
//  ImitationWeChat
//
//  Created by xwmedia01 on 16/6/22.
//  Copyright © 2016年 wany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseModel.h"

@interface ResponseModelBase : BaseModel

//状态
@property (nonatomic, strong) NSString *status;

//状态码
@property (nonatomic, strong) NSString *status_code;

@end
