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
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

//-(void)addContent{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 318, 318)];
//    bgView.backgroundColor = [UIColor blackColor];
//    [self.contentView addSubview:bgView];
//    
//    bgImageView = [[UIImageView alloc] init];
//    bgImageView.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:bgImageView];
//    
//    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 21, 48, 48)];
//    [self.contentView addSubview:distanceImage];
//    
//    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
//    distanceLabel.font = [UIFont systemFontOfSize:10];
//    distanceLabel.text = @"200m";
//    distanceLabel.textAlignment = NSTextAlignmentCenter;
//    distanceLabel.textColor = [UIColor whiteColor];
//    [distanceImage addSubview:distanceLabel];
//    
//    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(21, 79, 48, 48)];
//    [priceImage setImage:[UIImage imageNamed:@"price_icon_red"]];
//    [self.contentView addSubview:priceImage];
//    
//    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
//    priceLabel.font = [UIFont systemFontOfSize:10];
//    priceLabel.text = @"¥299";
//    priceLabel.textAlignment = NSTextAlignmentCenter;
//    priceLabel.textColor = [UIColor whiteColor];
//    [priceImage addSubview:priceLabel];
//    
//    headImageView = [[SmallUserImageView alloc] initWithFrame:CGRectMake(252, 21, 46, 92.5)];
//    headImageView.delegate = self;
//    [self.contentView addSubview:headImageView];
//}
//
//-(void)setModel:(ListModel *)model{
//    if([model.is_faved isEqualToString:@"1"]){
//        headImageView.isLove = YES;
//    }else{
//        headImageView.isLove = NO;
//    }
//    
//    [bgImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if(image.size.height<320){
//            bgImageView.frame = CGRectMake(1, (320-image.size.height)/2, 318, image.size.height);
//        }else{
//            bgImageView.frame = CGRectMake(1, 1, 318, 318);
//        }
//    }];
//    
//    if(![[NSString stringWithFormat:@"%@",model.createdby] isEqualToString:@"<null>"]){
//        contactId = model.createdby[@"_id"];
//        headImageView.hidden = NO;
//        [headImageView.userImageView sd_setImageWithURL:[NSURL URLWithString:model.createdby[@"avatar"]] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
//    }else{
//        [headImageView.userImageView setImage:nil];
//        headImageView.hidden = YES;
//    }
//    if([model.compare isEqualToString:@"2"]){
//        [distanceImage setImage:[UIImage imageNamed:@"distance_icon_green"]];
//    }else if ([model.compare isEqualToString:@"5"]){
//        [distanceImage setImage:[UIImage imageNamed:@"distance_5km"]];
//    }else if([model.compare isEqualToString:@"all"]){
//        [distanceImage setImage:[UIImage imageNamed:@"distance_all"]];
//    }
//    distanceLabel.text = model.distance_str;
//    priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
//    
//    [self.mainScorllView removeFromSuperview];
//    self.mainScorllView = nil;
//    
//    NSMutableArray *viewsArray = [@[] mutableCopy];
//    for (int i = 0; i < model.comments.count; ++i) {
//        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 305, 30)];
//        //tempLabel.backgroundColor = [UIColor blackColor];
//        tempLabel.text = [NSString stringWithFormat:@"%@: %@",model.comments[i][@"nickname"],model.comments[i][@"content"]];
//        tempLabel.textColor = [UIColor whiteColor];
//        tempLabel.font = [UIFont systemFontOfSize:14];
//        [tempLabel setTransform:CGAffineTransformMakeRotation(M_PI)];
//        [viewsArray addObject:tempLabel];
//    }
//    
//    if(self.mainScorllView == nil){
//        self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(1, 289, 318, 30)];
//        self.mainScorllView.backgroundColor = [UIColor blackColor];
//        self.mainScorllView.alpha = 0.5;
//        
//        if(model.comments.count !=0){
//            if(model.comments.count !=1){
//                self.mainScorllView.animation = 2;
//                self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
//                    return viewsArray[pageIndex];
//                };
//                
//                self.mainScorllView.totalPagesCount = ^NSInteger(void){
//                    return model.comments.count;
//                };
//                [self.contentView addSubview:self.mainScorllView];
//                [self.mainScorllView setTransform:CGAffineTransformMakeRotation(M_PI)];
//            }else{
//                self.mainScorllView.animation = 0;
//                [self.contentView addSubview:self.mainScorllView];
//                UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 308, 30)];
//                //tempLabel.backgroundColor = [UIColor blackColor];
//                tempLabel.text = [NSString stringWithFormat:@"%@: %@",model.comments[0][@"nickname"],model.comments[0][@"content"]];
//                tempLabel.textColor = [UIColor whiteColor];
//                tempLabel.font = [UIFont systemFontOfSize:14];
//                [self.mainScorllView addSubview:tempLabel];
//            }
//        }else{
//            self.mainScorllView.animation = 0;
//            [self.contentView addSubview:self.mainScorllView];
//            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 308, 30)];
//            //tempLabel.backgroundColor = [UIColor blackColor];
//            tempLabel.text = @"暂未评论！";
//            tempLabel.textColor = [UIColor whiteColor];
//            tempLabel.font = [UIFont systemFontOfSize:14];
//            tempLabel.alpha = 0.5;
//            [self.mainScorllView addSubview:tempLabel];
//        }
//    }
//}
//
//-(void)chooseLoveHeartWithIsChoose:(BOOL)isChoose{
//    if(isChoose){
//        [MuchApi AddFavWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if(!error){
//            
//            }
//        } dic:[@{@"selfid":[LoginSqlite getdata:@"userId"],@"userid":contactId} mutableCopy]];
//    }
//}

