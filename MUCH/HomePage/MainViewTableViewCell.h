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
#import "SmallUserImageView.h"

@interface MainViewTableViewCell : UITableViewCell<SmallUserImageViewDelegate>{
//    UIImageView *bgImageView;
//    UIImageView *distanceImage;
//    UIImageView *priceImage;
//    UILabel *distanceLabel;
//    UILabel *priceLabel;
//    SmallUserImageView *headImageView;
//    NSString *contactId;
    
    UILabel *namelabel;
    UILabel *distancelabel;
    UILabel *contentNamelabel;
    UILabel *contentlabel;
    UILabel *contentNamelabel2;
    UILabel *contentlabel2;
    UILabel *contentNamelabel3;
    UILabel *contentlabel3;
    UILabel *pricelabel;
    UIImageView *commetImage;
    UILabel *commetLabel;
    UIImageView *goodImage;
    UILabel *goodlabel;
    UIImageView *bigImage;
    UIImageView *headView;
    UIImageView * lineImageView;
}
@property(nonatomic,strong)ListModel *model;
@property (nonatomic)BOOL myNeedLong;
@property (nonatomic , retain) CycleScrollView *mainScorllView;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
