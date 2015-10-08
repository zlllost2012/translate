//
//  ZipFileInfo.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "ZipFileInfoItem.h"

@implementation ZipFileInfoItem
@synthesize fileName,fileCurSize,filePath,fileSize,isUnzip;
- (id)init {
    self=[super init];
    if (self) {
        self.fileName=@"";
        self.filePath=@"";
        self.fileCurSize=@"";
        self.fileSize=@"";
        self.isUnzip=NO;
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
    [aCoder encodeObject:self.fileCurSize forKey:@"fileCurSize"];
    [aCoder encodeObject:self.filePath forKey:@"filePath"];
    [aCoder encodeObject:self.fileSize forKey:@"fileSize"];
    [aCoder encodeBool:self.isUnzip forKey:@"isUnzip"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        [self setFileName:[aDecoder decodeObjectForKey:@"fileName"]];
        [self setFileCurSize:[aDecoder decodeObjectForKey:@"fileCurSize"]];
        [self setFilePath:[aDecoder decodeObjectForKey:@"filePath"]];
        [self setFileSize:[aDecoder decodeObjectForKey:@"fileSize"]];
        [self setIsUnzip:[aDecoder decodeBoolForKey:@"isUnzip"]];
    }
    return self;
}
@end
