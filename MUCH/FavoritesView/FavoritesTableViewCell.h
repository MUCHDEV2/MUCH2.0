//
//  FavoritesTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface FavoritesTableViewCell : UITableViewCell{
    UIImageView *bgImageView;
    UIImageView *distanceImage;
    UIImageView *priceImage;
    UILabel *distanceLabel;
    UILabel *priceLabel;
    
    UIImageView *statusImageView;
}
@property(nonatomic,strong)ListModel *model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
