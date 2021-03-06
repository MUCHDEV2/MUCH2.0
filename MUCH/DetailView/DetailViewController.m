//
//  DetailViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "SliderViewController.h"
#import "ToolView.h"
#import "CommentModel.h"
#import "DetailCommentView.h"
#import "DetailCommentSubviewModel.h"
#import "ReplyModel.h"
#import "LoginSqlite.h"
#import "AppDelegate.h"
#import "MuchApi.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,ToolViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ToolView *toolView;
@property(nonatomic,strong)NSMutableArray* commentViews;
@property(nonatomic,strong)UIButton *bgView;
@end

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MUCH";
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 13, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"Arrow"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    showArr = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = RGBCOLOR(221, 221, 221);
    
     self.toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, 524, 320, 44) superView:self.view];
    self.toolView.delegate = self;
    [self.view addSubview:self.toolView];
    self.toolView.hidden = YES;
    [MuchApi GetSingleListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [self initCommentViews];
            [self.tableView reloadData];
        }
    } postId:self.aid];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initCommentViews{
    if (!self.commentViews) {
        self.commentViews=[[NSMutableArray alloc]init];
    }
    for (int i=0; i<showArr.count; i++) {
        CommentModel *commentModel = showArr[i];
        NSMutableArray* tempModels=[NSMutableArray array];
        for (int j=0; j<commentModel.reply.count; j++) {
            ReplyModel *replyModel = commentModel.reply[j];
            DetailCommentSubviewModel* model=[DetailCommentSubviewModel detailCommentSubviewModelWithSoureceUserName:replyModel.nickname targetUserName:[replyModel.nickname isEqualToString:self.dic[@"nickname"]]?commentModel.nickname:self.dic[@"nickname"] replayContent:replyModel.content];
            [tempModels addObject:model];
        }
        
        DetailCommentViewModel* model=[DetailCommentViewModel detailCommentViewModelWithUserImageUrl:commentModel.avatar userName:commentModel.nickname userComment:commentModel.content replayContents:tempModels];
        DetailCommentView* commentView=[DetailCommentView detailCommentViewWithModel:model];
        [self.commentViews addObject:commentView];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [SliderViewController sharedSliderController].canMoveWithGesture = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [SliderViewController sharedSliderController].canMoveWithGesture = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *stringcell = @"DetailHeadTableViewCell";
        DetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[DetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        cell.delegate = self;
        cell.imageUrl = self.imageUrl;
        cell.aid = self.aid;
        cell.youlikeit = self.youlikeit;
        cell.selectionStyle = NO;
        return cell;
    }else if(indexPath.row==1){
        NSString *stringcell = @"DetailContentTableViewCell";
        DetailContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[DetailContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        if([[NSString stringWithFormat:@"%@",self.dic] isEqualToString:@"<null>"]){
            cell.headImageUrl = @"";
        }else{
            cell.headImageUrl = self.dic[@"avatar"];
        }
        cell.distance = self.distance;
        cell.price = self.price;
        cell.delegate = self;
        cell.selectionStyle = NO;
        return cell;
    }else{
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:self.commentViews[indexPath.row-2]];
        cell.contentView.backgroundColor=RGBCOLOR(221, 221, 221);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+self.commentViews.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0){
        return 318;
    }else if (indexPath.row == 1){
        return 55;
    }
    return [self.commentViews[indexPath.row-2] frame].size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    flag = 2;
    if(indexPath.row>=2){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
            AppDelegate* app=[AppDelegate instance];
            [app initLoginView];
            LoginViewController *loginVC = app.loginView;
            UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
        }else{
            indexRow = (int)indexPath.row;
            CommentModel *commentModel = showArr[indexPath.row-2];
            if([[LoginSqlite getdata:@"userId"] isEqualToString:self.dic[@"_id"]]){
                NSLog(@"铁主");
                if (![[LoginSqlite getdata:@"userId"] isEqualToString:commentModel.userid]) {
                    if(self.toolView.hidden){
                        [self.toolView._textfield becomeFirstResponder];
                        self.toolView.hidden = NO;
                        self.tableView.frame = CGRectMake(0, -44, 320, 568);
                    }else{
                        [self.toolView._textfield resignFirstResponder];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.toolView.hidden = YES;
                            self.tableView.frame = self.view.frame;
                        });
                    }
                }
            }else{
                NSLog(@"访客");
                if(commentModel.reply.count !=0){
                    if([commentModel.userid isEqualToString:[LoginSqlite getdata:@"userId"]]){
                        if(self.toolView.hidden){
                            [self.toolView._textfield becomeFirstResponder];
                            self.toolView.hidden = NO;
                            self.tableView.frame = CGRectMake(0, -44, 320, 568);
                        }else{
                            [self.toolView._textfield resignFirstResponder];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                self.toolView.hidden = YES;
                                self.tableView.frame = self.view.frame;
                            });
                        }
                    }
                }
            }
        }
    }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showLoginView{
    AppDelegate* app=[AppDelegate instance];
    [app initLoginView];
    LoginViewController *loginVC = app.loginView;
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
}

