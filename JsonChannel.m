//
//  JsonChannel.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "JsonChannel.h"

@implementation JsonChannel
@synthesize state;
-(int)readFromJSONDictionary:(id)d
{
    NSDictionary *rootDic=[NSJSONSerialization JSONObjectWithData:d options:0 error:nil];
    return state=[(NSString *)[rootDic objectForKey:@"state"] intValue];
}
@end
