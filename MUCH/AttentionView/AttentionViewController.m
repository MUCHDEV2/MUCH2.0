//
//  AttentionViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionViewController.h"
#import "TitleView.h"
#import "AttentionTableViewCell.h"
@interface AttentionViewController ()<TitleViewDelegate,UITableViewDataSource,UITableViewDelegate,AttentionTableViewCellDelegate>

@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self getTitleView];
    [self getSearchBar];
    [self getListView];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

-(void)getListView{
    
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 77.5, 320, 568-77.5) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=55;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

-(void)getSearchBar{
    UISearchBar* searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(-5, 45, 330, 32.5)];
    searchBar.placeholder=@"搜索";
    [self.view addSubview:searchBar];
}

-(void)getTitleView{
    TitleView* titleView=[TitleView titleViewWithTitle:@"我关注的用户" delegate:self];
    [self.view addSubview:titleView];
}

-(void)makeSure{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
        cell=[[AttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    AttentionViewCellModel* model=[AttentionViewCellModel modelWithImageName:@"good_icon_selected" userName:@"lala" isFocuse:indexPath.row%2 indexPathRow:indexPath.row];
    NSLog(@"%d",indexPath.row);
    cell.model=model;
    return cell;
}

-(void)userFocuseWithIndexPathRow:(NSInteger)indexPathRow{
    NSLog(@"%d",indexPathRow);
}
@end
