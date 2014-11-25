//
//  AttentionTableViewCell.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionViewCellModel.h"
@protocol AttentionTableViewCellDelegate <NSObject>
-(void)userFocuseWithIndexPathRow:(NSInteger)indexPathRow;
@end

@interface AttentionTableViewCell : UITableViewCell
@property(nonatomic,strong)AttentionViewCellModel* model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AttentionTableViewCellDelegate>)delegate;
@end
