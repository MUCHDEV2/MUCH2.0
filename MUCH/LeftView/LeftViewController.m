//
//  LeftViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "LeftViewController.h"
#import "SliderViewController.h"
#import "LoginSqlite.h"
#import "AppDelegate.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBCOLOR(221, 221, 221);
    [self getMainView];
    [self getListView];
    //[self getQuitView];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeHeadImage) name:@"changHead" object:nil];
}

-(void)getMainView{
    UIView* mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    //mainView.backgroundColor=[UIColor lightGrayColor];
    
    //用户头像的背景
    UIView* userBack=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 108)];
    userBack.center=CGPointMake(130, 94);
    userBack.backgroundColor=[UIColor whiteColor];
    userBack.layer.cornerRadius=userBack.frame.size.width*.5;
    [mainView addSubview:userBack];
    
    //用户头像
    self.userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    self.userImageView.center=userBack.center;
    self.userImageView.layer.masksToBounds=YES;
    self.userImageView.layer.cornerRadius=self.userImageView.frame.size.width*.5;
    //userImageView.image=[UIImage imageNamed:@"icon114"];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[LoginSqlite getdata:@"avatar"]] placeholderImage:[UIImage imageNamed:@"icon114"]];
    [mainView addSubview:self.userImageView];
    
    //用户名称
    self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.userNameLabel.center=CGPointMake(130, 165);
    self.userNameLabel.textAlignment=NSTextAlignmentCenter;
    //userNameLabel.text=@"不开心和没头脑";
    self.userNameLabel.text = [LoginSqlite getdata:@"nickname"];
    [mainView addSubview:self.userNameLabel];
    
    [self.view addSubview:mainView];
}

-(void)getListView{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, 320, 225) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=45;
    tableView.scrollEnabled=NO;
    [self.view addSubview:tableView];
}

//-(void)getQuitView{
//    UIButton* quitView=[UIButton buttonWithType:UIButtonTypeCustom];
//    quitView.frame=CGRectMake(0, 500, 320, 55);
//    //quitView.backgroundColor=[UIColor orangeColor];
//    [self.view addSubview:quitView];
//    
//    UILabel* quitLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 17.5, 200, 20)];
//    quitLabel.text=@"退出登录";
//    quitLabel.font=[UIFont systemFontOfSize:17];
//    [quitView addSubview:quitLabel];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIView* backView=[[UIView alloc]initWithFrame:CGRectZero];
        backView.backgroundColor=RGBCOLOR(195, 195, 195);
        cell.selectedBackgroundView=backView;
    }
    NSArray* imageNames=@[@"side_menu_much_icon",
                          @"side_menu_mymuch_icon",
                          @"side_menu_favuser_icon",
                          @"side_menu_setting_icon",
                          @"logout_icon"];
    NSArray* titles=@[@"卖来卖趣",
                      @"我的MUCH",
                      @"我收藏的人",
                      @"个人中心",
                      @"登出"];
    [cell.contentView addSubview:[self getSingleListViewWithImageName:imageNames[indexPath.row] title:titles[indexPath.row] remindNumber:indexPath.row==1?5:-1]];//徐烨要求本来“我的MUCH”右边有个数字，现在数字不要了，但是还是要预留个位置，以后可能会变成一张图
    cell.contentView.backgroundColor=RGBCOLOR(221, 221, 221);
    if (indexPath.row==4) {
        UIView* separotorLine=[self getSeparatorLine];
        separotorLine.frame=CGRectMake(0, 44, 320, 1);
        [cell.contentView addSubview:separotorLine];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了第%d行",indexPath.row);
    if(indexPath.row == 0){
        [[SliderViewController sharedSliderController] showContentControllerWithModel:@"MainViewController"];
        [[SliderViewController sharedSliderController] closeSideBar];
        [SliderViewController sharedSliderController].canRightMoveWithGesture = YES;
    }else if(indexPath.row == 1){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
            [self addLoginView];
        }else{
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"FavoritesViewController"];
            [[SliderViewController sharedSliderController] closeSideBar];
        }
    }else if (indexPath.row == 2){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
            [self addLoginView];
        }else{
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"AttentionViewController"];
            [[SliderViewController sharedSliderController] closeSideBar];
        }
    }else if(indexPath.row == 3){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
            [self addLoginView];
        }else{
            [[SliderViewController sharedSliderController] showContentControllerWithModel:@"CenterViewController"];
            [[SliderViewController sharedSliderController] closeSideBar];
            [SliderViewController sharedSliderController].canRightMoveWithGesture = NO;
        }
    }else{
        [LoginSqlite deleteAll];
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[LoginSqlite getdata:@"avatar"]] placeholderImage:[UIImage imageNamed:@"icon114"]];
        self.userNameLabel.text = [LoginSqlite getdata:@"nickname"];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退出成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        //[[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
        [[SliderViewController sharedSliderController] showContentControllerWithModel:@"MainViewController"];
        [[SliderViewController sharedSliderController] closeSideBar];
        [SliderViewController sharedSliderController].canRightMoveWithGesture = YES;
    }
}

-(UIView*)getSingleListViewWithImageName:(NSString*)imageName title:(NSString*)title remindNumber:(NSInteger)remindNumber{
    UIView* singleListView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.center=CGPointMake(30, 22.5);
    [singleListView addSubview:imageView];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 12.5, 200, 20)];
    titleLabel.text=title;
    [singleListView addSubview:titleLabel];
    
//    if (remindNumber!=-1) {
//        UILabel* numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(192, 12.5, 20, 20)];
//        numberLabel.layer.cornerRadius=4;
//        numberLabel.textAlignment=NSTextAlignmentCenter;
//        numberLabel.backgroundColor=[UIColor whiteColor];
//        numberLabel.text=[NSString stringWithFormat:@"%d",remindNumber];
//        [singleListView addSubview:numberLabel];
//    }
    
    UIView* separatorLine=[self getSeparatorLine];
    [singleListView addSubview:separatorLine];
    return singleListView;
}

-(UIView*)getSeparatorLine{
    UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLine.image=[UIImage imageNamed:@"divid_line"];
    return separatorLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)changeHeadImage{
    NSLog(@"%@",[LoginSqlite getdata:@"avatar"]);
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[LoginSqlite getdata:@"avatar"]] placeholderImage:[UIImage imageNamed:@"icon114"]];
    self.userNameLabel.text = [LoginSqlite getdata:@"nickname"];
}

-(void)addLoginView{
    AppDelegate* app=[AppDelegate instance];
    [app initLoginView];
    LoginViewController *loginVC = app.loginView;
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
}
@end
