//
//  ChineseToUyghurController.m
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ChineseToUyghurController.h"

@interface ChineseToUyghurController ()

@end

@implementation ChineseToUyghurController
@synthesize titleLabel,segmentImage,uyghurHintLabel,uyghurLabel,chineseHintLabel,chineseLabel,playBtn;
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
    [self initView];
    [self loadAudio];
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
    [uyghurHintLabel setText:@"维吾尔语:"];
    [uyghurHintLabel setTextAlignment:NSTextAlignmentLeft];
    uyghurLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 60., width,(height-60.0-2.0)/2-60.)];
    [uyghurLabel setText:item.weiyu_info];
    [uyghurLabel setTextAlignment:NSTextAlignmentCenter];
    
    chineseHintLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, (height-60.0-2.0)/2+2.0, width, 60.)];
    [chineseHintLabel setText:@"汉   语:"];
    [chineseHintLabel setTextAlignment:NSTextAlignmentLeft];
    chineseLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, (height-60.0-2.0)/2+2.0+60., width, (height-60.0-2.0)/2-60.)];
    [chineseLabel setText:item.hanyu_info];
    [chineseLabel setTextAlignment:NSTextAlignmentCenter];
    
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
        AFSoundItem *audioItem = [[AFSoundItem alloc] initWithLocalResource:audioPath atPath:nil];
        
        AFSoundPlayback *player = [[AFSoundPlayback alloc] initWithItem:audioItem];
        
        [player play];
    }else{
        NSURL *url=[NSURL URLWithString:@"http://resources.xjhuahu.cn/res/sound/Huahu_00000_Z0005"];
        [audioPlayer setDataSource:[audioPlayer dataSourceFromURL:url] withQueueItemId:url];
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
        [self loadAudio];
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
-(void) audioPlayer:(AudioPlayer*)audioPlayer stateChanged:(AudioPlayerState)state
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didEncounterError:(AudioPlayerErrorCode)errorCode
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}
-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

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
