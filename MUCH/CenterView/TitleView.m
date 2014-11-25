//
//  TitleView.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

+(TitleView*)titleViewWithTitle:(NSString*)title delegate:(id<TitleViewDelegate>)delegate{
    TitleView* titleView=[[TitleView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    titleView.backgroundColor=RGBCOLOR(239, 239, 239);
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont boldSystemFontOfSize:20];
    titleLabel.center=CGPointMake(160, 22.5);
    titleLabel.text=title;
    [titleView addSubview:titleLabel];
    
    UIButton* sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(0, 0, 65, 20);
    sureBtn.center=CGPointMake(290, 22.5);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    if (delegate&&[delegate respondsToSelector:@selector(makeSure)]) {
        [sureBtn addTarget:delegate action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    }
    [titleView addSubview:sureBtn];
    
    return titleView;
}

@end
