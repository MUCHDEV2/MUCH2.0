//
//  LeftViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBCOLOR(221, 221, 221);
    [self getMainView];
    [self getListView];
    [self getQuitView];
}

-(void)getMainView{
    UIView* mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    //mainView.backgroundColor=[UIColor lightGrayColor];
    
    //用户头像的背景
    UIView* userBack=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 108)];
    userBack.center=CGPointMake(130, 94);
    //userBack.backgroundColor=[UIColor whiteColor];
    userBack.layer.cornerRadius=userBack.frame.size.width*.5;
    [mainView addSubview:userBack];
    
    //用户头像
    UIImageView* userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    userImageView.center=userBack.center;
    userImageView.layer.masksToBounds=YES;
    userImageView.layer.cornerRadius=userImageView.frame.size.width*.5;
    userImageView.image=[UIImage imageNamed:@"icon114"];
    [mainView addSubview:userImageView];
    
    //用户名称
    UILabel* userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    userNameLabel.center=CGPointMake(130, 165);
    userNameLabel.textAlignment=NSTextAlignmentCenter;
    userNameLabel.text=@"不开心和没头脑";
    [mainView addSubview:userNameLabel];
    
    [self.view addSubview:mainView];
}

-(void)getListView{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, 320, 180) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=45;
    tableView.scrollEnabled=NO;
    [self.view addSubview:tableView];
}

-(void)getQuitView{
    UIButton* quitView=[UIButton buttonWithType:UIButtonTypeCustom];
    quitView.frame=CGRectMake(0, 500, 320, 55);
    //quitView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:quitView];
    
    UILabel* quitLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 17.5, 200, 20)];
    quitLabel.text=@"退出登录";
    quitLabel.font=[UIFont systemFontOfSize:17];
    [quitView addSubview:quitLabel];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSArray* imageNames=@[@"side_menu_much_icon",
                          @"side_menu_mymuch_icon",
                          @"side_menu_favuser_icon",
                          @"side_menu_setting_icon"];
    NSArray* titles=@[@"卖来卖趣",
                      @"我的MUCH",
                      @"我收藏的人",
                      @"设置"];
    [cell.contentView addSubview:[self getSingleListViewWithImageName:imageNames[indexPath.row] title:titles[indexPath.row] remindNumber:indexPath.row==1?5:-1]];
    cell.contentView.backgroundColor=RGBCOLOR(221, 221, 221);
    return cell;
}

-(UIView*)getSingleListViewWithImageName:(NSString*)imageName title:(NSString*)title remindNumber:(NSInteger)remindNumber{
    UIView* singleListView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.center=CGPointMake(30, 22.5);
    [singleListView addSubview:imageView];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 12.5, 200, 20)];
    titleLabel.text=title;
    [singleListView addSubview:titleLabel];
    
    if (remindNumber!=-1) {
        UILabel* numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(192, 12.5, 20, 20)];
        numberLabel.layer.cornerRadius=4;
        numberLabel.textAlignment=NSTextAlignmentCenter;
        numberLabel.backgroundColor=[UIColor whiteColor];
        numberLabel.text=[NSString stringWithFormat:@"%d",remindNumber];
        [singleListView addSubview:numberLabel];
    }
    return singleListView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
