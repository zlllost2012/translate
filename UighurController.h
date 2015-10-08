//
//  UighurController.h
//  汉转维
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "ChineseVocabularyListController.h"
#import "MoreController.h"
#import "MBProgressHUD.h"
#import "CustomButton.h"
@interface UighurController : UIViewController<cbackDelegate,MoreDelegate>
{
    NSArray *btnArray;
//    UISearchBar *searchBar;
}
@property(nonatomic,retain)UIScrollView *btnContainer;
@end
