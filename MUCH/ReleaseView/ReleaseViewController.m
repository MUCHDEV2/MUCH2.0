//
//  ReleaseViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ReleaseViewController.h"
#import "AppDelegate.h"
#import "SliderViewController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "MuchApi.h"
@interface ReleaseViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f",self.image.size.height);
    [SliderViewController sharedSliderController].canMoveWithGesture = NO;
    self.title = @"MUCH";
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 13, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"Arrow"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if(self.image.size.height<320){
        imageView.frame = CGRectMake(0, (320-self.image.size.height)/2, 320, self.image.size.height);
    }else{
        imageView.frame = CGRectMake(0, 0, 320, 320);
    }
    imageView.image = self.image;
    [self.view addSubview:imageView];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 322, 320, 60)];
    priceTextField.backgroundColor = RGBCOLOR(221, 221, 221);
    priceTextField.placeholder = @"输入价格";
    priceTextField.textAlignment = NSTextAlignmentCenter;
    priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
    priceTextField.font =  [UIFont systemFontOfSize:20];
    [priceTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    priceTextField.delegate = self;
    [self.view addSubview:priceTextField];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 384, 159, 45);
    cancelBtn.backgroundColor = RGBCOLOR(223, 52, 45);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(161, 384, 159, 45);
    confirmBtn.backgroundColor = RGBCOLOR(219, 219, 219);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.enabled=NO;
    [self.view addSubview:confirmBtn];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [SliderViewController sharedSliderController].canMoveWithGesture = YES;
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect rect = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty+184);
    }];
    
    if (!bgBtn) {
        bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(0, self.view.frame.origin.y, 320, 320);
        [bgBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgBtn];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    [bgBtn removeFromSuperview];
    bgBtn = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    priceTextField.backgroundColor = [UIColor whiteColor];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

-(void)closeBtn{
    [priceTextField resignFirstResponder];
    if([priceTextField.text isEqualToString:@""]){
        priceTextField.backgroundColor = RGBCOLOR(221, 221, 221);
        confirmBtn.backgroundColor = RGBCOLOR(219, 219, 219);
    }else{
        priceTextField.backgroundColor = [UIColor whiteColor];
        confirmBtn.backgroundColor = RGBCOLOR(37, 162, 78);
        confirmBtn.enabled = YES;
    }
}

-(void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)confirmBtnClick{
    if([priceTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入价格" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        confirmBtn.enabled = NO;
        if (![ConnectionAvailable isConnectionAvailable]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.removeFromSuperViewOnHide =YES;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"当前网络不可用，请检查网络连接！";
            hud.labelFont = [UIFont fontWithName:nil size:14];
            hud.minSize = CGSizeMake(132.f, 108.0f);
            [hud hide:YES afterDelay:1];
        }else{
            [[AppDelegate instance]._locService startUserLocationService];
            [MuchApi ReleaseWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    NSLog(@"posts ==> %@",posts);
                    if([[NSString stringWithFormat:@"%@",posts[0][@"code"]] isEqualToString:@"200"]){
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }
            }price:priceTextField.text imgStr:self.imageStr log:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.longitude] lat:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.latitude]];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    confirmBtn.enabled = YES;
    //[self.delegate releaseSucess];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadDataFav" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
}
@end
