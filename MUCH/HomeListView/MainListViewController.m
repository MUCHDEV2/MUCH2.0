//
//  MainListViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainListViewController.h"
#import "MJRefresh.h"
#import "SliderViewController.h"
@interface MainListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSTimeInterval lastOffsetCapture;
    CGPoint lastOffset;
    BOOL isScrollingFast;
}
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)UIButton *backTopBtn;
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation MainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:NO];
    self.tableView.separatorStyle = NO;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageNamed:@"menu_icon"] forState:UIControlStateNormal];
    [self.button setFrame:CGRectMake(30, 494, 44, 44)];
    [self.button addTarget:self action:@selector(gotoLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.backTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backTopBtn setImage:[UIImage imageNamed:@"back_to_top"] forState:UIControlStateNormal];
    [self.backTopBtn setFrame:CGRectMake(246, 30, 44, 44)];
    [self.backTopBtn addTarget:self action:@selector(gotoTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backTopBtn];
    self.backTopBtn.alpha = .5;
    
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"headerRereshing");
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)footerRereshing
{
    NSLog(@"footerRereshing");
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <2){
        NSString *stringcell = @"MainListHeadTableViewCell";
        MainListHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[MainListHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell index:indexPath.row] ;
        }
        cell.delegate = self;
        cell.selectionStyle = NO;
        return cell;
    }
    NSString *stringcell = @"MainViewTableViewCell";
    MainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if(!cell){
        cell = [[MainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
    }
    cell.selectionStyle = NO;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row <2){
        return 57;
    }
    return 175;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>=2){
        NSLog(@"%ld",(long)indexPath.row);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 这里做预加载
    CGPoint currentOffset = scrollView.contentOffset;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeDiff = currentTime - lastOffsetCapture;
    //NSLog(@"%f",timeDiff);
    if(timeDiff > 0.1) {
        CGFloat distance = currentOffset.y - lastOffset.y;
        //The multiply by 10, / 1000 isn't really necessary.......
        CGFloat scrollSpeedNotAbs = (distance * 10) / 1700; //in pixels per millisecond
        
        CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
        if (scrollSpeed > 0.5) {
            isScrollingFast = YES;
            //NSLog(@"Fast");
            [UIView animateWithDuration:0.5 animations:^{
                self.button.alpha = 0;
                [self.button removeFromSuperview];
                self.backTopBtn.alpha = 0;
                [self.backTopBtn removeFromSuperview];
            }];
        } else {
            isScrollingFast = NO;
            //NSLog(@"Slow");
            [self showBtn];
        }
        
        lastOffset = currentOffset;
        lastOffsetCapture = currentTime;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    [self showBtn];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
    [self showBtn];
}

-(void)showBtn{
    [UIView animateWithDuration:0.5 animations:^{
        self.button.alpha = 1;
        [self.view addSubview:self.button];
        self.backTopBtn.alpha = 0.5;
        [self.view addSubview:self.backTopBtn];
    }];
}

-(void)gotoTop{
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showBtn];
    });
}

-(void)gotofiltrate{
    NSLog(@"筛选");
}

-(void)gotoList{
    NSLog(@"列表");
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate popView];
}

-(void)addPhoto{
    NSLog(@"拍照");
}

-(void)gotoLeftView{
    [[SliderViewController sharedSliderController] leftItemClick];
}
@end
