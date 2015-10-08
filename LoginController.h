//
//  LoginController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//
@protocol loginSuccessDelegate <NSObject>

-(void)loginSuccess;
-(void)loginBack;
@end
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "UserInfoStore.h"
#import "UserInfoItem.h"
#import "TURL.h"
#import "RegisterController.h"
#import "MBProgressHUD.h"
#import "NetTool.h"
@interface LoginController : UIViewController<registerSuccessDelegate,UITextFieldDelegate>
{
    MBProgressHUD *hud;
    __unsafe_unretained id<loginSuccessDelegate> delegate;
}
@property(nonatomic,assign)id<loginSuccessDelegate> delegate;
@property(nonatomic,retain)UITextField *nameTextField;
@property(nonatomic,retain)UITextField *passwordTextField;
@property(nonatomic,retain)UISwitch *saveBtn;
@property(nonatomic,retain)UILabel *saveLabel;
@property(nonatomic,retain)UISwitch *autoLoginBtn;
@property(nonatomic,retain)UILabel *autoLoginLabel;
@property(nonatomic,retain)UIButton *loginBtn;
@property(nonatomic,retain)UIButton *registerBtn;
@end
