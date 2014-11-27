//
//  DetailContentTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailContentTableViewCellDelegate <NSObject>

-(void)addTextFieldView;

@end

@interface DetailContentTableViewCell : UITableViewCell{
    UIImageView *headImage;
    UILabel *distanceLabel;
    UILabel *priceLabel;
}
@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,weak)id<DetailContentTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
