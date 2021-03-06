//
//  FavoritesTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@protocol FavoritesTableViewCellDelegate <NSObject>

-(void)showAlertView:(int)indexRow;

@end
@interface FavoritesTableViewCell : UITableViewCell{
    UIImageView *bgImageView;
    UIImageView *distanceImage;
    UIImageView *priceImage;
    UILabel *distanceLabel;
    UILabel *priceLabel;
    UILabel *timeLabel;
    
    UIImageView *statusImageView;
}
@property(nonatomic) int indexrow;
@property(nonatomic,strong)ListModel *model;
@property (nonatomic, strong) UIView *hours, *minutes;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, copy) NSDateFormatter *timeFormatter;
@property (nonatomic, copy) NSDateFormatter *dateFormatter;
@property(nonatomic,weak)id<FavoritesTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
