//
//  LoginController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController
@synthesize nameTextField,passwordTextField,saveBtn,saveLabel,autoLoginBtn,autoLoginLabel,loginBtn,registerBtn,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];

    self.title=@"登录";
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
-(void)initView{
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-44.-20.;
    float oy=self.view.frame.origin.y+20.+44.;
    //用户名
    nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, height/4+oy, width-40., 40.)];
    [nameTextField setPlaceholder:@"请输入用户名"];
    [self setTextFieldStyle:nameTextField];
    UIImageView *nameImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user.png"]];
    [nameImg setFrame:CGRectMake(0, 0, 40., 40.)];
    [nameTextField setLeftView:nameImg];
    [nameTextField setLeftViewMode:UITextFieldViewModeAlways];
    [nameTextField setDelegate:self];
    //密码框
    passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, nameTextField.frame.origin.y+40.+5., width-40., 40.)];
    [passwordTextField setPlaceholder:@"请输入密码"];
    [self setTextFieldStyle:passwordTextField];
    [passwordTextField setClearsOnBeginEditing:YES];
    [passwordTextField setSecureTextEntry:YES];
    UIImageView *passwordImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password.png"]];
    [passwordImg setFrame:CGRectMake(0, 0, 40., 40.)];
    [passwordTextField setLeftView:passwordImg];
    [passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
    [passwordTextField setDelegate:self];
    //记住密码
    saveBtn=[[UISwitch alloc]initWithFrame:CGRectMake(width/20, passwordTextField.frame.origin.y+40.+10.,0,0)];
    float swidth=saveBtn.frame.size.width;
    float sheight=saveBtn.frame.size.height;
    [saveBtn setOn:NO];
    saveLabel=[[UILabel alloc]initWithFrame:CGRectMake(width/20.+10.+swidth, passwordTextField.frame.origin.y+40.+10., width*9/20-10.-swidth, sheight)];
    [saveLabel setText:@"记住密码"];
    //自动登录
    autoLoginBtn=[[UISwitch alloc]initWithFrame:CGRectMake(width*11/20, passwordTextField.frame.origin.y+40.+10., 0, 0)];
    [autoLoginBtn setOn:NO];
    [autoLoginBtn addTarget:self action:@selector(autoStateChange:) forControlEvents:UIControlEventValueChanged];
    autoLoginLabel=[[UILabel alloc]initWithFrame:CGRectMake(width*11/20+10.+swidth, passwordTextField.frame.origin.y+40.+10.,  width*9/20-10.-swidth, sheight)];
    [autoLoginLabel setText:@"自动登录"];
    //登录
    loginBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBtn setTintColor:[UIColor whiteColor]];
    [loginBtn setFrame:CGRectMake(20., autoLoginLabel.frame.origin.y+sheight+10., width-40., 40.)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self setButtonStyle:loginBtn];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:204./255. green:1./255. blue:1./255. alpha:1.f]];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    registerBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerBtn setFrame:CGRectMake(width-80., loginBtn.frame.origin.y+40.+10., 60., 20.)];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [self setButtonStyle:registerBtn];
    [registerBtn setBackgroundColor:[UIColor whiteColor]];
    [registerBtn addTarget:self action:@selector(registe:) forControlEvents:UIControlEventTouchDown];
    if ([[[UserInfoStore sharedStore]allItems]count]>0) {
        UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
        [nameTextField setText:item.username];
        if(item.savePassword){
            [passwordTextField setText:item.password];
            [saveBtn setOn:item.savePassword animated:YES];
        }
        [autoLoginBtn setOn:item.autoLogin animated:YES];
    }
    [self.view addSubview:nameTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:saveBtn];
    [self.view addSubview:saveLabel];
    [self.view addSubview:autoLoginBtn];
    [self.view addSubview:autoLoginLabel];
    [self.view addSubview:loginBtn];
    [self.view addSubview:registerBtn];
}

