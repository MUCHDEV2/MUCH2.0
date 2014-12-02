//
//  LoginViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "LoginViewController.h"
#import "MuchApi.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginSqlite.h"
#import "ForgetPasswordViewController.h"
#import "AppDelegate.h"
#import "SliderViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Background"]];
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = self.view.frame;
    [bgBtn addTarget:self action:@selector(closekeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
    
    UIImageView *cancelImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 15, 15)];
    [cancelImage setImage:[UIImage imageNamed:@"cross_x_icon"]];
    [self.view addSubview:cancelImage];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[cancelBtn setImage:[UIImage imageNamed:@"cross_x_icon"] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(10, 10, 30, 30);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
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
    
    UIImageView *telephoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 230, 16, 16)];
    [telephoneImage setImage:[UIImage imageNamed:@"phone_icon"]];
    [self.view addSubview:telephoneImage];
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 223, 250, 30)];
    //phoneTextField.backgroundColor = [UIColor yellowColor];
    phoneTextField.placeholder = @"您注册的手机号码";
    phoneTextField.returnKeyType=UIReturnKeyDone;
    phoneTextField.font =  [UIFont systemFontOfSize:15];
    [phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneTextField setTextColor:[UIColor whiteColor]];
    [phoneTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    phoneTextField.delegate = self;
    [self.view addSubview:phoneTextField];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 260, 280, 1)];
    [lineImage setBackgroundColor:[UIColor whiteColor]];
    lineImage.alpha = 0.5;
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
    [lineImage2 setBackgroundColor:[UIColor whiteColor]];
    lineImage2.alpha = 0.5;
    [self.view addSubview:lineImage2];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, 330, 280, 45);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_bar"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *contentLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 390, 320, 30)];
    contentLabel3.text = @"使用第三方快速登录";
    contentLabel3.textAlignment = NSTextAlignmentCenter;
    contentLabel3.textColor = [UIColor whiteColor];
    [self.view addSubview:contentLabel3];
    
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaBtn setImage:[UIImage imageNamed:@"weibo_icon"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sinaBtn.frame = CGRectMake(80, 430, 42, 41);
    [self.view addSubview:sinaBtn];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setImage:[UIImage imageNamed:@"qq_icon"] forState:UIControlStateNormal];
    qqBtn.frame = CGRectMake(136, 430, 42, 42);
    [qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setImage:[UIImage imageNamed:@"wechat_icon"] forState:UIControlStateNormal];
    wechatBtn.frame = CGRectMake(193, 430, 41, 40);
    [wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatBtn];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(220, 530, 80, 30);
    [registBtn setTitle:@"注册卖趣" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:registBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(20, 530, 80, 30);
    //forgetBtn.backgroundColor=[UIColor redColor];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:forgetBtn];
    [self setqq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setqq{
    NSString *appid = @"1102292194";
    
    
    tencentAuth = [[TencentOAuth alloc] initWithAppId:appid
                                          andDelegate:self];
    
    permissions = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:
                                                         kOPEN_PERMISSION_GET_USER_INFO,
                                                         kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                                         kOPEN_PERMISSION_ADD_ALBUM,
                                                         kOPEN_PERMISSION_ADD_IDOL,
                                                         kOPEN_PERMISSION_ADD_ONE_BLOG,
                                                         kOPEN_PERMISSION_ADD_PIC_T,
                                                         kOPEN_PERMISSION_ADD_SHARE,
                                                         kOPEN_PERMISSION_ADD_TOPIC,
                                                         kOPEN_PERMISSION_CHECK_PAGE_FANS,
                                                         kOPEN_PERMISSION_DEL_IDOL,
                                                         kOPEN_PERMISSION_DEL_T,
                                                         kOPEN_PERMISSION_GET_FANSLIST,
                                                         kOPEN_PERMISSION_GET_IDOLLIST,
                                                         kOPEN_PERMISSION_GET_INFO,
                                                         kOPEN_PERMISSION_GET_OTHER_INFO,
                                                         kOPEN_PERMISSION_GET_REPOST_LIST,
                                                         kOPEN_PERMISSION_LIST_ALBUM,
                                                         kOPEN_PERMISSION_UPLOAD_PIC,
                                                         kOPEN_PERMISSION_GET_VIP_INFO,
                                                         kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                                                         kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                                                         kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                                                         nil]];
}

