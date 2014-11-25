//
//  AttentionViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionViewController.h"
#import "TitleView.h"
@interface AttentionViewController ()<TitleViewDelegate>

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"asfasdf");
    self.view.backgroundColor=[UIColor whiteColor];
    [self getTitleView];
    [self getSearchBar];
}

-(void)getSearchBar{
    
}

-(void)getTitleView{
    TitleView* titleView=[TitleView titleViewWithTitle:@"我关注的用户" delegate:self];
    [self.view addSubview:titleView];
}

-(void)makeSure{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
