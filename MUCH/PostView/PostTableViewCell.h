//
//  PostTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 15/2/13.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell{
    UILabel *namelabel;
    UIImageView *headImage;
}
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *avatarUrl;
@end
