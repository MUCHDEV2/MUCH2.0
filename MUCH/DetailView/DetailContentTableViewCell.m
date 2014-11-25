//
//  DetailContentTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailContentTableViewCell.h"

@implementation DetailContentTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(221, 221, 221);
        [self addContent];
    }
    return self;
}

-(void)addContent{
    UIImageView *bgHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
    [bgHeadImage setImage:[UIImage imageNamed:@"details_view_user_white"]];
    [self.contentView addSubview:bgHeadImage];
    
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 43, 43)];
    headImage.layer.cornerRadius = 21.5;
    headImage.layer.masksToBounds = YES;
    [bgHeadImage addSubview:headImage];
    
    UIImageView *distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(55, 5, 45, 45)];
    [distanceImage setImage:[UIImage imageNamed:@"details_view_distance_green"]];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    distanceLabel.font = [UIFont systemFontOfSize:9];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    UIImageView *priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(105, 5, 45, 45)];
    [priceImage setImage:[UIImage imageNamed:@"details_view_price_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    priceLabel.font = [UIFont systemFontOfSize:9];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    UIImageView *commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(270, 20.5, 20, 14)];
    [commentImage setImage:[UIImage imageNamed:@"comment_icon_blue"]];
    [self.contentView addSubview:commentImage];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(260, 13.5, 40, 28);
    [commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:commentBtn];
}

-(void)setHeadImageUrl:(NSString *)headImageUrl{
    [headImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl]];
}

-(void)setDistance:(NSString *)distance{
    distanceLabel.text = distance;
}

-(void)setPrice:(NSString *)price{
    priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
}

-(void)commentBtnClick{
    NSLog(@"commentBtnClick");
}
@end
