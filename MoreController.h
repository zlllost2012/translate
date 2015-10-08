//
//  MoreController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "AboutController.h"
#import "DownloadController.h"
#import "UserInfoItem.h"
#import "UserInfoStore.h"
#import "LoginController.h"
#import "TURL.h"
#import "JsonChannel.h"
#import "MBProgressHUD.h"
#import "MoreOptionCell.h"
#import "LoginTag.h"
#import "NetTool.h"
@protocol MoreDelegate <NSObject>

-(void)moreBack;

@end
@interface MoreController : UIViewController<UISearchBarDelegate,loginSuccessDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __unsafe_unretained id<MoreDelegate> delegate;
    MBProgressHUD *hud;
//    UISearchBar *searchBar;
    UITableView *tableView;
}
@property(nonatomic,assign)id<MoreDelegate> delegate;
//下载按钮
@property(nonatomic,retain)UIButton *downloadBtn;
//下载提示
@property(nonatomic,retain)UILabel *downloadLabel;
//更多信息按钮
@property(nonatomic,retain)UIButton *aboutBtn;
//更多提示
@property(nonatomic,retain)UILabel *aboutLabel;
//版本提示
@property(nonatomic,retain)UILabel *versionsLabel;
@end
