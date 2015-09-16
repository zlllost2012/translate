//
//  UyghurToChineseController.m
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "UyghurToChineseController.h"

@interface UyghurToChineseController ()

@end

@implementation UyghurToChineseController
@synthesize titleLabel,segmentImage,uyghurHintLabel,uyghurLabel,chineseHintLabel,chineseLabel,playBtn;
-(id)initWithItem:(TempLanguageItem *)i{
    self=[super init];
    if(self){
        item=i;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-20.-44.;
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40., 0, width-40., 44.)];
    [titleLabel setText:@"单词一览"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    UINavigationItem *nbi=[self navigationItem];
    [nbi setTitleView:titleLabel];
    playBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, height-60., width, 60.)];
    [playBtn setBackgroundColor:[UIColor redColor]];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
    segmentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (height-60.0-2.0)/2, width, 2.0)];
    [segmentImage setBackgroundColor:[UIColor grayColor]];
    uyghurHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0+44.+20., width, 60.)];
    [uyghurHintLabel setText:@"汉   语:"];
    [uyghurHintLabel setTextAlignment:NSTextAlignmentLeft];
    uyghurLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 60., width,(height-60.0-2.0)/2-60.)];
    [uyghurLabel setText:item.hanyu_info];
    [uyghurLabel setTextAlignment:NSTextAlignmentCenter];
    
    chineseHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, (height-60.0-2.0)/2+2.0, width, 60.)];
    [chineseHintLabel setText:@"维吾尔语:"];
    [chineseHintLabel setTextAlignment:NSTextAlignmentLeft];
    chineseLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, (height-60.0-2.0)/2+2.0+60., width, (height-60.0-2.0)/2-60.)];
    [chineseLabel setText:item.weiyu_info];
    [chineseLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:uyghurHintLabel];
    [self.view addSubview:uyghurLabel];
    [self.view addSubview:segmentImage];
    [self.view addSubview:chineseHintLabel];
    [self.view addSubview:chineseLabel];
    [self.view addSubview:playBtn];
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
