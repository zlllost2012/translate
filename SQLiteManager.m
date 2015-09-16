//
//  SQLiteManager.m
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "SQLiteManager.h"
@implementation SQLiteManager
@synthesize dataFilePath;
-(id)init{
    self=[super init];
    if(self){
        dataFilePath=[self readyDatabase:@"language.sqlite"];
    }
    return self;
}
+(SQLiteManager *)shareStore{
    static SQLiteManager *shareStore=nil;
    if (!shareStore) {
        shareStore=[[super allocWithZone:nil]init];
    }
    return shareStore;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareStore];
}
-(NSString *)readyDatabase:(NSString *)dbName{
    BOOL success;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *writbaleDBPath=[documentsDirectory stringByAppendingPathComponent:dbName];
    success=[fileManager fileExistsAtPath:writbaleDBPath];
    if (!success) {
        NSString *defaultDBPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
        success=[fileManager copyItemAtPath:defaultDBPath toPath:writbaleDBPath error:&error];
        if (!success) {
            NSAssert(0, @"Failed to create writable database file with message'%@'.",[error localizedDescription]);
        }
    }
    return writbaleDBPath;
}
-(NSMutableArray *)selectDataByCategory:(int)dr
{
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
    if(sqlite3_open([self.dataFilePath UTF8String], &database)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *query=[NSString stringWithFormat:@"SELECT * FROM 'userful_data' where dr=%d",dr];
    sqlite3_stmt *statement;
    int result=sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if(result==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            int rownum=sqlite3_column_int(statement, 0);
            TempLanguageItem *languageItem=[[TempLanguageItem alloc]init];
            languageItem.num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 0)!=NULL?(char *)sqlite3_column_text(statement, 0):""];
            languageItem.hanyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 1)!=NULL?(char *)sqlite3_column_text(statement, 1):""];
            languageItem.hanyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 2)!=NULL?(char *)sqlite3_column_text(statement, 2):""];
            languageItem.hanyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 3)!=NULL?(char *)sqlite3_column_text(statement, 3):""];
            languageItem.weiyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 4)!=NULL?(char *)sqlite3_column_text(statement, 4):""];
            languageItem.weiyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 5)!=NULL?(char *)sqlite3_column_text(statement, 5):""];
            languageItem.weiyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 6)!=NULL?(char *)sqlite3_column_text(statement, 6):""];
            languageItem.dr=(int)sqlite3_column_int(statement, 7);
            languageItem.dr_num_px=(int)sqlite3_column_int(statement, 8);
            [dataArray addObject:languageItem];
            NSLog(@"第%d个为：%@", rownum, languageItem.hanyu_info);
        }
        sqlite3_finalize(statement);
    }else {
        NSAssert1(0,@"Error:%s",sqlite3_errmsg(database));
    }
    sqlite3_close(database);
    return dataArray;
}
-(NSMutableArray *)selectDataByChinese:(NSString *)str{
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
    if(sqlite3_open([self.dataFilePath UTF8String], &database)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *query=[NSString stringWithFormat:@"SELECT * FROM 'userful_data' where hanyu_info  LIKE '%%%@%%' ORDER BY hanyu_info ASC",str];
    sqlite3_stmt *statement;
    int result=sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if(result==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            int rownum=sqlite3_column_int(statement, 0);
            TempLanguageItem *languageItem=[[TempLanguageItem alloc]init];
            languageItem.num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 0)!=NULL?(char *)sqlite3_column_text(statement, 0):""];
            languageItem.hanyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 1)!=NULL?(char *)sqlite3_column_text(statement, 1):""];
            languageItem.hanyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 2)!=NULL?(char *)sqlite3_column_text(statement, 2):""];
            languageItem.hanyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 3)!=NULL?(char *)sqlite3_column_text(statement, 3):""];
            languageItem.weiyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 4)!=NULL?(char *)sqlite3_column_text(statement, 4):""];
            languageItem.weiyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 5)!=NULL?(char *)sqlite3_column_text(statement, 5):""];
            languageItem.weiyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 6)!=NULL?(char *)sqlite3_column_text(statement, 6):""];
            languageItem.dr=(int)sqlite3_column_int(statement, 7);
            languageItem.dr_num_px=(int)sqlite3_column_int(statement, 8);
            [dataArray addObject:languageItem];
            NSLog(@"第%d个为：%@", rownum, languageItem.hanyu_info);
        }
        sqlite3_finalize(statement);
    }else {
        NSAssert1(0,@"Error:%s",sqlite3_errmsg(database));
    }
    sqlite3_close(database);
    return dataArray;
}
-(NSMutableArray *)selectDataByUyghur:(NSString *)str{
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
    if(sqlite3_open([self.dataFilePath UTF8String], &database)!=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *query=[NSString stringWithFormat:@"SELECT * FROM 'userful_data' where weiyu_info  LIKE '%%%@%%' ORDER BY weiyu_info ASC",str];
    sqlite3_stmt *statement;
    int result=sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if(result==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            int rownum=sqlite3_column_int(statement, 0);
            TempLanguageItem *languageItem=[[TempLanguageItem alloc]init];
            languageItem.num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 0)!=NULL?(char *)sqlite3_column_text(statement, 0):""];
            languageItem.hanyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 1)!=NULL?(char *)sqlite3_column_text(statement, 1):""];
            languageItem.hanyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 2)!=NULL?(char *)sqlite3_column_text(statement, 2):""];
            languageItem.hanyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 3)!=NULL?(char *)sqlite3_column_text(statement, 3):""];
            languageItem.weiyu_info=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 4)!=NULL?(char *)sqlite3_column_text(statement, 4):""];
            languageItem.weiyu_sound_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 5)!=NULL?(char *)sqlite3_column_text(statement, 5):""];
            languageItem.weiyu_num=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(statement, 6)!=NULL?(char *)sqlite3_column_text(statement, 6):""];
            languageItem.dr=(int)sqlite3_column_int(statement, 7);
            languageItem.dr_num_px=(int)sqlite3_column_int(statement, 8);
            [dataArray addObject:languageItem];
            NSLog(@"第%d个为：%@", rownum, languageItem.hanyu_info);
        }
        sqlite3_finalize(statement);
    }else {
        NSAssert1(0,@"Error:%s",sqlite3_errmsg(database));
    }
    sqlite3_close(database);
    return dataArray;
}
@end
