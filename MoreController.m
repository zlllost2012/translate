//
//  MoreController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "MoreController.h"

@interface MoreController ()

@end
typedef enum
{
    Download=0,
    About,
    Recommend
}
Options;
@implementation MoreController
@synthesize downloadBtn,aboutBtn,versionsLabel,downloadLabel,aboutLabel,delegate;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        float width=self.view.frame.size.width;
        float height=self.view.frame.size.height;
        float oy=self.versionsLabel.frame.origin.y+44.+20.;
        tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        UINib *nib=[UINib nibWithNibName:@"MoreOptionCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"MoreOptionCell"];
        
        //        //获取tabbaritem属性所指向的uitabbaritem对象
        //        UITabBarItem *tbi=[self tabBarItem];
        //        [tbi setTitle:@"更多"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, width, 44.)];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];
    [nbi setTitle:@"更多"];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
    
    
    //    downloadBtn=[[UIButton alloc]initWithFrame:CGRectMake((width/2-100.)/2, 44+20.+20., 100., 100.)];
    //    //    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    //    //    [downloadBtn setBackgroundColor:[UIColor redColor]];
    //    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    //    [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
    //    downloadLabel=[[UILabel alloc]initWithFrame:CGRectMake((width/2-100.)/2, 44+20.+20.+100., 100, 40.)];
    //    [downloadLabel setText:@"资源下载"];
    //    [downloadLabel setTextAlignment:NSTextAlignmentCenter];
    //    aboutBtn=[[UIButton alloc]initWithFrame:CGRectMake((width/2-100.)/2+width/2, 44+20.+20., 100., 100.)];
    //    //    [aboutBtn setTitle:@"关于" forState:UIControlStateNormal];
    //    //    [aboutBtn setBackgroundColor:[UIColor redColor]];
    //    [aboutBtn setBackgroundImage:[UIImage imageNamed:@"about.png"] forState:UIControlStateNormal];
    //    [aboutBtn addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchDown];
    //    aboutLabel=[[UILabel alloc]initWithFrame:CGRectMake((width/2-100.)/2+width/2, 44+20.+20.+100., 100, 40.)];
    //    [aboutLabel setText:@"关于我们"];
    //    [aboutLabel setTextAlignment:NSTextAlignmentCenter];
    //    versionsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 44+20.+20.+100.+40., width, height-44-20.-20.-100.-40.)];
    //    [versionsLabel setText:@"版本:1.0.0"];
    //    [versionsLabel setTextAlignment:NSTextAlignmentCenter];
    //    [self.view addSubview:downloadBtn];
    //    [self.view addSubview:downloadLabel];
    //    [self.view addSubview:aboutBtn];
    //    [self.view addSubview:aboutLabel];
    //    [self.view addSubview:versionsLabel];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreOptionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MoreOptionCell"];
    switch ([indexPath row]) {
        case Download:
        {
            [cell.iconImageView setImage:[UIImage imageNamed:@"download.png"]];
            [cell.contentLabel setText:@"音频下载"];
        }
            break;
        case About:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"about.png"]];
            [cell.contentLabel setText:@"关于我们"];
        }
            break;
        case Recommend:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"about.png"]];
            [cell.contentLabel setText:@"维文输入"];
        }
            break;
        default:
            break;
    }
    return cell;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    if(tableView.contentOffset.y>1){
//        self.tabBarController.tabBar.hidden = YES;
//
//    }else{
//        self.tabBarController.tabBar.hidden = NO;
//
//    }
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([indexPath row]) {
        case Download:
        {
            [self download];
        }
            break;
        case About:{
            [self about];
        }
            break;
        case Recommend:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
        }
            break;
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.;
}

-(void)download{
    if ([LoginTag shareStore].isLogin) {
        DownloadController *downloadController=[[DownloadController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:downloadController animated:YES];
    }else{
        if ([[[UserInfoStore sharedStore]allItems]count]>0) {
            UserInfoItem *item=[[[UserInfoStore sharedStore]allItems]lastObject];
            if(item.autoLogin){
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
                            NSDictionary *parameters = @{@"name": item.username,@"pwd":item.password};
                            [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                switch ([(NSString *)[responseObject objectForKey:@"state"] intValue]) {
                                    case 0:
                                    {
                                        [hud hide:YES];
                                        [[LoginTag shareStore] setIsLogin:YES];
                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                        DownloadController *downloadController=[[DownloadController alloc]init];
                                        [self setHidesBottomBarWhenPushed:YES];
                                        [self.navigationController pushViewController:downloadController animated:YES];
                                    }
                                        break;
                                    case 1:
                                    {
                                        hud.labelText=@"登录失败";
                                        [hud setMode:MBProgressHUDModeCustomView];
                                        [hud hide:YES afterDelay:1];
                                        LoginController *loginController=[[LoginController alloc]init];
                                        [loginController setDelegate:self];
                                        [self setHidesBottomBarWhenPushed:YES];
                                        [self.navigationController pushViewController:loginController animated:YES];
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
                                LoginController *loginController=[[LoginController alloc]init];
                                [loginController setDelegate:self];
                                [self setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:loginController animated:YES];
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
                            NSDictionary *parameters = @{@"name": item.username,@"pwd":item.password};
                            [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                switch ([(NSString *)[responseObject objectForKey:@"state"] intValue]) {
                                    case 0:
                                    {
                                        [hud hide:YES];
                                        [[LoginTag shareStore] setIsLogin:YES];
                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                        DownloadController *downloadController=[[DownloadController alloc]init];
                                        [self setHidesBottomBarWhenPushed:YES];
                                        [self.navigationController pushViewController:downloadController animated:YES];
                                    }
                                        break;
                                    case 1:
                                    {
                                        hud.labelText=@"登录失败";
                                        [hud setMode:MBProgressHUDModeCustomView];
                                        [hud hide:YES afterDelay:1];
                                        LoginController *loginController=[[LoginController alloc]init];
                                        [loginController setDelegate:self];
                                        [self setHidesBottomBarWhenPushed:YES];
                                        [self.navigationController pushViewController:loginController animated:YES];
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
                                LoginController *loginController=[[LoginController alloc]init];
                                [loginController setDelegate:self];
                                [self setHidesBottomBarWhenPushed:YES];
                                [self.navigationController pushViewController:loginController animated:YES];
                            }];
                        }
                            break;
                        case AFNetworkReachabilityStatusNotReachable:{
                            NSLog ( @"-------AFNetworkReachabilityStatusReachableNo------" );
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
                
            }else{
                LoginController *loginController=[[LoginController alloc]init];
                [loginController setDelegate:self];
                [self setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:loginController animated:YES];
            }
        }else{
            LoginController *loginController=[[LoginController alloc]init];
            [loginController setDelegate:self];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }
}

-(void)back:(id)sender{
    [self.delegate moreBack];
}

-(void)loginBack{
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)loginSuccess{
    [[LoginTag shareStore] setIsLogin:YES];
    [self.navigationController popToViewController:self animated:NO];
    DownloadController *downloadController=[[DownloadController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:downloadController animated:NO];
}
-(void)about{
    AboutController *aboutController=[[AboutController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:aboutController animated:YES];
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
