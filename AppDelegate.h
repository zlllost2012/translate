//
//  AppDelegate.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UighurController.h"
#import "ChineseController.h"
#import "DictionaryController.h"
#import "MoreController.h"
#import "HistoryController.h"
#import "SQLiteManager.h"
#import "MobClick.h"
#import "CustomNavigationController.h"
#import <sqlite3.h>
#import "TURL.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIWebViewDelegate,SDWebImageManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UIView *adView;

@end

