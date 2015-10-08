//
//  UyghurToChineseController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "UyghurToChineseController.h"

@interface UyghurToChineseController ()

@end
typedef enum
{
    AudioPlayerStateLoading=0,
    AudioPlayerStateReady,
    AudioPlayerStatePlaying,
    AudioPlayerStatePaused
}
AudioPlayerState;
@implementation UyghurToChineseController
@synthesize segmentImage,uyghurHintLabel,uyghurLabel,chineseHintLabel,chineseLabel,playBtn;
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
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];
    [nbi setTitle:@"单词一览"];
    [self initView];
    // 初始化合成器
    [self initSynthesizer];
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
    state=AudioPlayerStateLoading;
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-20.-44.;
    float oy=self.view.frame.origin.y+44.+20.;
//    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40., 0, width-40., 44.)];
//    [titleLabel setText:@"单词一览"];
//    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    UINavigationItem *nbi=[self navigationItem];
//    [nbi setTitleView:titleLabel];
    playBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, height-60.+oy, width, 60.)];
    [playBtn setBackgroundColor:[UIColor colorWithRed:204./255. green:1./255. blue:1./255. alpha:1.f]];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
    segmentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, (height-2.0-60.)/2+oy, width, 2.0)];
    [segmentImage setBackgroundColor:[UIColor grayColor]];
    uyghurHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, (height-2.0-60.)/2+2.0+oy, width-20, 60.)];
    [uyghurHintLabel setText:@"维吾尔语:"];
    [uyghurHintLabel setTextAlignment:NSTextAlignmentLeft];
    uyghurLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, (height-2.0-60.)/2+2.0+60.+oy, width-40, (height-2.0-60.)/2-60.)];
    [uyghurLabel setText:item.weiyu_info];
    [uyghurLabel setTextAlignment:NSTextAlignmentCenter];
    uyghurLabel.numberOfLines=0;
    uyghurLabel.lineBreakMode=NSLineBreakByCharWrapping;
    chineseHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, oy, width-20, 60.)];
    [chineseHintLabel setText:@"汉   语:"];
    [chineseHintLabel setTextAlignment:NSTextAlignmentLeft];
    chineseLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 60.+oy, width-40,(height-2.0-60.)/2-60.)];
    [chineseLabel setText:item.hanyu_info];
    [chineseLabel setTextAlignment:NSTextAlignmentCenter];
    chineseLabel.numberOfLines=0;
    chineseLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [self.view addSubview:uyghurHintLabel];
    [self.view addSubview:uyghurLabel];
    [self.view addSubview:segmentImage];
    [self.view addSubview:chineseHintLabel];
    [self.view addSubview:chineseLabel];
    [self.view addSubview:playBtn];
}

- (void)initSynthesizer
{
    [BDTTSSynthesizer setLogLevel:BDS_LOG_VERBOSE];
    
    // 设置合成器代理
    [[BDTTSSynthesizer sharedInstance] setSynthesizerDelegate: self];
    
    // 在线相关设置
    //#error 请替换你申请的apikey和secretkey
    [[BDTTSSynthesizer sharedInstance] setApiKey:@"2lV8z6IxZakMm5MA3eGTadnZ" withSecretKey:@"5f11a3177efd879ff40f4d4393484768"];
    [[BDTTSSynthesizer sharedInstance] setTTSServerTimeOut:10];
    
    // 离线相关设置
    NSString *textDataFile =[[NSBundle mainBundle] pathForResource:@"bd_etts_text" ofType:@"dat"];
    NSString *speechDataFile =[[NSBundle mainBundle] pathForResource:@"bd_etts_speech_female" ofType:@"dat"];
    NSString *licenseFile=[[NSBundle mainBundle]pathForResource:@"bdtts_temp_license" ofType:@"dat"];
    //#error 请替换你申请的app id
    [[BDTTSSynthesizer sharedInstance] setOfflineEngineLicense:licenseFile withAppCode:@"6851931"];
    [[BDTTSSynthesizer sharedInstance] setOfflineEngineTextDatPath:textDataFile andSpeechData:speechDataFile];
    
    // 合成参数设置
    [[BDTTSSynthesizer sharedInstance] setSynthesizeParam: BDTTS_PARAM_VOLUME withValue: BDTTS_PARAM_VOLUME_MAX];
    
    // 加载合成引擎
    [[BDTTSSynthesizer sharedInstance] loadTTSEngine];
}

-(void)loadAudio{
    NSInteger ret = [[BDTTSSynthesizer sharedInstance] speak:item.hanyu_info];
    if (ret != BDTTS_ERR_SYNTH_OK) {
        NSLog(@"%@",[BDTTSSynthesizer errorDescriptionForCode:ret]);
    }
}

-(void)play:(id)sender{
    if(state==AudioPlayerStatePlaying){
        [[BDTTSSynthesizer sharedInstance] pause];
    }else if(state==AudioPlayerStatePaused){
        [[BDTTSSynthesizer sharedInstance] resume];
    }else if(state==AudioPlayerStateReady){
        return;
    }else if(state==AudioPlayerStateLoading){
        state=AudioPlayerStateReady;
        [self loadAudio];
    }
}

-(void)back:(id)sender{
    [[BDTTSSynthesizer sharedInstance]cancel];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateControls
{
    switch (state) {
        case AudioPlayerStateReady:
        {
            [playBtn setTitle:@"播放" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStatePlaying:{
            [playBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStatePaused:{
            [playBtn setTitle:@"继续播放" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStateLoading:{
            [playBtn setTitle:@"播放" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
#pragma BDTTSdelegate
//合成开始
-(void)synthesizerStartWorking{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在合成音频";
}
//合成完成
-(void)synthesizerFinishWorking{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    state=AudioPlayerStatePlaying;
    [self updateControls];
}
//开始朗读
- (void)synthesizerSpeechStart{
    state=AudioPlayerStatePlaying;
    [self updateControls];
}
/**
 * @brief 朗读已暂停
 *
 */
- (void)synthesizerSpeechDidPaused
{
    state=AudioPlayerStatePaused;
    [self updateControls];
}
/**
 * @brief 朗读已继续
 *
 */
- (void)synthesizerSpeechDidResumed
{
    state=AudioPlayerStatePlaying;
    [self updateControls];
}
/**
 * @brief 朗读完成
 *
 */
- (void)synthesizerSpeechDidFinished
{
    state=AudioPlayerStateLoading;
    [self updateControls];
}
/**
 * @brief 合成器发生错误
 *
 * @param error 错误对象
 */
- (void)synthesizerErrorOccurred:(NSError *)error
{
}
/**
 * @brief 合成器将开始播报，可以在此消息中设置相应的audio session
 *
 */
- (void)synthesizerSpeechWillStart
{
    
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
