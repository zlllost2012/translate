//
//  UyghurToChineseController.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempLanguageItem.h"
#import <AFSoundManager.h>
#import "BDTTSSynthesizer.h"
#import "MBProgressHUD.h"
#import "NetTool.h"
@interface UyghurToChineseController : UIViewController<BDTTSSynthesizerDelegate>
{
    MBProgressHUD *hud;
    TempLanguageItem *item;
    int state;
}
//@property(nonatomic,retain)UILabel *titleLabel;//标题
@property(nonatomic,retain)UILabel *uyghurHintLabel;//维吾尔语提示
@property(nonatomic,retain)UILabel *uyghurLabel;//维吾尔语
@property(nonatomic,retain)UILabel *chineseHintLabel;//汉语
@property(nonatomic,retain)UILabel *chineseLabel;//汉语
@property(nonatomic,retain)UIImageView *segmentImage;//分割线
@property(nonatomic,retain)UIButton *playBtn;//播放按钮
-(id)initWithItem:(TempLanguageItem *)i;
@end
