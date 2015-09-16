//
//  MoreController.m
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "MoreController.h"

@interface MoreController ()

@end

@implementation MoreController
@synthesize downloadBtn,aboutBtn,versionsLabel;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
//        //获取tabbaritem属性所指向的uitabbaritem对象
//        UITabBarItem *tbi=[self tabBarItem];
//        [tbi setTitle:@"更多"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, width, 44.)];
    UINavigationItem *nbi=[self navigationItem];
    [nbi setTitleView:searchBar];
    downloadBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 44+20., width/2-1, 60.)];
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downloadBtn setBackgroundColor:[UIColor redColor]];
    [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
    aboutBtn=[[UIButton alloc]initWithFrame:CGRectMake(width/2+1, 44+20., width/2-1, 60.)];
    [aboutBtn setTitle:@"关于" forState:UIControlStateNormal];
    [aboutBtn setBackgroundColor:[UIColor redColor]];
    [aboutBtn addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchDown];
    versionsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 44+20.+60., width, height-44-20.-60.)];
    [versionsLabel setText:@"版本:1.0.0"];
    [versionsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:downloadBtn];
    [self.view addSubview:aboutBtn];
    [self.view addSubview:versionsLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)download:(id)sender{
    DownloadController *downloadController=[[DownloadController alloc]init];
    [self.navigationController pushViewController:downloadController animated:YES];
}

-(void)about:(id)sender{
    AboutController *aboutController=[[AboutController alloc]init];
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
