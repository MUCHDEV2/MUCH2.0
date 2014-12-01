//
//  LoginViewController.h
//  MUCH
//
//  Created by 汪洋 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "RegisterViewController.h"
#import "WeiboSDK.h"
@protocol LoginViewControllerDelegate <NSObject>

-(void)loginSucsee;

@end
@interface LoginViewController : UIViewController<TencentSessionDelegate,WXApiDelegate,WeiboSDKDelegate>{
    UITextField *phoneTextField;
    UITextField *passWordTextField;
    TencentOAuth *tencentAuth;
    NSMutableArray*permissions;
}
@property(nonatomic,weak)id<LoginViewControllerDelegate>delegate;
@end
