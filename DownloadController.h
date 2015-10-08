//
//  DownloadController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TURL.h"
#import <AFURLSessionManager.h>
#import <AFHTTPRequestOperation.h>
#import "ASProgressPopUpView.h"
#import "ZipArchive.h"
#import "ZipFileInfoStore.h"
#import "ZipFileInfoItem.h"
#import "NetTool.h"
#import "MBProgressHUD.h"
@interface DownloadController : UIViewController<NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate,NSURLSessionDelegate,UIAlertViewDelegate>
{
    NSString *zipName;
    UIButton *downloadBtn;
    UIButton *unZip;
    ASProgressPopUpView *progressView;
    UILabel *progressLabel;
    BOOL isDownload;
    MBProgressHUD *hud;
}
@property(nonatomic,retain)AFHTTPRequestOperation *operation;
@end
