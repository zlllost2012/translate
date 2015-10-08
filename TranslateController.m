//
//  TranslateController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "TranslateController.h"

@interface TranslateController ()

@end
typedef enum
{
    AudioPlayerStateLoading1=0,
    AudioPlayerStateReady1,
    AudioPlayerStatePlaying1,
    AudioPlayerStatePaused1
}
AudioPlayerState1;
typedef enum
{
    Chinese=0,
    Uyghur
}
LanguageState;
@implementation TranslateController
@synthesize titleLabel,segmentImageUp,segmentImageDown,uyghurHintLabel,uyghurLabel,chineseHintLabel,chineseLabel,playBtn,changeBtn;
-(id)initWithItem:(TempLanguageItem *)i{
    self=[super init];
    if(self){
        item=i;
        audioPlayer=[[AudioPlayer alloc]init];
        audioPlayer.delegate=self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem animated:YES];
    [nbi setTitle:@"单词一览"];
    //初始化为汉语状态
    languageState=Chinese;
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
    state=AudioPlayerStateLoading1;
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-44.-20.;
    float oy=self.view.frame.origin.y+44.+20.;
//    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40., 0, width-40., 44.)];
//    [titleLabel setText:@"单词一览"];
//    [titleLabel setTextAlignment:NSTextAlignmentCenter];
 
    
    uyghurHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, oy, width-20., 60.)];
    [uyghurHintLabel setText:@"汉   语:"];
    [uyghurHintLabel setTextAlignment:NSTextAlignmentLeft];
    uyghurLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 60.+oy, width-40.,(height-40.-4.0-60.)/2-60.)];
    [uyghurLabel setText:item.hanyu_info];
    [uyghurLabel setTextAlignment:NSTextAlignmentCenter];
    uyghurLabel.numberOfLines=0;
    uyghurLabel.lineBreakMode=NSLineBreakByCharWrapping;
    //上分割线
    segmentImageUp=[[UIImageView alloc]initWithFrame:CGRectMake(0, (height-4.0-40.-60.)/2+oy, width, 2.0)];
    [segmentImageUp setBackgroundColor:[UIColor colorWithRed:88./255. green:209./255. blue:91./255. alpha:1.f]];
    
    changeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, (height-4.0-40.-60.)/2+2.0+oy, width, 40.)];
    [changeBtn setTitle:@"汉语发音" forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
    [changeBtn setBackgroundColor:[UIColor colorWithRed:88./255. green:209./255. blue:91./255. alpha:1.f]];
    //下分割线
    segmentImageDown=[[UIImageView alloc]initWithFrame:CGRectMake(0, (height-4.0-40.-60.)/2+40.+2.+oy, width, 2.0)];
    [segmentImageDown setBackgroundColor:[UIColor colorWithRed:88./255. green:209./255. blue:91./255. alpha:1.f]];


    
    chineseHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, (height-4.0-40.-60.)/2+4.0+40.+oy, width-20., 60.)];
    [chineseHintLabel setText:@"维吾尔语:"];
    [chineseHintLabel setTextAlignment:NSTextAlignmentLeft];
    chineseLabel=[[UILabel alloc]initWithFrame:CGRectMake(20., (height-4.0-40.-60.)/2+4.0+40.+60.+oy, width-40., (height-40.0-4.0-60.)/2-60.)];
    [chineseLabel setText:item.weiyu_info];
    [chineseLabel setTextAlignment:NSTextAlignmentCenter];
    chineseLabel.numberOfLines=0;
    chineseLabel.lineBreakMode=NSLineBreakByCharWrapping;
    playBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, (height-4.0-40.-60.)+oy+4.+40., width, 60.)];
    [playBtn setBackgroundColor:[UIColor colorWithRed:204./255. green:1./255. blue:1./255. alpha:1.f]];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:uyghurHintLabel];
    [self.view addSubview:uyghurLabel];
    [self.view addSubview:segmentImageUp];
    [self.view addSubview:changeBtn];
    [self.view addSubview:segmentImageDown];
    [self.view addSubview:chineseHintLabel];
    [self.view addSubview:chineseLabel];
    [self.view addSubview:playBtn];
}
-(void)change:(id)sender{
    switch (languageState) {
        case Chinese:
        {
            [[BDTTSSynthesizer sharedInstance]cancel];
            languageState=Uyghur;
            [playBtn setTitle:@"播放" forState:UIControlStateNormal];
            [playBtn removeTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
            [changeBtn setTitle:@"维语发音" forState:UIControlStateNormal];
            [playBtn addTarget:self action:@selector(aplay:) forControlEvents:UIControlEventTouchDown];
        }
            break;
        case Uyghur:{
            if (audioPlayer!=nil) {
                [audioPlayer dispose];
            }
            languageState=Chinese;
            [playBtn setTitle:@"播放" forState:UIControlStateNormal];
            [playBtn removeTarget:self action:@selector(aplay:) forControlEvents:UIControlEventTouchDown];
            [changeBtn setTitle:@"汉语发音" forState:UIControlStateNormal];
            [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
        }
            break;
        default:
            break;
    }
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
    if(state==AudioPlayerStatePlaying1){
        [[BDTTSSynthesizer sharedInstance] pause];
    }else if(state==AudioPlayerStatePaused1){
        [[BDTTSSynthesizer sharedInstance] resume];
    }else if(state==AudioPlayerStateReady1){
        return;
    }else if(state==AudioPlayerStateLoading1){
        state=AudioPlayerStateReady;
        [self loadAudio];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateControls
{
    switch (state) {
        case AudioPlayerStateReady1:
        {
            [playBtn setTitle:@"播放" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStatePlaying1:{
            [playBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStatePaused1:{
            [playBtn setTitle:@"继续播放" forState:UIControlStateNormal];
        }
            break;
        case AudioPlayerStateLoading1:{
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
    state=AudioPlayerStatePlaying1;
    [self updateControls];
}
//开始朗读
- (void)synthesizerSpeechStart{
    state=AudioPlayerStatePlaying1;
    [self updateControls];
}
/**
 * @brief 朗读已暂停
 *
 */
- (void)synthesizerSpeechDidPaused
{
    state=AudioPlayerStatePaused1;
    [self updateControls];
}
/**
 * @brief 朗读已继续
 *
 */
- (void)synthesizerSpeechDidResumed
{
    state=AudioPlayerStatePlaying1;
    [self updateControls];
}
/**
 * @brief 朗读完成
 *
 */
- (void)synthesizerSpeechDidFinished
{
    state=AudioPlayerStateLoading1;
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
//////////////////////////////////////调用播放器
-(void)aloadAudio{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在获取音频";
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *audioPath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",item.weiyu_sound_id]];
    if ([fileManager fileExistsAtPath:audioPath]) {
        AFSoundItem *audioItem = [[AFSoundItem alloc] initWithLocalResource:audioPath atPath:nil];
        
        AFSoundPlayback *player = [[AFSoundPlayback alloc] initWithItem:audioItem];
        
        [player play];
    }else{
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AUDIO_URL,item.weiyu_sound_id]];
        if (url!=nil) {
            [audioPlayer setDataSource:[audioPlayer dataSourceFromURL:url] withQueueItemId:url];
        }else{
            hud.labelText=@"无法获取音频文件";
            [hud setMode:MBProgressHUDModeCustomView];
            [hud hide:YES afterDelay:1];
        }
    }
}
-(void)aplay:(id)sender{
    if (!audioPlayer)
    {
        return;
    }
    
    if (audioPlayer.state == AudioPlayerStatePaused)
    {
        [audioPlayer resume];
    }else if (audioPlayer.state == AudioPlayerStatePlaying)
    {
        [audioPlayer pause];
    }
    else
    {
        [self aloadAudio];
    }
}

-(void)aupdateControls
{
    if (audioPlayer == nil)
    {
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
    else if (audioPlayer.state == AudioPlayerStatePaused)
    {
        [playBtn setTitle:@"继续播放" forState:UIControlStateNormal];
    }
    else if (audioPlayer.state == AudioPlayerStatePlaying)
    {
        [playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else
    {
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
}

-(void)back:(id)sender{
    [[BDTTSSynthesizer sharedInstance]cancel];
    if (audioPlayer!=nil) {
        [audioPlayer dispose];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//状态改变
-(void) audioPlayer:(AudioPlayer*)audioPlayer stateChanged:(AudioPlayerState)state
{
    [self aupdateControls];
}
//
-(void) audioPlayer:(AudioPlayer*)audioPlayer didEncounterError:(AudioPlayerErrorCode)errorCode
{
    [self aupdateControls];
}
//开始播放
-(void) audioPlayer:(AudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self aupdateControls];
}
//完成加载
-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self aupdateControls];
}
//完成播放
-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(AudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    [self aupdateControls];
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
