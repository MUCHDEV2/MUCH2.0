//
//  AttentionViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionViewController.h"
#import "MuchApi.h"
@interface AttentionViewController ()

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    showArr = [[NSMutableArray alloc] init];
    [MuchApi GetFavWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
        }
    }];
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