-(void)addContent{
    lineImageView = [[UIImageView alloc] init];
    [lineImageView setBackgroundColor:RGBCOLOR(203, 203, 203)];
    [self.contentView addSubview:lineImageView];
    
    UIImageView *headBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(3.5, 8.5, 50.5, 50.5)];
    [headBgImage setBackgroundColor:[UIColor whiteColor]];
    headBgImage.layer.cornerRadius = 50.5/2;
    headBgImage.layer.masksToBounds = YES;
    [self.contentView addSubview:headBgImage];
    
    //headView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"03_1_03.png"]];
    headView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 47.5, 47.5)];
    headView.layer.cornerRadius = 47.5/2;
    headView.layer.masksToBounds = YES;
    [self.contentView addSubview:headView];
    
    UIImageView *dianView = [[UIImageView alloc] initWithFrame:CGRectMake(12.3, 83, 6.5, 6.5)];
    [dianView setImage:[UIImage imageNamed:@"dian"]];
    [self.contentView addSubview:dianView];
    
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 10, 260, 106.5)];
    [contentView setImage:[UIImage imageNamed:@"多边形-1"]];
    [self.contentView addSubview:contentView];
    
    namelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 52.5, 45, 30)];
    namelabel.text = @"";
    namelabel.font = [UIFont systemFontOfSize:12];
    namelabel.textColor = RGBCOLOR(50, 118, 243);
    [self.contentView addSubview:namelabel];
    
    distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 72, 40, 30)];
    distancelabel.text = @"";
    distancelabel.font = [UIFont systemFontOfSize:9];
    distancelabel.textColor = RGBCOLOR(159, 159, 159);
    [self.contentView addSubview:distancelabel];
    
    
    UIImageView *moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135, 80, 10, 2)];
    [moreImageView setImage:[UIImage imageNamed:@"03-1_24.png"]];
    [self.contentView addSubview:moreImageView];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(69, 87, 138, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.2;
    
    pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(69, 87, 60, 30)];
    pricelabel.font = [UIFont systemFontOfSize:12];
    pricelabel.textColor = RGBCOLOR(242, 66, 146);
    [self.contentView addSubview:pricelabel];
    
    commetImage = [[UIImageView alloc] initWithFrame:CGRectMake(127, 98, 9, 9)];
    [commetImage setImage:[UIImage imageNamed:@"comment_icon"]];
    [self.contentView addSubview:commetImage];
    
    commetLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 86, 30, 30)];
    commetLabel.font = [UIFont systemFontOfSize:12];
    commetLabel.textColor = RGBCOLOR(159, 159, 159);
    [self.contentView addSubview:commetLabel];
    
    goodImage = [[UIImageView alloc] initWithFrame:CGRectMake(172, 97, 11, 9)];
    [goodImage setImage:[UIImage imageNamed:@"good"]];
    [self.contentView addSubview:goodImage];
    
    goodlabel = [[UILabel alloc] initWithFrame:CGRectMake(187, 86, 20, 30)];
    goodlabel.font = [UIFont systemFontOfSize:12];
    goodlabel.textColor = RGBCOLOR(159, 159, 159);
    [self.contentView addSubview:goodlabel];
    
    //bigImage = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"03_1_03"]];
    bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(212, 12, 100, 100)];
    [self.contentView addSubview:bigImage];
    
    contentNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 30, 30)];
    contentNamelabel.font = [UIFont systemFontOfSize:12];
    contentNamelabel.textColor = RGBCOLOR(50, 118, 243);
    [self.contentView addSubview:contentNamelabel];
    
    contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(contentNamelabel.frame.size.width+contentNamelabel.frame.origin.x+5, 5, 100, 30)];
    contentlabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:contentlabel];
    
    contentNamelabel2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 30, 30)];
    contentNamelabel2.font = [UIFont systemFontOfSize:12];
    contentNamelabel2.textColor = RGBCOLOR(50, 118, 243);
    [self.contentView addSubview:contentNamelabel2];
    
    contentlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(contentNamelabel2.frame.size.width+contentNamelabel2.frame.origin.x+5, 25, 100, 30)];
    contentlabel2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:contentlabel2];
    
    contentNamelabel3 = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, 30, 30)];
    contentNamelabel3.font = [UIFont systemFontOfSize:12];
    contentNamelabel3.textColor = RGBCOLOR(50, 118, 243);
    [self.contentView addSubview:contentNamelabel3];
    
    contentlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(contentNamelabel3.frame.size.width+contentNamelabel3.frame.origin.x+5, 45, 100, 30)];
    contentlabel3.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:contentlabel3];
}

