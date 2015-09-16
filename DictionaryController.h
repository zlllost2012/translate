//
//  DictionaryController.h
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "ChineseToUyghurCell.h"
#import "TempLanguageItem.h"
#import "ChineseToUyghurController.h"
@interface DictionaryController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *showData;//查询数据
    UISearchBar *searchBar;
    UITableView *tableView;
}
@end
