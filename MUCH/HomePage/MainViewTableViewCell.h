//
//  MainViewTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/21.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "ListModel.h"
@interface MainViewTableViewCell : UITableViewCell{
    UIImageView *bgImageView;
    UIImageView *distanceImage;
    UIImageView *priceImage;
    UILabel *distanceLabel;
    UILabel *priceLabel;
    UIImageView *headImageView;
}
@property(nonatomic,strong)ListModel *model;
@property (nonatomic , retain) CycleScrollView *mainScorllView;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
