//
//  PostTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 15/2/13.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "PostTableViewCell.h"

@implementation PostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addContent];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)addContent{
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 1, 70)];
    [lineImageView setBackgroundColor:RGBCOLOR(203, 203, 203)];
    [self.contentView addSubview:lineImageView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 60)];
    [bgImageView setImage:[UIImage imageNamed:@"矩形-4"]];
    [self.contentView addSubview:bgImageView];
    
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 47.5, 47.5)];
    headImage.layer.cornerRadius = 23.75;
    headImage.layer.masksToBounds = YES;
    [self.contentView addSubview:headImage];
    
    namelabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 20, 100, 40)];
    namelabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:namelabel];
}

-(void)setAvatarUrl:(NSString *)avatarUrl{
    [headImage sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:nil];
}

-(void)setUserName:(NSString *)userName{
    namelabel.text = userName;
}
@end
