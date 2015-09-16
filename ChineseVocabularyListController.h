//
//  VocabularyListController.h
//  汉语转维语列表
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChineseToUyghurCell.h"
#import "TempLanguageItem.h"
#import "ChineseToUyghurController.h"
#import "SQLiteManager.h"
@interface ChineseVocabularyListController : UITableViewController<UISearchBarDelegate>
{
    BOOL isSearch;//是否是查询状态
    UISearchBar *searchBar;
    NSArray *vocList;//完整数据
    NSArray *showData;//查询数据
}
-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)vocList;
@end
