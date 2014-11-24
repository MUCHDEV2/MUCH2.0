//
//  MainViewTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/21.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainViewTableViewCell.h"

@implementation MainViewTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addContent];
    }
    return self;
}

-(void)addContent{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 318)];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 21, 48, 48)];
    [distanceImage setImage:[UIImage imageNamed:@"distance_icon_green"]];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    distanceLabel.font = [UIFont systemFontOfSize:9];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 79, 48, 48)];
    [priceImage setImage:[UIImage imageNamed:@"price_icon_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    priceLabel.font = [UIFont systemFontOfSize:9];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    headImageView = [[SmallUserImageView alloc] initWithFrame:CGRectMake(252, 21, 46, 92.5)];
    //headImageView.layer.cornerRadius = 24;
    //headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:headImageView];
}

-(void)setModel:(ListModel *)model{
    __block UIActivityIndicatorView *activityIndicator;
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (!activityIndicator) {
//            [bgImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
//            activityIndicator.center = bgImageView.center;
//            [activityIndicator startAnimating];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }];
    
    if(![[NSString stringWithFormat:@"%@",model.createdby] isEqualToString:@"<null>"]){
        headImageView.hidden = NO;
        [headImageView.userImageView sd_setImageWithURL:[NSURL URLWithString:model.createdby[@"avatar"]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (!activityIndicator) {
                [headImageView.userImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                activityIndicator.center = headImageView.center;
                [activityIndicator startAnimating];
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [activityIndicator removeFromSuperview];
            activityIndicator = nil;
        }];
    }else{
        //[headImageView.userImageView sd_setImageWithURL:nil];
        headImageView.hidden = YES;
    }
    
    distanceLabel.text = model.distance;
    priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    [self.mainScorllView removeFromSuperview];
    self.mainScorllView = nil;
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i < model.comments.count; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 305, 30)];
        //tempLabel.backgroundColor = [UIColor blackColor];
        tempLabel.text = [NSString stringWithFormat:@"%@",model.comments[i][@"content"]];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont systemFontOfSize:14];
        [viewsArray addObject:tempLabel];
    }
    
    if(self.mainScorllView == nil){
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(1, 287, 318, 30) animationDuration:2];
        self.mainScorllView.backgroundColor = [UIColor blackColor];
        self.mainScorllView.alpha = 0.5;
        
        if(model.comments.count !=0){
            self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                return viewsArray[pageIndex];
            };
            
            self.mainScorllView.totalPagesCount = ^NSInteger(void){
                return model.comments.count;
            };
        }
        
        [self.contentView addSubview:self.mainScorllView];
    }
}
@end
