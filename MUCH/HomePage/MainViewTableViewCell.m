//
//  MainViewTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/21.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainViewTableViewCell.h"
#import "MuchApi.h"
#import "LoginSqlite.h"
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
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 48, 48)];
    [distanceImage setImage:[UIImage imageNamed:@"distance_icon_green"]];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    distanceLabel.font = [UIFont systemFontOfSize:12];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 78, 48, 48)];
    [priceImage setImage:[UIImage imageNamed:@"price_icon_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    headImageView = [[SmallUserImageView alloc] initWithFrame:CGRectMake(252, 20, 46, 92.5)];
    headImageView.delegate = self;
    [self.contentView addSubview:headImageView];
}

-(void)setModel:(ListModel *)model{
    if([model.is_faved isEqualToString:@"1"]){
        headImageView.isLove = YES;
    }else{
        headImageView.isLove = NO;
    }
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
        contactId = model.createdby[@"_id"];
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
        [headImageView.userImageView setImage:nil];
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
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 288, 318, 30)];
        self.mainScorllView.backgroundColor = [UIColor blackColor];
        self.mainScorllView.alpha = 0.5;
        
        if(model.comments.count !=0){
            if(model.comments.count !=1){
                self.mainScorllView.animation = 2;
                self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                    return viewsArray[pageIndex];
                };
                
                self.mainScorllView.totalPagesCount = ^NSInteger(void){
                    return model.comments.count;
                };
                [self.contentView addSubview:self.mainScorllView];
            }else{
                self.mainScorllView.animation = 0;
                [self.contentView addSubview:self.mainScorllView];
                UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 288, 305, 30)];
                //tempLabel.backgroundColor = [UIColor blackColor];
                tempLabel.text = [NSString stringWithFormat:@"%@",model.comments[0][@"content"]];
                tempLabel.textColor = [UIColor whiteColor];
                tempLabel.font = [UIFont systemFontOfSize:14];
                [self.contentView addSubview:tempLabel];
            }
        }else{
            //[self.contentView addSubview:self.mainScorllView];
        }
    }
}

-(void)chooseLoveHeartWithIsChoose:(BOOL)isChoose{
    if(isChoose){
        [MuchApi AddFavWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
            
            }
        } dic:[@{@"selfid":[LoginSqlite getdata:@"userId"],@"userid":contactId} mutableCopy]];
    }
}
@end
