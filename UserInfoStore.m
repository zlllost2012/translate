//
//  UserInfoStore.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "UserInfoStore.h"
#import "UserInfoItem.h"
@interface UserInfoStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end
@implementation UserInfoStore
+ (instancetype)sharedStore
{
    static UserInfoStore *sharedStore = nil;
    
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
-(NSString *)itemArchivePath{
    NSArray *documentDir=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[documentDir objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"user.archive"];
}
-(BOOL)saveChanges{
    NSString *path=[self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (UserInfoItem *)createItem
{
    UserInfoItem *item = [[UserInfoItem alloc] init];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(UserInfoItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

@end
