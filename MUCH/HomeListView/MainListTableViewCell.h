//
//  MainListTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "ListModel.h"
#import "SmallUserImageView.h"
@interface MainListTableViewCell : UITableViewCell{
    UIImageView *bgImageView;
    UIImageView *distanceImage;
    UIImageView *priceImage;
    UILabel *distanceLabel;
    UILabel *priceLabel;
    SmallUserImageView *headImageView;
}
@property(nonatomic,strong)ListModel *model;
@property (nonatomic , retain) CycleScrollView *mainScorllView;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
