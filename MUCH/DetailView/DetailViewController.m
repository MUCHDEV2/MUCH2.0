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
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ToolView *toolView;
@property(nonatomic,strong)NSMutableArray* commentViews;
@end

@implementation DetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    showArr = [[NSMutableArray alloc] init];
    for(NSDictionary *item in self.commentsArr){
        CommentModel *model = [[CommentModel alloc] init];
        [model setDict:item];
        [showArr addObject:model];
    }
    [self initCommentViews];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:NO];
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = RGBCOLOR(221, 221, 221);
    
     self.toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, 524, 320, 44) superView:self.view];
    //toolview.delegate = self;
    [self.view addSubview:self.toolView];
    self.toolView.hidden = YES;
    
    //CommentModel *model = showArr[0];
    //NSLog(@"%@",model.reply);
}

-(void)initCommentViews{
    NSLog(@"===>%@",self.dic[@"nickname"]);
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
    
//    DetailCommentViewModel* model2222=[DetailCommentViewModel detailCommentViewModelWithUserImageUrl:@"http://121.40.127.189:3001/app/uploadimage/1416907988815921acac4.jpg" userName:@"用户名" userComment:@"评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容" replayContents:tempModels];
//    NSLog(@"%@",showArr);
//    for (int i=0; i<showArr.count; i++) {
//        CommentModel *commentModel = showArr[i];
//        DetailCommentViewModel* model=[DetailCommentViewModel detailCommentViewModelWithUserImageUrl:commentModel.avatar userName:commentModel.nickname userComment:commentModel.content replayContents:nil];
//        DetailCommentView* commentView=[DetailCommentView detailCommentViewWithModel:model2222];
//        [self.commentViews addObject:commentView];
//    }
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
        cell.contentView.backgroundColor=RGBCOLOR(237, 237, 237);
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
    if(indexPath.row>=2){
        NSLog(@"%ld",(long)indexPath.row);
    }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showLoginView{

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
    if(self.toolView.hidden){
        [self.toolView._textfield becomeFirstResponder];
        self.toolView.hidden = NO;
    }else{
        [self.toolView._textfield resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.toolView.hidden = YES;
        });
    }
}
@end
