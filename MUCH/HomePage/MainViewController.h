//
//  MainViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/21.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHYScrollingNavBarViewController.h"
#import "MainHeadTableViewCell.h"
#import "MainViewTableViewCell.h"
#import "MainListViewController.h"
@interface MainViewController : UIViewController<MainHeadTableViewCellDelegate,MainListViewControllerDelegate>{
    NSMutableArray *showArr;
    int startIndex;
}

@end
