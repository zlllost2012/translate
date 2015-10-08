//
//  UserInfoStore.h
//  用户信息管理类
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoItem;
@interface UserInfoStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;
+ (instancetype)sharedStore;
- (UserInfoItem *)createItem;
- (void)removeItem:(UserInfoItem *)item;
-(BOOL)saveChanges;
@end
