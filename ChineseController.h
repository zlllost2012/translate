//
//  ChineseController.h
//  维转汉
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "UyghurVocabularyController.h"
#import "MBProgressHUD.h"
#import "MoreController.h"
#import "CustomButton.h"
@interface ChineseController : UIViewController<ubackDelegate,MoreDelegate>
{
    NSArray *btnArray;
//    UISearchBar *searchBar;
}
@property(nonatomic,retain)UIScrollView *btnContainer;
@end
