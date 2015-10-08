//
//  TempLanguageItem.h
//  语言信息实体
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempLanguageItem : NSObject
@property (nonatomic, retain) NSString * num;//id
@property (nonatomic, retain) NSString * hanyu_info;//汉语内容
@property (nonatomic, retain) NSString * hanyu_sound_id;//汉语语音id
@property (nonatomic, retain) NSString * hanyu_num;//汉语扩展信息
@property (nonatomic, retain) NSString * weiyu_info;//维语内容
@property (nonatomic, retain) NSString * weiyu_sound_id;//维语语音id
@property (nonatomic, retain) NSString * weiyu_num;//维语扩展信息
@property (nonatomic) int32_t dr;//所在分类
@property (nonatomic) int32_t dr_num_px;//分类顺序
@end
