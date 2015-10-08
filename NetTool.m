//
//  NetTool.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "NetTool.h"

@implementation NetTool
@synthesize netState;
+(NetTool *)shareItem{
    static NetTool *shareItem=nil;
    if (!shareItem) {
        shareItem=[[super allocWithZone:nil] init];
    }
    return shareItem;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self shareItem];
}
-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
-(void)getNetState{
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    //        NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                self.netState=1;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                self.netState=2;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog ( @"-------AFNetworkReachabilityStatusReachableNo------" );
                self.netState=0;
            }
                break;
            default:
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
}
@end
