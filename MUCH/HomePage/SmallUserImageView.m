//
//  SmallUserImageView.m
//  test
//
//  Created by 孙元侃 on 14/11/21.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "SmallUserImageView.h"
#import "GetImagePath.h"
@interface SmallUserImageView()
@property(nonatomic,strong)UIButton* userBack;//用户头像背后的小圆圈，并且将其作为按钮触发事件
@property(nonatomic,strong)UIImageView* totalBack;//用于显示点击用户头像后出来的背景
@property(nonatomic,strong)UIButton* loveHeart;//是在totalBack上的爱心
@property(nonatomic)CGFloat animationRangeY;//totalBack上下移动的动画距离
@property(nonatomic)BOOL isLove;//是否爱它
@property(nonatomic,copy)NSString* loveImageName;//爱心的图片名
@end
@implementation SmallUserImageView
-(NSString *)loveImageName{
    return self.isLove?@"user_faved_icon":@"user_unfav_icon";
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.clipsToBounds=YES;
        self.animationRangeY=50;
        [self initUserBack];//用户头像背后的小圆圈，并且将其作为按钮触发事件
        [self initUserImageView];//用户头像
        [self initTotalBack];//用于显示点击用户头像后出来的背景
        [self initLoveHeart];//是在totalBack上的爱心
    }
    return self;
}

//用户头像背后的小圆圈，并且将其作为按钮触发事件
-(void)initUserBack{
    self.userBack=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.userBack setBackgroundImage:[GetImagePath getImagePath:@"user_avatar_white"] forState:UIControlStateNormal];
    self.userBack.frame=CGRectMake(-0.75, 0, 47.5, 47.5);
    [self addSubview:self.userBack];
    [self.userBack addTarget:self action:@selector(showTotalBack) forControlEvents:UIControlEventTouchUpInside];
}

//用户头像
-(void)initUserImageView{
    self.userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 42, 42)];
    self.userImageView.center=CGPointMake(23.75, 23.75);
    self.userImageView.layer.cornerRadius=self.userImageView.frame.size.height*.5;
    self.userImageView.layer.masksToBounds=YES;
    self.userImageView.image=[GetImagePath getImagePath:@"QQ20141121-1@2x"];
    [self.userBack addSubview:self.userImageView];
}

//用于显示点击用户头像后出来的背景
-(void)initTotalBack{
    //partBack为部分背景，因为totalBack的上半部分不应在其未出来的时候在用户头像上方显示出来，所以将totalBack添加在partBack上，然后设置clipsToBounds不让它显示在用户头像上方
    UIView* partBack=[[UIView alloc]initWithFrame:CGRectMake(0, self.userBack.frame.size.height*.5, self.frame.size.width, self.frame.size.height-self.userBack.frame.size.height*.5)];
    partBack.clipsToBounds=YES;
    [self insertSubview:partBack atIndex:0];
    
    self.totalBack=[[UIImageView alloc]initWithFrame:self.bounds];
    self.totalBack.userInteractionEnabled=YES;
    self.totalBack.image=[GetImagePath getImagePath:@"user_fav_bg"];
    CGRect frame=self.totalBack.frame;
    frame.origin.y-=self.frame.size.height-partBack.frame.size.height+self.animationRangeY;
    self.totalBack.frame=frame;
    [partBack addSubview:self.totalBack];
}

//是在totalBack上的爱心
-(void)initLoveHeart{
    self.loveHeart=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.loveHeart setBackgroundImage:[GetImagePath getImagePath:self.loveImageName] forState:UIControlStateNormal];
    [self.loveHeart addTarget:self action:@selector(changeLoveHeart) forControlEvents:UIControlEventTouchUpInside];
    self.loveHeart.frame=CGRectMake(0, 0, 23.5, 20);
    self.loveHeart.center=CGPointMake(self.totalBack.frame.size.width*.5, self.totalBack.frame.size.height-20);
    [self.totalBack addSubview:self.loveHeart];
}

//用户选择了爱心
-(void)changeLoveHeart{
    if ([self.delegate respondsToSelector:@selector(chooseLoveHeartWithIsChoose:)]) {
        [self.delegate chooseLoveHeartWithIsChoose:!self.isLove];
    }
    self.isLove=!self.isLove;
    [self.loveHeart setBackgroundImage:[GetImagePath getImagePath:self.loveImageName] forState:UIControlStateNormal];
}

//显示和隐藏totalBack的动画实现
-(void)showTotalBack{
    CGRect frame=self.totalBack.frame;
    frame.origin.y-=self.animationRangeY*=-1;
    [UIView animateWithDuration:.3 animations:^{
        self.totalBack.frame=frame;
    }];
}
@end
