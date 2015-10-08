//
//  UighurController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "UighurController.h"

@interface UighurController ()

@end

@implementation UighurController
@synthesize btnContainer;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        //获取tabbaritem属性所指向的uitabbaritem对象
//        UITabBarItem *tbi=[self tabBarItem];
//        [tbi setTitle:@"维语"];
        UINavigationItem *nbi=[self navigationItem];
        UIBarButtonItem *moreBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
        [nbi setRightBarButtonItem:moreBtn];
        [nbi setTitle:@"维汉学习通"];
//        searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
//        [searchBar setBackgroundColor:[UIColor clearColor]];
//        [nbi setTitleView:searchBar];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
}
//设置按钮组
-(void)initScrollView{
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-44.-20.-49.;
    float oy=44.+20.;
    //按钮宽高
//    float btnWidth=(float)(width-10*4)/3;
//    float btnHeight=btnWidth;
//    float doubleBtnWidth=(float)btnWidth*2+10.;
    float btnWidth=(float)(width)/3;
    float btnHeight=(float)(height)/3;
    //scrollview内容尺寸
//    float contentHeight=btnHeight*3;
//    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, width, 44)];
//    [self.view addSubview:searchBar];
    self.btnContainer=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, width,self.view.frame.size.height)];
    self.btnContainer.contentSize=CGSizeMake(width, height);
    self.btnContainer.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.btnContainer];
    CGPoint btnOrg=CGPointMake(0, 0);
    //问候称谓
    CustomButton *askBtn=[[CustomButton alloc] initWithFrame:CGRectMake(0,0, btnWidth, btnHeight)];
    [askBtn setImage:[UIImage imageNamed:@"ask_c.png"] forState:UIControlStateNormal];
//    [askBtn setTitle:@"问候称谓" forState:UIControlStateNormal];
    [self setBtnSrtyle:askBtn];
    [askBtn addTarget:self action:@selector(askFor:) forControlEvents:UIControlEventTouchDown];
    //旅游交通
    CustomButton *tranBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth, 0, btnWidth, btnHeight)];
    [tranBtn setImage:[UIImage imageNamed:@"tran_c.png"] forState:UIControlStateNormal];
//    [tranBtn setTitle:@"旅游交通" forState:UIControlStateNormal];
    [self setBtnSrtyle:tranBtn];
    [tranBtn addTarget:self action:@selector(tranFor:) forControlEvents:UIControlEventTouchDown];
    //医疗救助
    CustomButton *communityBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth*2, 0, btnWidth, btnHeight)];
    [communityBtn setImage:[UIImage imageNamed:@"com_c.png"] forState:UIControlStateNormal];
//    [communityBtn setTitle:@"医疗救助" forState:UIControlStateNormal];
    [self setBtnSrtyle:communityBtn];
    [communityBtn addTarget:self action:@selector(communityFor:) forControlEvents:UIControlEventTouchDown];
    //社区服务
    CustomButton *medicalBtn=[[CustomButton alloc]initWithFrame:CGRectMake(0, btnHeight, btnWidth, btnHeight)];
    [medicalBtn setImage:[UIImage imageNamed:@"med_c.png"] forState:UIControlStateNormal];
//    [medicalBtn setTitle:@"社区服务" forState:UIControlStateNormal];
    [self setBtnSrtyle:medicalBtn];
    [medicalBtn addTarget:self action:@selector(medicalFor:) forControlEvents:UIControlEventTouchDown];
    //政府司法
    CustomButton *governmentBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth,btnHeight, btnWidth, btnHeight)];
    [governmentBtn setImage:[UIImage imageNamed:@"gov_c.png"] forState:UIControlStateNormal];
//    [governmentBtn setTitle:@"政府司法" forState:UIControlStateNormal];
    [self setBtnSrtyle:governmentBtn];
    [governmentBtn addTarget:self action:@selector(governmentFor:) forControlEvents:UIControlEventTouchDown];
    //日常交流
    CustomButton *dailyExchangeBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth*2, btnHeight, btnWidth, btnHeight)];
    [dailyExchangeBtn setImage:[UIImage imageNamed:@"dai_c.png"] forState:UIControlStateNormal];
