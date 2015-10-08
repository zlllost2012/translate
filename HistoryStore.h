//
//  HistoryStore.h
//  历史记录管理类
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class HistoryItem;
@interface HistoryStore : NSObject
{
    NSMutableArray *allItems;
    NSMutableArray *selectItems;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}
+(HistoryStore *)sharedStore;
-(HistoryItem *)createItem;
-(BOOL)saveChanges;
-(NSArray *)loadAllItems;
-(void)removeItem:(HistoryItem *)p;
-(NSArray *)selectItem:(NSString *)s;
-(void)removeAll;
@end
