//
//  ChineseToUyghurController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "ChineseToUyghurController.h"

@interface ChineseToUyghurController ()

@end

@implementation ChineseToUyghurController
@synthesize segmentImage,uyghurHintLabel,uyghurLabel,chineseHintLabel,chineseLabel,playBtn;
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
    [nbi setLeftBarButtonItem:backItem];
    [nbi setTitle:@"单词一览"];
    [self initView];
//    [self loadAudio];
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
    uyghurHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, oy, width-20, 60.)];
    [uyghurHintLabel setText:@"维吾尔语:"];
    [uyghurHintLabel setTextAlignment:NSTextAlignmentLeft];
    uyghurLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 60.+oy, width-40.,(height-2.0-60.)/2-60.)];
    [uyghurLabel setText:item.weiyu_info];
    [uyghurLabel setTextAlignment:NSTextAlignmentCenter];
    uyghurLabel.numberOfLines=0;
    uyghurLabel.lineBreakMode=NSLineBreakByCharWrapping;
    chineseHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, (height-2.0-60.)/2+2.0+oy, width-20, 60.)];
    [chineseHintLabel setText:@"汉   语:"];
    [chineseHintLabel setTextAlignment:NSTextAlignmentLeft];
    chineseLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, (height-2.0-60.)/2+2.0+60.+oy, width-40, (height-2.0-60.)/2-60.)];
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
-(void)loadAudio{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *audioPath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",item.weiyu_sound_id]];
    if ([fileManager fileExistsAtPath:audioPath]) {
        [hud hide:YES];
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
-(void)play:(id)sender{
    
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
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"正在获取音频";
        NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        
        //        NSOperationQueue *operationQueue = manager.operationQueue;
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                    [self loadAudio];
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                    [self loadAudio];
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
    }
}

-(void) updateControls
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
    [audioPlayer dispose];
    [self.navigationController popViewControllerAnimated:YES];
}

//状态改变
-(void) audioPlayer:(AudioPlayer*)audioPlayer stateChanged:(AudioPlayerState)state
{
    [self updateControls];
}
//
-(void) audioPlayer:(AudioPlayer*)audioPlayer didEncounterError:(AudioPlayerErrorCode)errorCode
{
    [self updateControls];
}
//开始播放
-(void) audioPlayer:(AudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}
//完成加载
-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self updateControls];
}
//完成播放
-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(AudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    [self updateControls];
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
