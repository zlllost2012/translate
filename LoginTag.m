//
//  LoginTag.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "LoginTag.h"

@implementation LoginTag
@synthesize isLogin;
+(LoginTag *)shareStore{
    static LoginTag *shareStore=nil;
    if (!shareStore) {
        shareStore=[[super allocWithZone:nil]init];
    }
    return shareStore;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self shareStore];
}
-(id)init{
    self=[super init];
    if (self) {
        self.isLogin=NO;
    }
    return self;
}
@end
