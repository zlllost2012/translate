//
//  DownloadController.h
//  Translate
//
//  Created by zz on 15/9/15.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TURL.h"
#import <AFURLSessionManager.h>
#import <AFHTTPRequestOperation.h>
#import "ASProgressPopUpView.h"
#import "ZipArchive.h"
#import "ZipFileInfoStore.h"
#import "ZipFileInfoItem.h"
@interface DownloadController : UIViewController<NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate,NSURLSessionDelegate,UIAlertViewDelegate>
{
    NSString *zipName;
    UIButton *downloadBtn;
    UIButton *unZip;
    ASProgressPopUpView *progressView;
    UILabel *progressLabel;
    BOOL isDownload;
}
@property(nonatomic,retain)AFHTTPRequestOperation *operation;
@end
