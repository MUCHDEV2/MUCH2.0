//
//  RightViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "RightViewController.h"
#import "RightViewCell.h"
@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray* chooses;
@end

@implementation RightViewController

-(NSArray *)chooses{
    if (!_chooses) {
        NSMutableArray* array=[NSMutableArray array];
        for (int i=0; i<5; i++) {
            RightViewCellModel* model=[[RightViewCellModel alloc]init];
            model.isChoose=@"0";
            [array addObject:model];
        }
        _chooses=[array copy];
    }
    return _chooses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(220, 220, 220);
    [self getMainView];
    [self getListView];
}

-(void)getMainView{
    UIView* mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 30)];
    [self.view addSubview:mainView];
    
    UIFont* font=[UIFont boldSystemFontOfSize:17];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(85, 0, 100, 30)];
    titleLabel.text=@"筛选";
    titleLabel.font=font;
    [mainView addSubview:titleLabel];
    
    UIButton* sureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    sureBtn.frame=CGRectMake(270, 0, 50, 30);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font=font;
    [mainView addSubview:sureBtn];
}

-(void)sureBtnClick{
    NSString* userType;
    if ([[self.chooses[0] isChoose] isEqualToString:@"1"]) {
        userType=@"0";
    }else if ([[self.chooses[1] isChoose] isEqualToString:@"1"]){
        userType=@"1";
    }else{
        userType=@"";
    }
    
    NSString* range;
    if ([[self.chooses[2] isChoose] isEqualToString:@"1"]) {
        range=@"2";
    }else if ([[self.chooses[3] isChoose] isEqualToString:@"1"]){
        range=@"5";
    }else{
        range=@"";
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"filtrate" object:nil userInfo:@{@"userType":userType,@"range":range}];
}

-(void)getListView{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(80, 90, 240, 220) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=44;
    tableView.scrollEnabled=NO;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[RightViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=self.view.backgroundColor;
    }
    NSArray* contents=@[@"个人用户",@"商家用户",@"<2公里范围",@"<5公里范围",@"全部范围"];
    BOOL isChoose=[[self.chooses[indexPath.row] isChoose] isEqualToString:@"1"];
    [cell setCellIsChoose:isChoose content:contents[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RightViewCellModel* model=self.chooses[indexPath.row];
    if ([model.isChoose isEqualToString:@"1"]) {
        model.isChoose=@"0";
        [self.view.subviews[1] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        model.isChoose=@"1";
        if (indexPath.row<=1) {
            for (int i=0; i<2; i++) {
                if (i==indexPath.row) continue;
                RightViewCellModel* tempModel=self.chooses[i];
                tempModel.isChoose=@"0";
            }
        }else{
            for (int i=2; i<5; i++) {
                if (i==indexPath.row) continue;
                RightViewCellModel* tempModel=self.chooses[i];
                tempModel.isChoose=@"0";
            }
        }
        [self.view.subviews[1] reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
