//
//  FavoritesViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesTableViewCell.h"
@interface FavoritesViewController : UIViewController<FavoritesTableViewCellDelegate>{
    NSMutableArray *showArr;
    int indexrow;
}

@end
