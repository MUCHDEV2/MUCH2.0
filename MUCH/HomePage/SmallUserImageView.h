//
//  SmallUserImageView.h
//  test
//
//  Created by 孙元侃 on 14/11/21.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@protocol SmallUserImageViewDelegate <NSObject>
-(void)chooseLoveHeartWithIsChoose:(BOOL)isChoose;
@end
@interface SmallUserImageView : UIView
@property(nonatomic,strong)UIImageView* userImageView;//用户头像
@property(nonatomic,weak)id<SmallUserImageViewDelegate>delegate;
@end
