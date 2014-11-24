//
//  DetailViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailHeadTableViewCell.h"
@interface DetailViewController : UIViewController<DetailHeadTableViewCellDelegate>
@property(nonatomic,strong)NSString *aid;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *youlikeit;
@end
