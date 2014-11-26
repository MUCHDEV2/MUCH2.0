//
//  RegisterViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Background"]];
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = self.view.frame;
    [bgBtn addTarget:self action:@selector(closekeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
    
//    UIImageView *cancelImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
//    [cancelImage setImage:[UIImage imageNamed:@"cross_x_icon"]];
//    [self.view addSubview:cancelImage];
//    
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //[cancelBtn setImage:[UIImage imageNamed:@"cross_x_icon"] forState:UIControlStateNormal];
//    cancelBtn.frame = CGRectMake(10, 10, 30, 30);
//    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancelBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 50)];
    titleLabel.text = @"MUCH";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:35];
    [self.view addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 320, 30)];
    contentLabel.text = @"发现和购买都可以在同一个地方！";
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:contentLabel];
    
    UILabel *contentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 30)];
    contentLabel2.text = @"创意就是在这里";
    contentLabel2.textColor = [UIColor whiteColor];
    contentLabel2.textAlignment = NSTextAlignmentCenter;
    contentLabel2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:contentLabel2];
    
    UIImageView *telephoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 180, 16, 16)];
    [telephoneImage setImage:[UIImage imageNamed:@"phone_icon"]];
    [self.view addSubview:telephoneImage];
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 173, 160, 30)];
    //phoneTextField.backgroundColor = [UIColor yellowColor];
    phoneTextField.placeholder = @"请输入手机号码";
    phoneTextField.returnKeyType=UIReturnKeyDone;
    phoneTextField.font =  [UIFont systemFontOfSize:15];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setTextColor:[UIColor whiteColor]];
    [phoneTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    phoneTextField.delegate = self;
    [self.view addSubview:phoneTextField];
    
    UIButton *yzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [yzmBtn setBackgroundImage:[UIImage imageNamed:@"verif_code_bar"] forState:UIControlStateNormal];
    yzmBtn.frame = CGRectMake(218, 175, 82, 27);
    [yzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yzmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:yzmBtn];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 210, 280, 1)];
    //[lineImage setImage:[UIImage imageNamed:@"divid_line"]];
    [lineImage setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage];
    
    UIImageView *passWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 280, 17, 18)];
    [passWordImage setImage:[UIImage imageNamed:@"password_icon"]];
    [self.view addSubview:passWordImage];
    
    passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 273, 250, 30)];
    //passWordTextField.backgroundColor = [UIColor yellowColor];
    passWordTextField.delegate = self;
    passWordTextField.placeholder=@"请输入密码";
    passWordTextField.returnKeyType=UIReturnKeyDone;
    passWordTextField.font =  [UIFont systemFontOfSize:15];
    passWordTextField.secureTextEntry = YES;
    [passWordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [passWordTextField setTextColor:[UIColor whiteColor]];
    [passWordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:passWordTextField];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 310, 280, 1)];
    //[lineImage setImage:[UIImage imageNamed:@"divid_line"]];
    [lineImage2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage2];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, 330, 280, 45);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_bar"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(220, 530, 80, 30);
    [registBtn setTitle:@"登录卖趣" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(20, 530, 80, 30);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginBtnClick{
    //注册
}

-(void)registBtnClick{
    //返回登录
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)closekeyboard{
    [passWordTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
}
@end
