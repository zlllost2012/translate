//
//  AboutController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
{
    UIWebView *phoneCallWebView;
    UIWebView *webView;
}
@end

@implementation AboutController
@synthesize contentLabel,logoImg,webBtn,telBtn,segmentImg,mainView;
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem *nbi=[self navigationItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];
    [nbi setTitle:@"关于我们"];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView{
        float width=[[UIScreen mainScreen]bounds].size.width;
    mainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, [[UIScreen mainScreen]bounds].size.height)];
    mainView.contentSize=mainView.frame.size;
    
    
    logoImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    float imgWidth=logoImg.frame.size.width;
    float imgHeight=logoImg.frame.size.height;
    float height=width/2*imgHeight/imgWidth;
    [logoImg setFrame:CGRectMake(width/4, 0, width/2, height)];
    [mainView addSubview:logoImg];
    
    segmentImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, height+1., width, 2.0)];
    [segmentImg setBackgroundColor:[UIColor grayColor]];
    [mainView addSubview:segmentImg];
    NSString *str = @"       新疆华虎网络科技有限公司是一家执著行动于丝绸之路经济带语言文化传播的科技型企业，注册资金 1000 万元。公司现拥有各类技术人员 35 人， 其中， 教授级别研究员 2 名、 教授 4 名、 副教授 2 名， 以及语言教育、 翻译等专家10名管理团队3人； 软件程序开发人员12人， 全部为本科以上学历， 并具有5年以上研发工作经验。\n       公司将丝绸之路经济带沿线国家无障碍沟通作为公司发展的奋斗目标， 先后开发了“维汉学习通 ”、“维汉大词典 ”、“掌上维语 ”、“丝路翻译器 ”、“丝路导游官 ”等一批文化创意产品。 在“ 一带一路”国家战略的号召下， 公司现集中各方面优势资源， 打造的以汉语言作为中枢交流信息媒介的多语种语言服务基地。";
    UIFont *font = [UIFont systemFontOfSize:15.];
    CGSize size = CGSizeMake(width,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 1.+2.+height, labelRect.size.width-20, labelRect.size.height+50)];
    contentLabel.text = str;
    contentLabel.font = [UIFont systemFontOfSize:15.];
    contentLabel.numberOfLines=0;
    [mainView addSubview: contentLabel];
    
    UILabel *tel=[[UILabel alloc]initWithFrame:CGRectMake(10, contentLabel.frame.origin.y+contentLabel.frame.size.height, 80., 20.)];
    [tel setText:@"联系电话:"];
    [tel setTextAlignment:NSTextAlignmentLeft];
    [tel setFont:[UIFont systemFontOfSize:15.]];
    [mainView addSubview:tel];
    telBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [telBtn setFrame:CGRectMake(tel.frame.origin.x+tel.frame.size.width+10., tel.frame.origin.y, 100., 20.)];
    [telBtn setTitle:@"0991-4526699" forState:UIControlStateNormal];
    [telBtn setBackgroundColor:[UIColor whiteColor]];
    telBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [telBtn addTarget:self action:@selector(callTel:) forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:telBtn];
    UILabel *web=[[UILabel alloc]initWithFrame:CGRectMake(10, tel.frame.origin.y+tel.frame.size.height+10., 80., 20.)];
    [web setText:@"公司网址:"];
    [web setTextAlignment:NSTextAlignmentLeft];
    [web setFont:[UIFont systemFontOfSize:15.]];
    [mainView addSubview:web];
    webBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [webBtn setFrame:CGRectMake(web.frame.origin.x+web.frame.size.width+10., web.frame.origin.y, 180., 20.)];
    [webBtn setTitle:@"http://www.xjhuahu.cn" forState:UIControlStateNormal];
    [webBtn setBackgroundColor:[UIColor whiteColor]];
    webBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [webBtn addTarget:self action:@selector(openWeb:) forControlEvents:UIControlEventTouchDown];
    [mainView addSubview:webBtn];
    mainView.contentSize=CGSizeMake(width, webBtn.frame.origin.y+20.);
    [self.view addSubview:mainView];
}
-(void)callTel:(id)sender{
    NSString *phoneNum = @"0991-4526699";// 电话号码
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    
    if ( !phoneCallWebView ) {
        
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来 但是这个方法是合法的
        
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [self.view addSubview:phoneCallWebView];
}
-(void)openWeb:(id)sender{
    NSString *webUrl = @"http://www.xjhuahu.cn";// 跳转网页
    
    NSURL *url = [NSURL URLWithString:webUrl];
    
    if ( !webView ) {
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44+20., [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        [webView setScalesPageToFit:YES];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
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
//返回
-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
