//
//  UserInfoItem.h
//  用户信息实体(存储用户登录信息)
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoItem : NSObject<NSCoding>
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,assign)BOOL savePassword;
@property(nonatomic,assign)BOOL autoLogin;
@end
