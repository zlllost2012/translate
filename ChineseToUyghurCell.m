//
//  ChineseToUyghurCell.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "ChineseToUyghurCell.h"

@implementation ChineseToUyghurCell
@synthesize chineseLabel=_chineseLabel,uyghurLabel=_uyghurLabel;
- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initLayuot];
        
    }
    
    return self;
    
}

//初始化控件

-(void)initLayuot{
    float width=self.frame.size.width;
    _chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width-20., 30.)];
    [_chineseLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:_chineseLabel];
    
    
    _uyghurLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30., width-20., 30)];
    [_uyghurLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_uyghurLabel];
    
}



//赋值 and 自动换行,计算出cell的高度

-(void)setIWyText:(NSString*)wt HyText:(NSString *)ht{
    
    //获得当前cell高度
    
    CGRect frame = [self frame];
    
    //文本赋值
    
    self.chineseLabel.text = ht;
    self.uyghurLabel.text=wt;
    //设置label的最大行数
    
    self.uyghurLabel.numberOfLines = 0;
    self.chineseLabel.numberOfLines = 0;
    
    CGSize size = CGSizeMake(300, 1000);
    
    
    UIFont *font = [UIFont fontWithName:@"ArialMT" size:20.];
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize wlabelSize=[self.chineseLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    self.chineseLabel.frame = CGRectMake(10, 5,[[UIScreen mainScreen] bounds].size.width-20., wlabelSize.height);
    

    
    UIFont *font2 = [UIFont fontWithName:@"HelveticaNeue" size:20.];
    NSMutableParagraphStyle *paragraphStyle2=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle2.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes2 = @{NSFontAttributeName:font2, NSParagraphStyleAttributeName:paragraphStyle2.copy};
    CGSize wlabelSize2=[self.uyghurLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes2 context:nil].size;
    
    self.uyghurLabel.frame = CGRectMake(10., wlabelSize.height+10., [[UIScreen mainScreen] bounds].size.width-20., wlabelSize2.height);
    
    
    //计算出自适应的高度
    
    frame.size.height = wlabelSize.height+wlabelSize2.height+15.;
    
    
    
    self.frame = frame;  
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
