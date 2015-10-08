//
//  RegisterController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//
@protocol registerSuccessDelegate <NSObject>

-(void)registerSuccess;
-(void)registerBack;
@end
#import <UIKit/UIKit.h>
#import "TURL.h"
#import "UserInfoItem.h"
#import "UserInfoStore.h"
#import <AFNetworking.h>
#import "NetTool.h"
#import "MBProgressHUD.h"
@interface RegisterController : UIViewController<UITextFieldDelegate>
{
    MBProgressHUD *hud;
    __unsafe_unretained id<registerSuccessDelegate> delegate;
}
@property(nonatomic,assign)id<registerSuccessDelegate> delegate;
@property(nonatomic,retain)UITextField *usernameTextField;
@property(nonatomic,retain)UITextField *passwordTextField;
@property(nonatomic,retain)UITextField *repasswordTextField;
@property(nonatomic,retain)UIButton *registerBtn;
@end
