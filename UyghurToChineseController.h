//
//  UyghurToChineseController.h
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempLanguageItem.h"
#import <AFSoundManager.h>

@interface UyghurToChineseController : UIViewController
{
    TempLanguageItem *item;
}
@property(nonatomic,retain)UILabel *titleLabel;//标题
@property(nonatomic,retain)UILabel *uyghurHintLabel;//维吾尔语提示
@property(nonatomic,retain)UILabel *uyghurLabel;//维吾尔语
@property(nonatomic,retain)UILabel *chineseHintLabel;//汉语
@property(nonatomic,retain)UILabel *chineseLabel;//汉语
@property(nonatomic,retain)UIImageView *segmentImage;//分割线
@property(nonatomic,retain)UIButton *playBtn;//播放按钮
-(id)initWithItem:(TempLanguageItem *)i;
@end
