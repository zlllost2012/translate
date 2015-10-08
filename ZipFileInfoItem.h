//
//  ZipFileInfo.h
//  下载文件实体
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipFileInfoItem : NSObject<NSCoding>
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *fileSize;
@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,copy)NSString *fileCurSize;
@property(nonatomic,assign)BOOL isUnzip;
@end
