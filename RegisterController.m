//
//  RegisterController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController
@synthesize usernameTextField,passwordTextField,repasswordTextField,registerBtn,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];
    self.title=@"注册";
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
    float oy=self.view.frame.origin.y+44.+20.;
    usernameTextField=[[UITextField alloc]initWithFrame:CGRectMake(20., height/4+oy, width-40., 40.)];
    [usernameTextField setPlaceholder:@"请输入用户名"];
    [self setTextFieldStyle:usernameTextField];
    [usernameTextField setDelegate:self];
    
    passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20., usernameTextField.frame.origin.y+40.+5., width-40., 40.)];
    [passwordTextField setPlaceholder:@"请输入密码"];
    [self setTextFieldStyle:passwordTextField];
    [passwordTextField setClearsOnBeginEditing:YES];
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setDelegate:self];
    
    repasswordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20., passwordTextField.frame.origin.y+40.+5., width-40., 40.)];
    [repasswordTextField setPlaceholder:@"请再次确认密码"];
    [self setTextFieldStyle:repasswordTextField];
    [repasswordTextField setClearsOnBeginEditing:YES];
    [repasswordTextField setSecureTextEntry:YES];
    [repasswordTextField setDelegate:self];
    registerBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerBtn setFrame:CGRectMake(30., repasswordTextField.frame.origin.y+40.+20., width-60., 40.)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTintColor:[UIColor whiteColor]];
    [self setButtonStyle:registerBtn];
    [registerBtn setBackgroundColor:[UIColor colorWithRed:204./255. green:1./255. blue:1./255. alpha:1.f]];
    [registerBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:usernameTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:repasswordTextField];
    [self.view addSubview:registerBtn];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [repasswordTextField resignFirstResponder];
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
-(void)regist:(id)sender{
    if ([self textFieldCorrect]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //    //申明请求的数据是json类型
        //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSDictionary *parameters = @{@"name": usernameTextField.text,@"pwd":passwordTextField.text};
        [manager POST:REGISTER_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            switch ([(NSString *)[responseObject objectForKey:@"state"] intValue]) {
                case 2:
                {
                    if ([[[UserInfoStore sharedStore]allItems]count]>0) {
                        UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
                        [item setUsername:usernameTextField.text];
                        [item setPassword:passwordTextField.text];
                        [item setAutoLogin:NO];
                        [item setSavePassword:NO];
                        [[UserInfoStore sharedStore]saveChanges];
                    }else{
                        UserInfoItem *item=[[UserInfoStore sharedStore]createItem];
                        [item setUsername:usernameTextField.text];
                        [item setPassword:passwordTextField.text];
                        [item setAutoLogin:NO];
                        [item setSavePassword:NO];
                        [[UserInfoStore sharedStore]saveChanges];
                    }
                    [delegate registerSuccess];
                }
                    break;
                case 3:
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                case 4:
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                case 5:
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不符合规范" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                case 6:
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码过短" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                default:
                    break;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString *errStr=[error localizedDescription];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:errStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }];

    }
}

-(void)back:(id)sender{
    [self.delegate registerBack];
}

-(BOOL)textFieldCorrect{
    BOOL isCorrect=false;
    if(usernameTextField.text==nil||[usernameTextField.text isEqualToString:@""]||passwordTextField.text==nil||[passwordTextField.text isEqualToString:@""]||repasswordTextField.text==nil||[repasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        isCorrect=false;
    }else if(![passwordTextField.text isEqualToString:repasswordTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"两次输入密码不同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        isCorrect=false;
    }else if(usernameTextField.text.length<8){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名长度不得小于8位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        isCorrect=false;
    }else if(passwordTextField.text.length<6||passwordTextField.text.length>6){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度不对，不得小于6位，大于20位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        isCorrect=false;
    }else{
        isCorrect=true;
    }
    return isCorrect;
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