#pragma style
-(void)setTextFieldStyle:(UITextField *)o{
    [o setBorderStyle:UITextBorderStyleRoundedRect];
    [o setDelegate:self];
    [o setTextAlignment:NSTextAlignmentLeft];
    [o setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [o setClearButtonMode:UITextFieldViewModeWhileEditing];
}
-(void)setButtonStyle:(UIButton *)o{
    [o.layer setMasksToBounds:YES];
    [o.layer setCornerRadius:5.0];
    //设置矩形四个圆角半径
//    [o.layer setBorderWidth:1.0];
}

-(void)autoStateChange:(id)sender{
    if (autoLoginBtn.on) {
        [saveBtn setOn:YES animated:YES];
    }else{
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}
-(void)login:(id)sender{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在登录...";
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    //        NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                //申明返回的结果是json类型
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                //    //申明请求的数据是json类型
                //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
                //如果报接受类型不一致请替换一致text/html或别的
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                NSDictionary *parameters = @{@"name": nameTextField.text,@"pwd":passwordTextField.text};
                [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
                    switch ([(NSString *)[responseObject objectForKey:@"state"] intValue]) {
                        case 0:
                        {
                            if ([[[UserInfoStore sharedStore]allItems]count]>0) {
                                UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
                                [item setUsername:nameTextField.text];
                                [item setPassword:passwordTextField.text];
                                [item setAutoLogin:autoLoginBtn.on];
                                [item setSavePassword:saveBtn.on];
                                [[UserInfoStore sharedStore]saveChanges];
                            }else{
                                UserInfoItem *item=[[UserInfoStore sharedStore]createItem];
                                [item setUsername:nameTextField.text];
                                [item setPassword:passwordTextField.text];
                                [item setAutoLogin:autoLoginBtn.on];
                                [item setSavePassword:saveBtn.on];
                                [[UserInfoStore sharedStore]saveChanges];
                            }
                            [hud hide:YES];
                            [delegate loginSuccess];
                        }
                            break;
                        case 1:
                        {
                            hud.labelText=@"登录失败";
                            [hud setMode:MBProgressHUDModeCustomView];
                            [hud hide:YES afterDelay:1];
                        }
                            break;
                        default:
                            break;
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSString *errStr=[error localizedDescription];
                    hud.labelText=errStr;
                    [hud setMode:MBProgressHUDModeCustomView];
                    [hud hide:YES afterDelay:1];
                }];

            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                //申明返回的结果是json类型
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                //    //申明请求的数据是json类型
                //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
                //如果报接受类型不一致请替换一致text/html或别的
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                NSDictionary *parameters = @{@"name": nameTextField.text,@"pwd":passwordTextField.text};
                [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
                    switch ([(NSString *)[responseObject objectForKey:@"state"] intValue]) {
                        case 0:
                        {
                            if ([[[UserInfoStore sharedStore]allItems]count]>0) {
                                UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
                                [item setUsername:nameTextField.text];
                                [item setPassword:passwordTextField.text];
                                [item setAutoLogin:autoLoginBtn.on];
                                [item setSavePassword:saveBtn.on];
                                [[UserInfoStore sharedStore]saveChanges];
                            }else{
                                UserInfoItem *item=[[UserInfoStore sharedStore]createItem];
                                [item setUsername:nameTextField.text];
                                [item setPassword:passwordTextField.text];
                                [item setAutoLogin:autoLoginBtn.on];
                                [item setSavePassword:saveBtn.on];
                                [[UserInfoStore sharedStore]saveChanges];
                            }
                            [hud hide:YES];
                            [delegate loginSuccess];
                        }
                            break;
                        case 1:
                        {
                            hud.labelText=@"登录失败";
                            [hud setMode:MBProgressHUDModeCustomView];
                            [hud hide:YES afterDelay:1];
                        }
                            break;
                        default:
                            break;
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSString *errStr=[error localizedDescription];
                    hud.labelText=errStr;
                    [hud setMode:MBProgressHUDModeCustomView];
                    [hud hide:YES afterDelay:1];
                }];

            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                hud.labelText=@"无网络连接";
                [hud setMode:MBProgressHUDModeCustomView];
                [hud hide:YES afterDelay:1];
            }
                break;
            default:
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];

    }
-(void)back:(id)sender{
    [self.delegate loginBack];
}
-(void)registerSuccess{
    UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
    [nameTextField setText:item.username];
    [passwordTextField setText:item.password];
    [autoLoginBtn setOn:item.autoLogin];
    [saveBtn setOn:item.savePassword];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)registerBack{
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)registe:(id)sender{
    RegisterController *registerController=[[RegisterController alloc]init];
    [registerController setDelegate:self];
    [self.navigationController pushViewController:registerController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
