//
//  DetailCommentSubview.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailCommentSubview.h"
@interface DetailCommentSubview()
//视图部分
@property(nonatomic,strong)UILabel* replayLabel;

//数据层部分
@property(nonatomic,strong)DetailCommentSubviewModel* replayModel;//该model为回复内容model,在评论视图的model中有个数组包含此model
@end
@implementation DetailCommentSubview
+(DetailCommentSubview*)detailCommentSubviewWithModel:(DetailCommentSubviewModel*)model{
    return [[DetailCommentSubview alloc]initWithModel:model];
}

-(instancetype)initWithModel:(DetailCommentSubviewModel*)model{
    if (self=[super init]) {
        [self loadSelfWithModel:model];
    }
    return self;
}

-(void)loadSelfWithModel:(DetailCommentSubviewModel*)model{
    self.replayModel=model;
    [self initReplayLabel];
    [self initSelf];
}

-(void)initSelf{
    self.frame=CGRectMake(0, 0, 320, self.replayLabel.frame.size.height+5-2);
}

-(void)initReplayLabel{
    //回复内容self.replayLabel的位置
    NSString* allStr=[NSString stringWithFormat:@"%@回复%@：%@",self.replayModel.soureceUserName,self.replayModel.targetUserName,self.replayModel.replayContent];
    CGRect bound=[allStr boundingRectWithSize:CGSizeMake(ContentWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil];
    self.replayLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 5-2, ContentWidth, bound.size.height)];
    self.replayLabel.numberOfLines=0;
    [self addSubview:self.replayLabel];
    
    //self.replayLabel的文字内容和颜色
    NSMutableAttributedString* attributedStr=[[NSMutableAttributedString alloc]initWithString:allStr];
    self.replayLabel.textColor=ContentColor;
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:UserNameColor} range:NSMakeRange(0, self.replayModel.soureceUserName.length)];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:UserNameColor} range:NSMakeRange(self.replayModel.soureceUserName.length+2,self.replayModel.targetUserName.length)];
    self.replayLabel.attributedText=attributedStr;
    self.replayLabel.font=ContentFont;

    //NSLog(@"%f,%f,%f,%f,%f,%f,%f",ContentFont.pointSize,ContentFont.ascender,ContentFont.descender,ContentFont.capHeight,ContentFont.xHeight,ContentFont.lineHeight,ContentFont.leading);
}
/**
 *  @property(nonatomic,readonly)        CGFloat   pointSize;
 @property(nonatomic,readonly)        CGFloat   ascender;
 @property(nonatomic,readonly)        CGFloat   descender;
 @property(nonatomic,readonly)        CGFloat   capHeight;
 @property(nonatomic,readonly)        CGFloat   xHeight;
 @property(nonatomic,readonly)        CGFloat   lineHeight NS_AVAILABLE_IOS(4_0);
 @property(nonatomic,readonly)        CGFloat   leading;
 */

@end
