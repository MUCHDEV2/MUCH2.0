//
//  FavoritesTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "FavoritesTableViewCell.h"

@implementation FavoritesTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addContent];
    }
    return self;
}


-(void)addContent{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 150)];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 21, 48, 48)];
    [distanceImage setImage:[UIImage imageNamed:@"distance_icon_green"]];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    distanceLabel.font = [UIFont systemFontOfSize:12];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 79, 48, 48)];
    [priceImage setImage:[UIImage imageNamed:@"price_icon_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 150)];
    statusImageView.backgroundColor = [UIColor whiteColor];
    statusImageView.alpha = 0;
    [self.contentView addSubview:statusImageView];
}

-(void)setModel:(ListModel *)model{
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片裁剪
        UIImage *srcimg = image;
        CGRect rect =  CGRectMake(0, 170, 640, 300);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
        CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
        bgImageView.image = [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    }];
    
    distanceLabel.text = model.distance;
    priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
}
@end
