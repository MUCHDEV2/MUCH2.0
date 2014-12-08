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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 318, 318)];
    bgView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:bgView];
    
    bgImageView = [[UIImageView alloc] init];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 21, 48, 48)];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    distanceLabel.font = [UIFont systemFontOfSize:10];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 79, 48, 48)];
    [priceImage setImage:[UIImage imageNamed:@"price_icon_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    priceLabel.font = [UIFont systemFontOfSize:10];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    headImageView = [[SmallUserImageView alloc] initWithFrame:CGRectMake(252, 21, 46, 92.5)];
    headImageView.delegate = self;
    [self.contentView addSubview:headImageView];
}

-(void)setModel:(ListModel *)model{
    if([model.is_faved isEqualToString:@"1"]){
        headImageView.isLove = YES;
    }else{
        headImageView.isLove = NO;
    }
    
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image.size.height<320){
            bgImageView.frame = CGRectMake(1, (320-image.size.height)/2, 318, image.size.height);
        }else{
            bgImageView.frame = CGRectMake(1, 1, 318, 318);
        }
    }];
    
    if(![[NSString stringWithFormat:@"%@",model.createdby] isEqualToString:@"<null>"]){
        contactId = model.createdby[@"_id"];
        headImageView.hidden = NO;
        [headImageView.userImageView sd_setImageWithURL:[NSURL URLWithString:model.createdby[@"avatar"]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }else{
        [headImageView.userImageView setImage:nil];
        headImageView.hidden = YES;
    }
    if([model.compare isEqualToString:@"2"]){
        [distanceImage setImage:[UIImage imageNamed:@"distance_icon_green"]];
    }else if ([model.compare isEqualToString:@"5"]){
        [distanceImage setImage:[UIImage imageNamed:@"distance_5km"]];
    }else if([model.compare isEqualToString:@"all"]){
        [distanceImage setImage:[UIImage imageNamed:@"distance_all"]];
    }
    distanceLabel.text = model.distance_str;
    priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    [self.mainScorllView removeFromSuperview];
    self.mainScorllView = nil;
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i < model.comments.count; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 305, 30)];
        //tempLabel.backgroundColor = [UIColor blackColor];
        tempLabel.text = [NSString stringWithFormat:@"%@: %@",model.comments[i][@"nickname"],model.comments[i][@"content"]];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont systemFontOfSize:14];
        [tempLabel setTransform:CGAffineTransformMakeRotation(M_PI)];
        [viewsArray addObject:tempLabel];
    }
    
    if(self.mainScorllView == nil){
        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(1, 289, 318, 30)];
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
                [self.mainScorllView setTransform:CGAffineTransformMakeRotation(M_PI)];
            }else{
                self.mainScorllView.animation = 0;
                [self.contentView addSubview:self.mainScorllView];
                UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 308, 30)];
                //tempLabel.backgroundColor = [UIColor blackColor];
                tempLabel.text = [NSString stringWithFormat:@"%@: %@",model.comments[0][@"nickname"],model.comments[0][@"content"]];
                tempLabel.textColor = [UIColor whiteColor];
                tempLabel.font = [UIFont systemFontOfSize:14];
                [self.mainScorllView addSubview:tempLabel];
            }
        }else{
            self.mainScorllView.animation = 0;
            [self.contentView addSubview:self.mainScorllView];
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 308, 30)];
            //tempLabel.backgroundColor = [UIColor blackColor];
            tempLabel.text = @"暂未评论！";
            tempLabel.textColor = [UIColor whiteColor];
            tempLabel.font = [UIFont systemFontOfSize:14];
            tempLabel.alpha = 0.5;
            [self.mainScorllView addSubview:tempLabel];
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