-(void)setModel:(ListModel *)model{
    lineImageView.frame=CGRectMake(15, 0, 1, !self.myNeedLong?130:600);
    pricelabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    [bigImage sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil];
    goodlabel.text = model.likes;
    distancelabel.text = model.distance_str;
    [headView sd_setImageWithURL:[NSURL URLWithString:model.createdby[@"avatar"]] placeholderImage:[UIImage imageNamed:@"icon114"]];
    
    contentNamelabel.text = @"";
    contentlabel.text = @"";
    contentNamelabel2.text = @"";
    contentlabel2.text = @"";
    contentNamelabel3.text = @"";
    contentlabel3.text = @"";
    commetLabel.text = @"";
    if(model.comments.count !=0){
        for(int i=0;i<model.comments.count;i++){
            if(i==0){
                if(![[NSString stringWithFormat:@"%@",model.comments[0]]isEqualToString:@"<null>"]){
                    contentNamelabel.text = model.comments[0][@"nickname"];
                    contentlabel.text = model.comments[0][@"content"];
                }
            }else if(i==1){
                if(![[NSString stringWithFormat:@"%@",model.comments[1]]isEqualToString:@"<null>"]){
                    contentNamelabel2.text = model.comments[1][@"nickname"];
                    contentlabel2.text = model.comments[1][@"content"];
                }
            }else{
                if(![[NSString stringWithFormat:@"%@",model.comments[2]]isEqualToString:@"<null>"]){
                    contentNamelabel3.text = model.comments[2][@"nickname"];
                    contentlabel3.text = model.comments[2][@"content"];
                }
            }
        }
        commetLabel.text = [NSString stringWithFormat:@"%d",model.comments.count];
    }else{
        contentNamelabel.text = @"";
        contentlabel.text = @"";
        contentNamelabel2.text = @"";
        contentlabel2.text = @"";
        contentNamelabel3.text = @"";
        contentlabel3.text = @"";
        commetLabel.text = @"0";
    }
}
@end
