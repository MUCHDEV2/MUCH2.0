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
#import "MuchApi.h"
#import "AttentionModel.h"
#import "LoginSqlite.h"
@interface AttentionViewController ()<UITableViewDataSource,UITableViewDelegate,AttentionTableViewCellDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray* datas;
@property(nonatomic,strong)UITapGestureRecognizer* tap;
@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self getTitleView];
    [self getSearchBar];
    [self getListView];
}

-(void)firstNetWork{
    [MuchApi GetFavWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.datas=[NSMutableArray arrayWithArray:posts];
            [self.tableView reloadData];
        }
    }];
}

-(void)getListView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 77.5, 320, 568-77.5) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=55;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)getSearchBar{
    UISearchBar* searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(-5, 45, 330, 32.5)];
    searchBar.placeholder=@"搜索";
    searchBar.delegate=self;
    [self.view addSubview:searchBar];
}

-(void)getTitleView{
    TitleView* titleView=[TitleView titleViewWithTitle:@"我关注的用户" delegate:nil];
    UIView* view=titleView.subviews.lastObject;
    view.hidden=YES;
    [self.view addSubview:titleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    AttentionModel* model=self.datas[indexPath.row];
    AttentionViewCellModel* cellModel=[AttentionViewCellModel modelWithImageName:@"good_icon_selected" userName:model.nickname isFocuse:model.isFocuse indexPathRow:indexPath.row userImageUrl:model.avatar];
    cell.model=cellModel;
    return cell;
}

-(void)userFocuseWithIndexPathRow:(NSInteger)indexPathRow{
    AttentionModel* model=self.datas[indexPathRow];
    if (model.isFocuse) {
        [MuchApi AddFavWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                model.isFocuse=!model.isFocuse;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPathRow inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        } dic:[@{@"selfid":[LoginSqlite getdata:@"userId"],@"userid":model.aid} mutableCopy]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath==%d",indexPath.row);
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.view removeGestureRecognizer:self.view.gestureRecognizers.lastObject];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self firstNetWork];
}
@end
