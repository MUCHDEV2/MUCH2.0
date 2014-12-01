//
//  AppDelegate.m
//  MUCH
//
//  Created by 汪洋 on 14/11/18.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginSqlite.h"
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+ (AppDelegate *)instance {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)initLoginView{
    self.loginView = [[LoginViewController alloc] init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    imageView.image = [UIImage imageNamed:@"huanying"];
    [self.window addSubview:imageView];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"G6468a6AM46tY5G70D32xFlS"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"百度OK");
    }
    
    self._locService = [[BMKLocationService alloc]init];
    self._locService.delegate = self;
    [self._locService startUserLocationService];
    [self initLoginView];
    [LoginSqlite opensql];
    
    //向微信注册
    [WXApi registerApp:@"wx2fe5e9a05cc63f07"];
    
    //新浪注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SliderViewController sharedSliderController].LeftVC=[[LeftViewController alloc] init];
        [SliderViewController sharedSliderController].RightVC=[[RightViewController alloc] init];
        [SliderViewController sharedSliderController].RightSContentOffset=260;
        [SliderViewController sharedSliderController].RightSContentScale=0.6;
        [SliderViewController sharedSliderController].RightSOpenDuration=0.8;
        [SliderViewController sharedSliderController].RightSCloseDuration=0.8;
        [SliderViewController sharedSliderController].RightSJudgeOffset=160;
        [SliderViewController sharedSliderController].LeftSContentScale=1.0;
        [SliderViewController sharedSliderController].LeftSContentOffset=260;
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
        
        [self.window makeKeyAndVisible];
    });
    
    
    return YES;
}

-(void)ddd{
    WBAuthorizeRequest* request=[WBAuthorizeRequest request];
    request.redirectURI=kSinaRedirectURI;
    request.scope=@"all";
    [WeiboSDK sendRequest:request];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"定位跟新");
    NSLog(@"当前的坐标  维度:%f,经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.coor = userLocation.location.coordinate;
    [self._locService stopUserLocationService];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSArray *arr = [[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"];
    if([arr[0] isEqualToString:@"wx2fe5e9a05cc63f07"]){
        return [WXApi handleOpenURL:url delegate:self.loginView];
    }else{
        return [TencentOAuth HandleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSArray *arr = [[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"];
    if([arr[0] isEqualToString:@"wx2fe5e9a05cc63f07"]){
        return [WXApi handleOpenURL:url delegate:self.loginView];
    }else if ([arr[0] isEqualToString:@"wb3478815256"]){
        NSLog(@"333");
        return 1;
    }else{
        return [TencentOAuth HandleOpenURL:url];
    }
}
@end
