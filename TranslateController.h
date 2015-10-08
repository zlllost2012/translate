//
//  TranslateController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempLanguageItem.h"
#import "BDTTSSynthesizer.h"
#import <AFSoundManager/AFSoundManager.h>
#import "AudioPlayer.h"
#import "MBProgressHUD.h"
#import "TURL.h"
#import "NetTool.h"
@interface TranslateController : UIViewController<AudioPlayerDelegate,BDTTSSynthesizerDelegate>
{
    MBProgressHUD *hud;
    TempLanguageItem *item;
    AudioPlayer *audioPlayer;
    int state;
    int languageState;
}
@property(nonatomic,retain)UILabel *titleLabel;//标题
@property(nonatomic,retain)UILabel *uyghurHintLabel;//维吾尔语提示
@property(nonatomic,retain)UILabel *uyghurLabel;//维吾尔语
@property(nonatomic,retain)UILabel *chineseHintLabel;//汉语
@property(nonatomic,retain)UILabel *chineseLabel;//汉语
@property(nonatomic,retain)UIImageView *segmentImageUp;//上分割线
@property(nonatomic,retain)UIImageView *segmentImageDown;//下分割线
@property(nonatomic,retain)UIButton *changeBtn;//切换按钮
@property(nonatomic,retain)UIButton *playBtn;//播放按钮
-(id)initWithItem:(TempLanguageItem *)i;

@end
