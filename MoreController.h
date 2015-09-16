//
//  MoreController.h
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutController.h"
#import "DownloadController.h"
@interface MoreController : UIViewController
{
    UISearchBar *searchBar;
}
//下载按钮
@property(nonatomic,retain)UIButton *downloadBtn;
//更多信息按钮
@property(nonatomic,retain)UIButton *aboutBtn;
//版本提示
@property(nonatomic,retain)UILabel *versionsLabel;
@end
