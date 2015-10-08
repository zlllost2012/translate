//
//  UserInfoItem.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "UserInfoItem.h"

@implementation UserInfoItem
- (id)init {
    self=[super init];
    if (self) {
        self.username=@"";
        self.password=@"";
        self.autoLogin=NO;
        self.savePassword=NO;
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeBool:self.autoLogin forKey:@"autoLogin"];
    [aCoder encodeBool:self.savePassword forKey:@"savePassword"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        [self setUsername:[aDecoder decodeObjectForKey:@"username"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setAutoLogin:[aDecoder decodeBoolForKey:@"autoLogin"]];
        [self setSavePassword:[aDecoder decodeBoolForKey:@"savePassword"]];
    }
    return self;
}
@end
