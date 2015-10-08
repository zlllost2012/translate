//
//  ZipFileInfoStore.h
//  下载实体管理类
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipFileInfoItem.h"
@class ZipFileInfoItem;
@interface ZipFileInfoStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;
+ (instancetype)sharedStore;
- (ZipFileInfoItem *)createItem;
- (void)removeItem:(ZipFileInfoItem *)item;
-(BOOL)saveChanges;
@end
