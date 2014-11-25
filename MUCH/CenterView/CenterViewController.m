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
@interface CenterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TitleViewDelegate>
@property(nonatomic,weak)UIButton* userImageView;
@property(nonatomic,strong)UIImage* userImage;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBCOLOR(220, 220, 220);
    [self getTitleView];
    [self getTapResign];
    [MuchApi GetUserWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            userModel* model=posts[0];
            [self getListView];
        }else{
            NSLog(@"%@",error);
        }
    }];
    
}

-(void)getTapResign{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
}

-(void)getTitleView{
    TitleView* titleView=[TitleView titleViewWithTitle:@"个人中心" delegate:self];
    [self.view addSubview:titleView];
}

-(void)makeSure{
    NSData* data=UIImageJPEGRepresentation(self.userImage, 0.8);
    NSString* imageStr=[[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    [MuchApi UpdataHeadWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"sucess");
        }
    } imaStr:imageStr];
}

-(void)getListView{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, 320, 568-45) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=RGBCOLOR(220, 220, 220);
    tableView.scrollEnabled=NO;
    [self.view addSubview:tableView];
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
        
        UIButton* userBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        userBtn.center=view.center;
        userBtn.layer.cornerRadius=userBtn.frame.size.width*.5;
        userBtn.layer.masksToBounds=YES;
        [userBtn setBackgroundImage:[UIImage imageNamed:@"icon114"] forState:UIControlStateNormal];
        [userBtn addTarget:self action:@selector(chooseUserImageView) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:userBtn];
        self.userImageView=userBtn;
    }else if (indexPath.row<=4&&indexPath.row>=1){
        UITextField* content=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        content.delegate=self;
        content.center=CGPointMake(200, 27.5);
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
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    self.userImage=info[UIImagePickerControllerEditedImage];
    [self.userImageView setBackgroundImage:self.userImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
