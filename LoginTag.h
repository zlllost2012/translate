//
//  LoginTag.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginTag : NSObject
@property(nonatomic)BOOL isLogin;
+(LoginTag *)shareStore;
@end
