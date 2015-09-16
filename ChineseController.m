//
//  ChineseController.m
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ChineseController.h"

@interface ChineseController ()

@end

@implementation ChineseController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        //获取tabbaritem属性所指向的uitabbaritem对象
//        UITabBarItem *tbi=[self tabBarItem];
//        [tbi setTitle:@"汉语"];
        UINavigationItem *nbi=[self navigationItem];
        searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
        [searchBar setBackgroundColor:[UIColor clearColor]];
        [nbi setTitleView:searchBar];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    [self initScrollView];
}

//设置按钮组
-(void)initScrollView{
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    //按钮宽高
    float btnWidth=(float)(width-10*4)/3;
    float btnHeight=btnWidth;
    float doubleBtnWidth=(float)btnWidth*2+10.;
    //scrollview内容尺寸
    float contentHeight=btnHeight*4+5*10;
    //    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, width, 44)];
    //    [self.view addSubview:searchBar];
    self.btnContainer=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, width,height)];
    self.btnContainer.contentSize=CGSizeMake(width, contentHeight);
    self.btnContainer.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.btnContainer];
    CGPoint btnOrg=CGPointMake(0, 0);
    UIButton *askBtn=[[UIButton alloc] initWithFrame:CGRectMake(btnOrg.x+10, btnOrg.y+10, doubleBtnWidth, btnHeight)];
    [askBtn setTitle:@"问答" forState:UIControlStateNormal];
    [askBtn setBackgroundColor:[UIColor grayColor]];
    [askBtn addTarget:self action:@selector(askFor:) forControlEvents:UIControlEventTouchDown];
    UIButton *tranBtn=[[UIButton alloc]initWithFrame:CGRectMake(askBtn.frame.origin.x+askBtn.frame.size.width+10, btnOrg.y+10, btnWidth, btnHeight)];
    [tranBtn setTitle:@"交通" forState:UIControlStateNormal];
    [tranBtn setBackgroundColor:[UIColor redColor]];
    UIButton *communityBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnOrg.x+10, askBtn.frame.origin.y+btnHeight+10, btnWidth, btnHeight)];
    [communityBtn setTitle:@"交流" forState:UIControlStateNormal];
    [communityBtn setBackgroundColor:[UIColor greenColor]];
    UIButton *medicalBtn=[[UIButton alloc]initWithFrame:CGRectMake(communityBtn.frame.origin.x+communityBtn.frame.size.width+10, askBtn.frame.origin.y+btnHeight+10, doubleBtnWidth, btnHeight)];
    [medicalBtn setTitle:@"媒体" forState:UIControlStateNormal];
    [medicalBtn setBackgroundColor:[UIColor purpleColor]];
    UIButton *governmentBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnOrg.x+10, medicalBtn.frame.origin.y+btnHeight+10, btnWidth, btnHeight)];
    [governmentBtn setTitle:@"政府" forState:UIControlStateNormal];
    [governmentBtn setBackgroundColor:[UIColor orangeColor]];
    UIButton *dailyExchangeBtn=[[UIButton alloc]initWithFrame:CGRectMake(governmentBtn.frame.origin.x+btnWidth+10, medicalBtn.frame.origin.y+btnHeight+10, btnWidth, btnHeight)];
    [dailyExchangeBtn setTitle:@"日常" forState:UIControlStateNormal];
    [dailyExchangeBtn setBackgroundColor:[UIColor brownColor]];
    UIButton *businessExchangeBtn=[[UIButton alloc]initWithFrame:CGRectMake(dailyExchangeBtn.frame.origin.x+btnWidth+10, medicalBtn.frame.origin.y+btnWidth+10, btnWidth, btnHeight)];
    [businessExchangeBtn setTitle:@"商务" forState:UIControlStateNormal];
    [businessExchangeBtn setBackgroundColor:[UIColor lightGrayColor]];
    UIButton *dedicatedBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnOrg.x+10, businessExchangeBtn.frame.origin.y+btnHeight+10, doubleBtnWidth, btnHeight)];
    [dedicatedBtn setTitle:@"法律" forState:UIControlStateNormal];
    [dedicatedBtn setBackgroundColor:[UIColor magentaColor]];
    UIButton *otherBtn=[[UIButton alloc]initWithFrame:CGRectMake(dedicatedBtn.frame.origin.x+doubleBtnWidth+10, businessExchangeBtn.frame.origin.y+btnHeight+10, btnWidth, btnHeight)];
    [otherBtn setTitle:@"其他" forState:UIControlStateNormal];
    [otherBtn setBackgroundColor:[UIColor blackColor]];
    btnArray=[[NSArray alloc]initWithObjects:askBtn,tranBtn,communityBtn,medicalBtn,governmentBtn,dailyExchangeBtn,businessExchangeBtn,dedicatedBtn,otherBtn, nil];
    for (int i=0; i<btnArray.count; i++) {
        [self.btnContainer addSubview:[btnArray objectAtIndex:i]];
    }
    
}
-(void)askFor:(id)sender{
    NSArray *resultArr=[[SQLiteManager shareStore]selectDataByCategory:0];
    UyghurVocabularyController *vocController=[[UyghurVocabularyController alloc]initWithStyle:UITableViewStylePlain withArray:resultArr];
    [self.navigationController pushViewController:vocController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
