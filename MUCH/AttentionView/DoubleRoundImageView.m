//
//  DoubleRoundImageView.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DoubleRoundImageView.h"
@interface DoubleRoundImageView()
@property(nonatomic,strong)UIImageView* bigRound;//底图圆

@property(nonatomic)CGFloat bigWidth;//底图圆的宽
@property(nonatomic)CGFloat smallWidth;//用户头像圆的宽
@end
@implementation DoubleRoundImageView
+(DoubleRoundImageView*)doubleRoundImageViewWithBigRoundWidth:(CGFloat)bigWidth smallRoundWidth:(CGFloat)smallWidth{
    return [[DoubleRoundImageView alloc]initWithFrame:CGRectMake(0, 0, bigWidth, bigWidth) bigRoundWidth:bigWidth smallRoundWidth:smallWidth];
}

-(instancetype)initWithFrame:(CGRect)frame bigRoundWidth:(CGFloat)bigWidth smallRoundWidth:(CGFloat)smallWidth{
    if (self=[super initWithFrame:frame]) {
        self.bigWidth=bigWidth;
        self.smallWidth=smallWidth;
        [self loadSelf];
    }
    return self;
}

-(void)loadSelf{
    [self initBigRound];
    [self initSmallRound];
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseUserImageView)];
    [self addGestureRecognizer:tap];
    [self handleBigRoundAndSmallRoundOffset];
}

-(void)chooseUserImageView{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseUserImageViewInDoubleRoundView:)]) {
        [self.delegate chooseUserImageViewInDoubleRoundView:self];
    }
}

-(void)initBigRound{
    self.bigRound=[[UIImageView alloc]initWithFrame:self.frame];
    self.bigRound.image=[UIImage imageNamed:@"user_avatar_white"];
    self.bigRound.layer.cornerRadius=self.bigRound.frame.size.width*.5;
    self.bigRound.layer.masksToBounds=YES;
    [self addSubview:self.bigRound];
}

-(void)initSmallRound{
    self.smallRound=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.smallWidth, self.smallWidth)];
    self.smallRound.image=[UIImage imageNamed:@"icon114"];
    self.smallRound.layer.cornerRadius=self.smallRound.frame.size.width*.5;
    self.smallRound.layer.masksToBounds=YES;
    self.smallRound.center=self.bigRound.center;
    [self addSubview:self.smallRound];
}

-(void)handleBigRoundAndSmallRoundOffset{
    CGPoint center=self.smallRound.center;
    center.y-=self.bigRound.frame.size.width*.015;
    self.smallRound.center=center;
}
@end
