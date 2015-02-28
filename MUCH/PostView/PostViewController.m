//
//  PostViewController.m
//  MUCH
//
//  Created by 汪洋 on 15/2/13.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "PostViewController.h"
#import "MuchApi.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "PostContentView.h"
#import "PostTableViewCell.h"
@interface PostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)NSMutableArray *dateArr;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)PostContentView *postContentView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewArr = [[NSMutableArray alloc] init];
    self.dateArr = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundColor:RGBCOLOR(217, 217, 217)];
    self.tableView.separatorStyle = NO;
    [self loadList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadList{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:1];
    }else{
        [MuchApi GetPostWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.showArr = posts;
                for(int i=0; i<[[posts[0] allKeys]count];i++){
                    self.postContentView = [PostContentView setFram:[posts[0] objectForKey:[posts[0] allKeys][i]]];
                    [self.viewArr insertObject:self.postContentView atIndex:0];
                    [self.dateArr insertObject:[posts[0] allKeys][i] atIndex:0];
                }
                [self.tableView reloadData];
            }
        } aid:self.targetId];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.showArr[0] allKeys]count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 70;
    }else{
        if(self.viewArr.count !=0){
            self.postContentView = [self.viewArr objectAtIndex:indexPath.row-1];
            return self.postContentView.frame.size.height;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *stringcell = @"PostTableViewCell";
        PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        cell.avatarUrl = self.avatarUrl;
        cell.userName = self.userName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *stringcell = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        for(int i=0;i<cell.contentView.subviews.count;i++) {
            [((UIView*)[cell.contentView.subviews objectAtIndex:i]) removeFromSuperview];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.viewArr.count !=0){
            self.postContentView = [self.viewArr objectAtIndex:indexPath.row-1];
            [cell.contentView addSubview:self.postContentView];
            
            //NSLog(@"%f",cell.frame.size.height);
            CGFloat tempHeight=self.postContentView.frame.size.height;
            UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 1, (indexPath.row!=[[self.showArr[0] allKeys]count])?tempHeight:tempHeight+400)];
            [lineImageView setBackgroundColor:RGBCOLOR(203, 203, 203)];
            [cell.contentView addSubview:lineImageView];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1, 15, 30, 30)];
            [imageview setImage:[UIImage imageNamed:@"椭圆-1"]];
            [cell.contentView addSubview:imageview];
            
            NSArray *arr = [self.dateArr[indexPath.row-1] componentsSeparatedByString:@"-"];
            
            UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 30, 10)];
            day.text = [NSString stringWithFormat:@"%@",[arr objectAtIndex:2]];
            day.font = [UIFont systemFontOfSize:13];
            day.textColor = [UIColor whiteColor];
            day.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:day];
            
            UILabel *month = [[UILabel alloc] initWithFrame:CGRectMake(1, 32, 30, 10)];
            month.text = [NSString stringWithFormat:@"%d月",[[arr objectAtIndex:1] integerValue]];
            month.font = [UIFont systemFontOfSize:9];
            month.textColor = [UIColor whiteColor];
            month.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:month];
        }
        return cell;
    }
}
@end
