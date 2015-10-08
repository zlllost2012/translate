//
//  VocabularyListController.h
//  汉语转维语列表
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChineseToUyghurCell.h"
#import "TempLanguageItem.h"
#import "ChineseToUyghurController.h"
#import "SQLiteManager.h"
#import "HistoryStore.h"
#import "HistoryItem.h"
@protocol cbackDelegate <NSObject>

-(void)back;

@end
@interface ChineseVocabularyListController : UITableViewController<UISearchBarDelegate>
{
    __unsafe_unretained id<cbackDelegate> delegate;
    BOOL isSearch;//是否是查询状态
    UISearchBar *searchBar;
    NSArray *vocList;//完整数据
    NSArray *showData;//查询数据
}
@property(nonatomic,assign)id<cbackDelegate> delegate;
-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)vocList;
@end
