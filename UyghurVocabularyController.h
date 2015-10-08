//
//  UyghurVocabularyController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UyghurToChineseCell.h"
#import "TempLanguageItem.h"
#import "UyghurToChineseController.h"
#import "SQLiteManager.h"
#import "HistoryItem.h"
#import "HistoryStore.h"
@protocol ubackDelegate <NSObject>

-(void)back;

@end
@interface UyghurVocabularyController : UITableViewController<UISearchBarDelegate>
{
    __unsafe_unretained id<ubackDelegate> bdelegate;
    BOOL isSearch;//是否是查询状态
    UISearchBar *searchBar;
    NSArray *vocList;//完整数据
    NSArray *showData;//查询数据
}
@property(nonatomic,assign)id<ubackDelegate> bdelegate;
-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)vocList;
@end
