//
//  MainListViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainListHeadTableViewCell.h"
#import "MainListTableViewCell.h"
#import "ReleaseViewController.h"
#import "DetailViewController.h"
@protocol MainListViewControllerDelegate <NSObject>

-(void)popView;

@end
@interface MainListViewController : UIViewController<MainListHeadTableViewCellDelegate,ReleaseViewControllerDelegate>{
    NSMutableArray *showArr;
    int startIndex;
    NSString *range;//2公里，5公里
    NSString *from;//0是个人，1是商家
}
@property(nonatomic,weak)id<MainListViewControllerDelegate>delegate;
@end
