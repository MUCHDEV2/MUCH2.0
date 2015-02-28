//
//  CenterViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "CenterViewController.h"
#import "MuchApi.h"
#import "GTMBase64.h"
#import "userModel.h"
#import "TitleView.h"
#import "LoginSqlite.h"
#import "SliderViewController.h"
@interface CenterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TitleViewDelegate>
@property(nonatomic,weak)UIButton* userImageView;
@property(nonatomic,strong)UIImage* userImage;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic)CGPoint orginCenter;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.orginCenter=self.view.center;
    self.view.backgroundColor=RGBCOLOR(220, 220, 220);
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (reloadData) name:@"reloadData" object:nil];
    //[self getTitleView];
    [self getTapResign];
    [self getListView];
    [self reloadData];
}

-(void)getTapResign{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTextFielEndEdit)];
    [self.view addGestureRecognizer:tap];
}

-(void)getTitleView{
    TitleView* titleView=[TitleView titleViewWithTitle:@"个人中心" delegate:self];
    [self.view addSubview:titleView];
}

-(void)makeSure{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(self.userImage !=nil){
        NSData* data=UIImageJPEGRepresentation(self.userImage, 0.8);
        NSString* imageStr=[[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
        [dic setValue:imageStr forKey:@"avatar"];
    }
    [dic setValue:self.model.nickname forKey:@"nickname"];
    [dic setValue:self.model.gender forKey:@"gender"];
    [dic setValue:self.model.city forKey:@"city"];
    [dic setValue:self.model.phone forKey:@"phone"];
    [dic setValue:self.model.aid forKey:@"_id"];
    [MuchApi UpdataWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [LoginSqlite insertData:posts[0][@"avatar"] datakey:@"avatar"];
            [LoginSqlite insertData:posts[0][@"nickname"] datakey:@"nickname"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changHead" object:nil];
            [[SliderViewController sharedSliderController] leftItemClick];
        }
    } dic:dic];
}

-(void)getListView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 504) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=RGBCOLOR(220, 220, 220);
    self.tableView.scrollEnabled=NO;
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?55:98;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=RGBCOLOR(239, 239, 239);
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //分割线
    if (indexPath.row==0|indexPath.row==1||indexPath.row==5) {
        UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        separatorLine.image=[UIImage imageNamed:@"divid_line"];
        [cell.contentView addSubview:separatorLine];
    }
    //背景
    //名称label
    UILabel* nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 20)];
    NSArray* names=@[@"头像",@"昵称",@"性别",@"所在城市",@"手机号",@"使用帮助",@"关于MUCH"];
    nameLabel.text=names[indexPath.row];
    //名称label位置
    CGPoint center=nameLabel.center;
    center.y=indexPath.row?27.5:49;
    nameLabel.center=center;
    [cell.contentView addSubview:nameLabel];
    if (!indexPath.row) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 85)];
        view.backgroundColor=[UIColor whiteColor];
        view.center=CGPointMake(260, 49);
        view.layer.cornerRadius=view.frame.size.width*.5;
        [cell.contentView addSubview:view];
        
        UIImageView *userImage = [[UIImageView alloc] init];
        [userImage sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"icon114"]];
        //NSLog(@"===>%@",self.model.avatar);
        if([self.model.avatar isEqualToString:@""]){
            self.userImage = nil;
        }else{
            self.userImage = userImage.image;
        }
        
        UIButton* userBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        userBtn.center=view.center;
        userBtn.layer.cornerRadius=userBtn.frame.size.width*.5;
        userBtn.layer.masksToBounds=YES;
        [userBtn setBackgroundImage:userImage.image forState:UIControlStateNormal];
        [userBtn addTarget:self action:@selector(chooseUserImageView) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:userBtn];
        self.userImageView=userBtn;
    }else if (indexPath.row<=4&&indexPath.row>=1){
        UITextField* content=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        content.delegate=self;
        content.center=CGPointMake(200, 27.5);
        if(indexPath.row == 1){
            content.text = self.model.nickname;
        }else if (indexPath.row == 2){
            content.text = self.model.gender;
        }else if (indexPath.row == 3){
            content.text = self.model.city;
        }else{
            content.text = self.model.phone;
        }
        content.tag = indexPath.row;
        [cell.contentView addSubview:content];
    }
    return cell;
}

-(void)chooseUserImageView{
    UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==2)return ;
    NSLog(@"%d",buttonIndex);
    UIImagePickerController* picker=[[UIImagePickerController alloc]init];
    picker.sourceType=!buttonIndex;
    picker.delegate=self;
    picker.allowsEditing=YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:^{
        //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.userImage=info[UIImagePickerControllerEditedImage];
    [self.userImageView setBackgroundImage:self.userImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{
        //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self myTextFielEndEdit];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.view.center.y==self.orginCenter.y) {
        CGPoint center=self.view.center;
        center.y-=100;
        [UIView animateWithDuration:.5 animations:^{
            self.view.center=center;
        }];
    }
}

-(void)myTextFielEndEdit{
    [UIView animateWithDuration:.3 animations:^{
        self.view.center=self.orginCenter;
    } completion:^(BOOL finished) {
        [self.view endEditing:YES];
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self myTextFielEndEdit];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{
    NSLog(@"%d",textField.tag);
    if(textField.tag == 1){
        self.model.nickname = textField.text;
    }else if (textField.tag == 2){
        self.model.gender = textField.text;
    }else if(textField.tag == 3){
        self.model.city = textField.text;
    }else if(textField.tag == 4){
        self.model.phone = textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)reloadData{
    [MuchApi GetUserWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.model=posts[0];
            [self.tableView reloadData];
        }else{
            NSLog(@"%@",error);
        }
    }];
}


@end
