//
//  UyghurToChineseCell.h
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UyghurToChineseCell : UITableViewCell
@property(nonatomic,retain) UILabel *chineseLabel;
@property(nonatomic,retain) UILabel *uyghurLabel;
//给用户介绍赋值并且实现自动换行

-(void)setIWyText:(NSString*)wt HyText:(NSString *)ht;

//初始化cell类

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
