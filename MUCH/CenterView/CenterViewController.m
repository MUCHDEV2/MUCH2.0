//
//  CenterViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBCOLOR(220, 220, 220);
    [self getTitleView];
    [self getListView];
}

-(void)getTitleView{
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    titleView.backgroundColor=RGBCOLOR(239, 239, 239);
    [self.view addSubview:titleView];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:20];
    titleLabel.center=CGPointMake(160, 22.5);
    titleLabel.text=@"个人中心";
    [titleView addSubview:titleLabel];
    
    UIButton* sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(0, 0, 65, 20);
    sureBtn.center=CGPointMake(290, 22.5);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [titleView addSubview:sureBtn];
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
    }
    //分割线
    if (indexPath.row==0|indexPath.row==1||indexPath.row==5) {
        UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        separatorLine.image=[UIImage imageNamed:@"divid_line"];
        [cell.contentView addSubview:separatorLine];
    }
    //背景
    cell.contentView.backgroundColor=RGBCOLOR(239, 239, 239);
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
        [cell.contentView addSubview:userBtn];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
