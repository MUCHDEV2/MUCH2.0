//
//  DoubleRoundImageView.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DoubleRoundImageView.h"
@interface DoubleRoundImageView()
@property(nonatomic,strong)UIImageView* bigRound;
@property(nonatomic,strong)UIImageView* smallRound;

@property(nonatomic)CGFloat bigWidth;
@property(nonatomic)CGFloat smallWidth;
@end
@implementation DoubleRoundImageView
+(DoubleRoundImageView*)doubleRoundImageViewWithBigRoundWidth:(CGFloat)bigWidth smallRoundWidth:(CGFloat)smallWidth{
    return [[DoubleRoundImageView alloc]initWithFrame:CGRectMake(0, 0, bigWidth, bigWidth)];
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
}

-(void)chooseUserImageView{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseUserImageViewInDoubleRoundView:)]) {
        [self.delegate chooseUserImageViewInDoubleRoundView:self];
    }
}

-(void)initBigRound{
    self.bigRound=[[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:self.bigRound];
}

-(void)initSmallRound{
    self.smallRound=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.smallWidth, self.smallWidth)];
    self.smallRound.center=self.bigRound.center;
    [self addSubview:self.smallRound];
}
@end
