//
//  ReleaseViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReleaseViewControllerDelegate <NSObject>

-(void)releaseSucess;

@end

@interface ReleaseViewController : UIViewController{
    UITextField *priceTextField;
    UIButton *bgBtn;
    UIButton *cancelBtn;
    UIButton *confirmBtn;
}
@property(nonatomic,strong)NSString *imageStr;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,weak)id<ReleaseViewControllerDelegate>delegate;
@end
