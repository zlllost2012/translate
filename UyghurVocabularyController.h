//
//  UyghurVocabularyController.h
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UyghurToChineseCell.h"
#import "TempLanguageItem.h"
#import "UyghurToChineseController.h"
#import "SQLiteManager.h"
@interface UyghurVocabularyController : UITableViewController<UISearchBarDelegate>
{
    BOOL isSearch;//是否是查询状态
    UISearchBar *searchBar;
    NSArray *vocList;//完整数据
    NSArray *showData;//查询数据
}
-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)vocList;
@end
