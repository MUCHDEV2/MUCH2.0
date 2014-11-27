//
//  DetailHeadTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailHeadTableViewCell.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "MuchApi.h"
@implementation DetailHeadTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(195, 195, 195);
        [self addContent];
    }
    return self;
}

-(void)addContent{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 318)];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 20)];
    [backImage setImage:[UIImage imageNamed:@"return_icon_big"]];
    [self.contentView addSubview:backImage];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 48, 40);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:backBtn];
    
    loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loveBtn.frame = CGRectMake(280, 280, 30, 30);
    [loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:loveBtn];
}

-(void)setImageUrl:(NSString *)imageUrl{
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setYoulikeit:(NSString *)youlikeit{
    NSLog(@"====>%@",youlikeit);
    _youlikeit=youlikeit;
    if([youlikeit isEqualToString:@"0"]){
        [loveBtn setBackgroundImage:[UIImage imageNamed:@"good_icon_unselect"] forState:UIControlStateNormal];
    }else{
        [loveBtn setBackgroundImage:[UIImage imageNamed:@"good_icon_selected"] forState:UIControlStateNormal];
    }
}

-(void)backBtnClick{
    [self.delegate back];
}

-(void)loveBtnClick:(UIButton *)button{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    [button.layer addAnimation:k forKey:@"SHOW"];
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([self.delegate respondsToSelector:@selector(showLoginView)]){
            [self.delegate showLoginView];
        }
    }else{
        if (![ConnectionAvailable isConnectionAvailable]) {
            if([self.delegate respondsToSelector:@selector(showAlertView)]){
                [self.delegate showAlertView];
            }
        }else{
            if([self.youlikeit isEqualToString:@"0"]){
                [MuchApi LikeWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        //点赞动画
                        [button setBackgroundImage:[UIImage imageNamed:@"good_icon_selected"] forState:UIControlStateNormal];
                        self.youlikeit = @"1";
                    }
                } aid:self.aid];
            }
        }
    }
}
@end
