//
//  ZipFileInfo.h
//  Translate
//
//  Created by zz on 15/9/15.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipFileInfoItem : NSObject<NSCoding>
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *fileSize;
@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,copy)NSString *fileCurSize;
@property(nonatomic,assign)BOOL isUnzip;
@end
