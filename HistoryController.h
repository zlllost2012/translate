//
//  HistoryController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempLanguageItem.h"
#import "ChineseToUyghurCell.h"
#import "SQLiteManager.h"
#import "HistoryItem.h"
#import "HistoryStore.h"
#import "TranslateController.h"
#import "MoreController.h"
#import "MBProgressHUD.h"
@interface HistoryController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,MoreDelegate>
{
    NSArray *showData;//查询数据
    NSArray *allData;
    UISearchBar *searchBar;
    UITableView *tableView;
    MBProgressHUD *hud;
}
@end
