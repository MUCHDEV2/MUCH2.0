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
    self.view.backgroundColor=[UIColor greenColor];
    [self getMainView];
}

-(void)getMainView{
    UIView* mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    mainView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:mainView];
}

-(void)getListView{
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, 320, 180) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=45;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSArray* imageNames=@[];
    NSArray* titles=@[];
    [cell.contentView addSubview:[self getSingleListViewWithImageName:<#(NSString *)#> title: remindNumber:<#(NSInteger)#>]];
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
    return singleListView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