-(void)qqBtnClick{
    [tencentAuth authorize:permissions inSafari:NO];
}

//qq登录成功
- (void)tencentDidLogin {
    // 登录成功
    NSLog(@"登录成功");
    NSLog(@"==>%@",tencentAuth.openId);
    [self getMessage];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if(cancelled){
        NSLog(@"用户取消");
    }else{
        NSLog(@"登录失败");
    }
}

-(void)tencentDidNotNetWork
{
    NSLog(@"没有网络");
}

-(void)getMessage
{
    if(![tencentAuth getUserInfo]){
        [self showInvalidTokenOrOpenIDMessage];
    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

//qq获取详情
- (void)getUserInfoResponse:(APIResponse*) response {
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        NSLog(@"userInfo%@",response.jsonResponse);
        [MuchApi ThirdpartyWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [LoginSqlite insertData:posts[0][@"avatar"] datakey:@"avatar"];
                [LoginSqlite insertData:posts[0][@"id"] datakey:@"userId"];
                [LoginSqlite insertData:posts[0][@"nickname"] datakey:@"nickname"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changHead" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate loginSucsee];
            }
        } openId:tencentAuth.openId avatar:[response.jsonResponse objectForKey:@"figureurl_qq_2"] nickName:[response.jsonResponse objectForKey:@"nickname"]];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
        
    }
}

//微信
-(void)wechatBtnClick{
    NSLog(@"wenxinbtnClick");
    //构造SendAuthReq结构体
    if([WXApi isWXAppInstalled]){
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"MUCH" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }else{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"还没有安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }
}

//微信回调
-(void) onResp:(SendAuthResp *)resp{
    [MuchApi GetWeiXin:^(NSDictionary *posts, NSError *error) {
        if(!error){
            NSLog(@"%@",posts[@"access_token"]);
            [MuchApi GetWeiXinUser:^(NSDictionary *dic, NSError *error) {
                if(!error){
                    [MuchApi ThirdpartyWithBlock:^(NSMutableArray *posts, NSError *error) {
                        if(!error){
                            [LoginSqlite insertData:posts[0][@"avatar"] datakey:@"avatar"];
                            [LoginSqlite insertData:posts[0][@"id"] datakey:@"userId"];
                            [LoginSqlite insertData:posts[0][@"nickname"] datakey:@"nickname"];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"changHead" object:nil];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
                            [self dismissViewControllerAnimated:YES completion:nil];
                            [self.delegate loginSucsee];
                        }
                    } openId:dic[@"openid"] avatar:dic[@"headimgurl"] nickName:dic[@"nickname"]];
                }
            } access_token:posts[@"access_token"]];
        }
    } code:resp.code];
}

/**
 *  sina微博登录
 */

-(void)sinaBtnClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"444" object:nil];
    return;
    SliderViewController* vc=[SliderViewController sharedSliderController];
    [vc ddd];
    return;
    WBAuthorizeRequest* request=[WBAuthorizeRequest request];
    request.redirectURI=kSinaRedirectURI;
    request.scope=@"all";
    [WeiboSDK sendRequest:request];
}

//*************************************
-(void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)closekeyboard{
    [passWordTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)loginBtnClick{
    if([phoneTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"手机号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if([passWordTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:1];
    }else{
        [MuchApi LoginWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [LoginSqlite insertData:posts[0][@"avatar"] datakey:@"avatar"];
                [LoginSqlite insertData:posts[0][@"id"] datakey:@"userId"];
                [LoginSqlite insertData:posts[0][@"nickname"] datakey:@"nickname"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changHead" object:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.delegate loginSucsee];
            }
        } userName:phoneTextField.text passWord:passWordTextField.text];
    }
}

-(void)registBtnClick{
    RegisterViewController *regView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regView animated:NO];
}

-(void)forgetBtnClick{
    ForgetPasswordViewController* vc=[[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
@end
