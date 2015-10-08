//
//  NetTool.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetTool : NSObject
@property(nonatomic)int netState;
+(NetTool *)shareItem;
-(void)getNetState;
@end
