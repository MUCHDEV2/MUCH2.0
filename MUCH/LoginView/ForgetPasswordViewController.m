//
//  ForgetPasswordViewController.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
    NSArray* imageNames=@[@"phone_icon",@"check_icon",@"password_icon",@"password_icon"];
    NSArray* contents=@[@"请输入手机号码",@"请输入验证码",@"请输入新密码",@"请再次输入新密码"];
    for (int i=0; i<4; i++) {
        UIView* view=[self getContentViewWithImageName:imageNames[i] content:contents[i]];
        view.center=CGPointMake(160, 85+56*(0.5+i));
        [self.view addSubview:view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView*)getContentViewWithImageName:(NSString*)imageName content:(NSString*)content{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(22, 26, 17, 17)];
    imageView.image=[UIImage imageNamed:imageName];
    [view addSubview:imageView];
    
    UITextField* textField=[[UITextField alloc] initWithFrame:CGRectMake(57, 25, 160, 20)];
    textField.placeholder = content;
    textField.textColor=[UIColor whiteColor];
    textField.returnKeyType=UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:16];
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [view addSubview:textField];
    return view;
}
@end
