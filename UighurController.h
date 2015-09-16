//
//  UighurController.h
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "ChineseVocabularyListController.h"
@interface UighurController : UIViewController
{
    NSArray *btnArray;
    UISearchBar *searchBar;
}
@property(nonatomic,retain)UIScrollView *btnContainer;
@end