//    [dailyExchangeBtn setTitle:@"日常交流" forState:UIControlStateNormal];
    [self setBtnSrtyle:dailyExchangeBtn];
    [dailyExchangeBtn addTarget:self action:@selector(dailyExchangeFor:) forControlEvents:UIControlEventTouchDown];
    //商业交流
    CustomButton *businessExchangeBtn=[[CustomButton alloc]initWithFrame:CGRectMake(0, btnHeight*2, btnWidth, btnHeight)];
    [businessExchangeBtn setImage:[UIImage imageNamed:@"bus_c.png"] forState:UIControlStateNormal];
//    [businessExchangeBtn setTitle:@"商业交流" forState:UIControlStateNormal];
    [self setBtnSrtyle:businessExchangeBtn];
    [businessExchangeBtn addTarget:self action:@selector(businessExchangeFor:) forControlEvents:UIControlEventTouchDown];
    //援疆专用
    CustomButton *dedicatedBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth, btnHeight*2, btnWidth, btnHeight)];
    [dedicatedBtn setImage:[UIImage imageNamed:@"ded_c.png"] forState:UIControlStateNormal];
//    [dedicatedBtn setTitle:@"援疆专用" forState:UIControlStateNormal];
    [self setBtnSrtyle:dedicatedBtn];
    [dedicatedBtn addTarget:self action:@selector(dedicatedFor:) forControlEvents:UIControlEventTouchDown];
    //访惠聚
    CustomButton *otherBtn=[[CustomButton alloc]initWithFrame:CGRectMake(btnWidth*2, btnHeight*2, btnWidth, btnHeight)];
    [otherBtn setImage:[UIImage imageNamed:@"oth_c.png"] forState:UIControlStateNormal];
//    [otherBtn setTitle:@"访惠聚" forState:UIControlStateNormal];
    [self setBtnSrtyle:otherBtn];
    [otherBtn addTarget:self action:@selector(otherFor:) forControlEvents:UIControlEventTouchDown];
    btnArray=[[NSArray alloc]initWithObjects:askBtn,tranBtn,communityBtn,medicalBtn,governmentBtn,dailyExchangeBtn,businessExchangeBtn,dedicatedBtn,otherBtn, nil];
    for (int i=0; i<btnArray.count; i++) {
        [self.btnContainer addSubview:[btnArray objectAtIndex:i]];
    }

}
-(void)setBtnSrtyle:(UIButton *)btn{
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //    [dedicatedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        [dedicatedBtn setImageEdgeInsets:UIEdgeInsetsMake(-(btnHeight-imgHeight), 0, 0, 0)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
}
-(void)askFor:(id)sender{
    [self getData:1];
}
-(void)tranFor:(id)sender{
    [self getData:2];
}
-(void)communityFor:(id)sender{
    [self getData:3];
}
-(void)medicalFor:(id)sender{
    [self getData:4];
}
-(void)governmentFor:(id)sender{
    [self getData:5];
}
-(void)dailyExchangeFor:(id)sender{
    [self getData:6];
}
-(void)businessExchangeFor:(id)sender{
    [self getData:7];
}
-(void)dedicatedFor:(id)sender{
    [self getData:8];
}
-(void)otherFor:(id)sender{
    [self getData:9];
}
-(void)getData:(int)dr{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *resultArr=[[SQLiteManager shareStore]selectDataByCategory:dr];
    hud.labelText = @"正努力加载...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            ChineseVocabularyListController *vocController=[[ChineseVocabularyListController alloc]initWithStyle:UITableViewStylePlain withArray:resultArr];
            [vocController setDelegate:self];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vocController animated:YES];
        });
    });
}
-(void)more:(id)sender{
    MoreController *moreController=[[MoreController alloc]init];
    [moreController setDelegate:self];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:moreController animated:YES];
}
-(void)moreBack{
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController popToViewController:self animated:YES];
}
-(void)back{
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController popToViewController:self animated:YES];
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
