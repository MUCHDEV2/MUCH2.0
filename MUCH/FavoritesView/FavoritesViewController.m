//
//  FavoritesViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "FavoritesViewController.h"
#import "MuchApi.h"
#import "AppDelegate.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginSqlite.h"
#import "SliderViewController.h"
@interface FavoritesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:NO];
    self.tableView.separatorStyle = NO;
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (reloadList) name:@"reloadData" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (reloadList) name:@"reloadDataFav" object:nil];
    showArr = [[NSMutableArray alloc] init];
    [self reloadList];
}

-(void)viewDidAppear:(BOOL)animated{
    [SliderViewController sharedSliderController].canRightMoveWithGesture = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [SliderViewController sharedSliderController].canRightMoveWithGesture = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(showArr.count !=0){
        NSString *stringcell = @"FavoritesTableViewCell";
        FavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[FavoritesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        cell.model = showArr[indexPath.row];
        cell.selectionStyle = NO;
        return cell;
    }else{
        NSString *stringcell = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        cell.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"empty_data_full"]];
        cell.selectionStyle = NO;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(showArr.count !=0){
        return showArr.count;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(showArr.count !=0){
        return 151;
    }else{
        return self.view.frame.size.height;
    }
}

-(void)reloadList{
    [[AppDelegate instance]._locService startUserLocationService];
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
    }else{
        [MuchApi GetMyListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                showArr = posts;
                [self.tableView reloadData];
            }
        } aid:[LoginSqlite getdata:@"userId"] log:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.longitude] lat:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.latitude]];
    }
}
@end
