//
//  ZipFileInfoStore.h
//  Translate
//
//  Created by zz on 15/9/15.
//  Copyright (c) 2015年 zz. All rights reserved.
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
