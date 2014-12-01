//
//  AppDelegate.h
//  MUCH
//
//  Created by 汪洋 on 14/11/18.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SliderViewController.h"
#import "LoginViewController.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,CLLocationManagerDelegate,WXApiDelegate>{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CLLocationCoordinate2D coor;
@property (strong, nonatomic) BMKLocationService* _locService;
+ (AppDelegate *)instance;
-(void)initLoginView;
-(void)ddd;
@end

