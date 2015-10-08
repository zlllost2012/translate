//
//  HistoryItem.h
//  历史记录实体
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryItem : NSManagedObject

@property (nonatomic, retain) NSString * num;
@property (nonatomic, retain) NSString * hanyu_info;
@property (nonatomic, retain) NSString * hanyu_sound_id;
@property (nonatomic, retain) NSString * hanyu_num;
@property (nonatomic, retain) NSString * weiyu_info;
@property (nonatomic, retain) NSString * weiyu_sound_id;
@property (nonatomic, retain) NSString * weiyu_num;
@property (nonatomic) int32_t dr;
@property (nonatomic) int32_t dr_num_px;
@property (nonatomic) double orderingValue;

@end
