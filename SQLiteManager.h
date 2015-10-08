//
//  SQLiteManager.h
//  sqlite管理类
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TempLanguageItem.h"
@interface SQLiteManager : NSObject
@property(nonatomic,retain)NSString *dataFilePath;
+(SQLiteManager *)shareStore;
//根据分类查询
-(NSMutableArray *)selectDataByCategory:(int)dr;
//根据汉语查询信息
-(NSMutableArray *)selectDataByChinese:(NSString *)str;
//根据维吾尔语查询信息
-(NSMutableArray *)selectDataByUyghur:(NSString *)str;
//查询信息
-(NSMutableArray *)selectData:(NSString *)str;
@end
