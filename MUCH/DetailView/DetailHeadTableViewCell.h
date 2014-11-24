//
//  DetailHeadTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailHeadTableViewCellDelegate <NSObject>
-(void)back;
-(void)showLoginView;
-(void)showAlertView;
@end
@interface DetailHeadTableViewCell : UITableViewCell{
    UIImageView *bgImageView;
    UIButton *loveBtn;
}
@property(nonatomic,strong)NSString *aid;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *youlikeit;
@property(nonatomic,weak)id<DetailHeadTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