-(void)showAlertView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide =YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"当前网络不可用，请检查网络连接！";
    hud.labelFont = [UIFont fontWithName:nil size:14];
    hud.minSize = CGSizeMake(132.f, 108.0f);
    [hud hide:YES afterDelay:1];
}

-(void)addTextFieldView{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        AppDelegate* app=[AppDelegate instance];
        [app initLoginView];
        LoginViewController *loginVC = app.loginView;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        flag = 1;
        if(self.toolView.hidden){
            [self.toolView._textfield becomeFirstResponder];
            self.toolView.hidden = NO;
            self.tableView.frame = CGRectMake(0, -44, 320, 568);
            if(self.bgView == nil){
                self.bgView = [UIButton buttonWithType:UIButtonTypeCustom];
                self.bgView.frame = self.tableView.frame;
                //self.bgView.backgroundColor = [UIColor redColor];
                [self.bgView addTarget:self action:@selector(closeTextField) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.bgView];
            }
        }else{
            [self.toolView._textfield resignFirstResponder];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.toolView.hidden = YES;
                self.tableView.frame = self.view.frame;
            });
        }
    }
}

-(void)closeTextField{
    [self.toolView._textfield resignFirstResponder];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.toolView.hidden = YES;
        self.tableView.frame = self.view.frame;
    });
}

-(void)addMessageWithContent:(NSString *)content{
    if(flag == 1){
        CommentModel *commentModel = [[CommentModel alloc] init];
        commentModel.nickname = [LoginSqlite getdata:@"nickname"];
        commentModel.avatar = [LoginSqlite getdata:@"avatar"];
        commentModel.content = content;
        DetailCommentViewModel* model=[DetailCommentViewModel detailCommentViewModelWithUserImageUrl:commentModel.avatar userName:commentModel.nickname userComment:commentModel.content replayContents:nil];
        DetailCommentView* commentView=[DetailCommentView detailCommentViewWithModel:model];
        [self.commentViews insertObject:commentView atIndex:0];
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.toolView.hidden = YES;
            self.tableView.frame = self.view.frame;
        });
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"userid"];
        [dic setValue:self.aid forKey:@"postid"];
        [dic setValue:content forKey:@"content"];
        
        [MuchApi AddCommentWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                
            }
        } dic:dic];
    }else{
        CommentModel *commentModel = showArr[indexRow-2];
        DetailCommentView *commentView = self.commentViews[indexRow-2];
        DetailCommentSubviewModel* subModel=[DetailCommentSubviewModel detailCommentSubviewModelWithSoureceUserName:[LoginSqlite getdata:@"nickname"] targetUserName:[[LoginSqlite getdata:@"nickname"] isEqualToString:self.dic[@"nickname"]]?commentModel.nickname:self.dic[@"nickname"] replayContent:content];
        [commentView.commentModel.replayContents addObject:subModel];
        commentView=[DetailCommentView detailCommentViewWithModel:commentView.commentModel];
        [self.commentViews replaceObjectAtIndex:indexRow-2 withObject:commentView];
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.toolView.hidden = YES;
            self.tableView.frame = self.view.frame;
        });
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"userid"];
        [dic setValue:self.aid forKey:@"postid"];
        [dic setValue:content forKey:@"content"];
        [dic setValue:commentModel.commentid forKey:@"commentid"];
        
        [MuchApi AddReplyWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
            
            }
        } dic:dic];
    }
}
@end
