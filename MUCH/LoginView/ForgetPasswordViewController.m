//
//  ForgetPasswordViewController.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "MuchApi.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[GetImagePath getImagePath:@"Background"]];
    NSArray* imageNames=@[@"phone_icon",@"check_icon",@"password_icon",@"password_icon"];
    NSArray* contents=@[@"请输入手机号码",@"请输入验证码",@"请输入新密码",@"请再次输入新密码"];
    for (int i=0; i<4; i++) {
        UIView* view=[self getContentViewWithImageName:imageNames[i] content:contents[i]];
        [view.subviews[1] setTag:i+1];
        view.center=CGPointMake(160, 85+56*(0.5+i));
        [self.view addSubview:view];
        if (i==2||i==3) {
            UITextField* textField=(UITextField*)[view viewWithTag:i+1];
            textField.secureTextEntry=YES;
        }
    }
    [self getResetBtn];
    [self getYzmBtn];
    [self getLoginBtn];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

-(void)getResetBtn{
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(20, 330, 280, 45);
    [resetBtn setBackgroundImage:[GetImagePath getImagePath:@"login_register_bar"] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
}

-(void)getYzmBtn{
    UIButton *yzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [yzmBtn setBackgroundImage:[GetImagePath getImagePath:@"verif_code_bar"] forState:UIControlStateNormal];
    [yzmBtn addTarget:self action:@selector(yzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    yzmBtn.frame = CGRectMake(217, 163, 82, 27);
    [yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yzmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:yzmBtn];
}

-(void)getLoginBtn{
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(225, 530, 80, 30);
    [loginBtn setTitle:@"登录卖趣" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:loginBtn];
}

-(void)resetBtnClick{
    NSLog(@"选择了重置");
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:2];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:3];
    UITextField *textField4 = (UITextField *)[self.view viewWithTag:4];
    NSLog(@"%@",textField3.text);
    NSLog(@"%@",textField4.text);
    if([textField1.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if([textField3.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if([textField4.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请重复密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if(![textField3.text isEqualToString:textField4.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:textField1.text forKey:@"username"];
    [dic setValue:textField2.text forKey:@"smscode"];
    [dic setValue:textField3.text forKey:@"password"];
    [MuchApi FindpwdWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } dic:dic];
}

-(void)yzmBtnClick{
    NSLog(@"选择了验证码");
}

-(void)loginBtnClick{
    NSLog(@"选择了登录卖趣");
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(UIView*)getContentViewWithImageName:(NSString*)imageName content:(NSString*)content{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(22, 26, 17, 17)];
    imageView.image=[GetImagePath getImagePath:imageName];
    [view addSubview:imageView];
    
    UITextField* textField=[[UITextField alloc] initWithFrame:CGRectMake(57, 25, 150, 20)];
    textField.placeholder = content;
    textField.textColor=[UIColor whiteColor];
    textField.returnKeyType=UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:16];
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.delegate=self;
    [view addSubview:textField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 55, 280, 1)];
    [line setBackgroundColor:[UIColor whiteColor]];
    line.backgroundColor=[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:.5];
    [view addSubview:line];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
