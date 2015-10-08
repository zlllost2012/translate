//
//  JsonChannel.h
//  (未用)
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonChannel : NSObject

@property(nonatomic,assign)int state;
-(int)readFromJSONDictionary:(id)d;
@end
