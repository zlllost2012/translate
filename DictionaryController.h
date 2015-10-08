//
//  DictionaryController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "ChineseToUyghurCell.h"
#import "TempLanguageItem.h"
#import "HistoryStore.h"
#import "HistoryItem.h"
#import "TranslateController.h"
#import "MoreController.h"
#import "TURL.h"
@interface DictionaryController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,MoreDelegate>
{
    NSArray *showData;//查询数据
    UISearchBar *searchBar;
    UITableView *tableView;
}
@end
