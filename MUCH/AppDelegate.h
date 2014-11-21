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
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

