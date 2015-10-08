//
//  HistoryStore.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "HistoryStore.h"
#import "HistoryItem.h"
@implementation HistoryStore
+(HistoryStore *)sharedStore
{
    static HistoryStore *sharedStore=nil;
    if (!sharedStore) {
        sharedStore=[[super allocWithZone:nil]init];
    }
    return sharedStore;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}
-(id)init{
    self=[super init];
    if (self) {
        //读取xcdatamodeld
        model=[NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        //设置sql路径
        NSString *path=[self itemArchivePath];
        NSURL *storeURL=[NSURL fileURLWithPath:path];
        NSError *error=nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            [NSException raise:@"open failed" format:@"Reason:%@",[error localizedDescription]];
        }
        //创建nsmanagedobjectcontext对象
        context=[[NSManagedObjectContext alloc]init];
        [context setPersistentStoreCoordinator:psc];
        
        [context setUndoManager:nil];
        [self loadAllItems];
    }
    return self;
}

-(HistoryItem *)createItem{
    double order;
    if ([allItems count]==0) {
        order=1.0;
    }else{
        order=[[allItems lastObject] orderingValue]+1.0;
    }
    HistoryItem *p=[NSEntityDescription insertNewObjectForEntityForName:@"HistoryItem" inManagedObjectContext:context];
    [p setOrderingValue:order];
    [allItems addObject:p];
    return p;
}

-(void)removeItem:(HistoryItem *)p{
    [context deleteObject:p];
    [allItems removeObjectIdenticalTo:p];
}

-(BOOL)saveChanges{
    NSError *err=nil;
    BOOL successful=[context save:&err];
    if (!successful) {
        NSLog(@"error saving:%@",[err localizedDescription]);
    }
    return successful;
}
-(NSArray *)selectItem:(NSString *)s{
    selectItems=[[NSMutableArray alloc]init];
    if (allItems) {
        NSString *ps=[NSString stringWithFormat:@"hanyu_info LIKE '*%@*'||weiyu_info LIKE '*%@*'",s,s];
        NSPredicate *p=[NSPredicate predicateWithFormat:ps];
        NSArray *result=[allItems filteredArrayUsingPredicate:p];
        [selectItems addObjectsFromArray:result];
    }
    return selectItems;
}
-(NSArray *)loadAllItems{
    if (!allItems) {
        NSFetchRequest *request=[[NSFetchRequest alloc]init];
        NSEntityDescription *e=[[model entitiesByName]objectForKey:@"HistoryItem"];
        [request setEntity:e];
        NSSortDescriptor *sd=[NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result=[context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"fetch failed" format:@"reason:%@",[error localizedDescription]];
        }
        allItems=[[NSMutableArray alloc]initWithArray:result];
    }
    return [NSArray arrayWithArray:allItems];
}

-(void)removeAll{
    int num=(int)[allItems count];
    for(int i=num;i>0;i--){
        [self removeItem:[allItems objectAtIndex:i-1]];
    }
}
-(NSString *)itemArchivePath{
    NSArray *documentDirectories=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"history.data"];
}
@end
