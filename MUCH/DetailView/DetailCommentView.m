//
//  DetailCommentView.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailCommentView.h"
#import "DoubleRoundImageView.h"
#import "SDImageCache.h"
#import "DetailCommentSubview.h"
@interface DetailCommentView()<UITableViewDataSource,UITableViewDelegate>
//主视图部分
@property(nonatomic,strong)UIView* mainView;//评论视图
@property(nonatomic,strong)DoubleRoundImageView* userImageView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* commentLabel;

//副视图部分
@property(nonatomic,strong)UITableView* replayTableView;//回复内容的tableView视图
@property(nonatomic,strong)NSMutableArray* commentViews;//该评论被回复的数组的视图view，数组元素为DetailCommentSubview类

@end

@implementation DetailCommentView
+(DetailCommentView*)detailCommentViewWithModel:(DetailCommentViewModel*)model{
    return [[DetailCommentView alloc]initWithModel:model];
}

-(instancetype)initWithModel:(DetailCommentViewModel*)model{
    if (self=[super init]) {
        [self loadSelfWithModel:model];
    }
    return self;
}

-(void)loadSelfWithModel:(DetailCommentViewModel*)model{
    self.commentModel=model;
    [self initMainView];
    [self initCommentViews];
    [self initReplayTableView];
    [self initSelf];
}

-(void)initMainView{
    self.userImageView=[DoubleRoundImageView doubleRoundImageViewWithBigRoundWidth:32 smallRoundWidth:28];
    self.userImageView.center=CGPointMake(27, 24);
    [self.userImageView.smallRound sd_setImageWithURL:[NSURL URLWithString:self.commentModel.userImageUrl]];

    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 200, NameHeight)];
    self.nameLabel.font=NameFont;
    self.nameLabel.text=self.commentModel.userName;
    
    CGRect bound=[self.commentModel.userComment boundingRectWithSize:CGSizeMake(ContentWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil];
    self.commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 29, ContentWidth, bound.size.height)];
    self.commentLabel.numberOfLines=0;
    self.commentLabel.font=ContentFont;
    self.commentLabel.text=self.commentModel.userComment;
    self.commentLabel.textColor=ContentColor;
    
    //计算mainView的height
    CGFloat tempHeight=self.commentLabel.frame.origin.y+self.commentLabel.frame.size.height;
    //CGFloat height=tempHeight<50?tempHeight:tempHeight;
    
    //给mainView.frame赋值
    self.mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, tempHeight)];
    [self addSubview:self.mainView];
    [self.mainView addSubview:self.userImageView];
    [self.mainView addSubview:self.nameLabel];
    [self.mainView addSubview:self.commentLabel];
}

-(void)initCommentViews{
    if (!self.commentViews) {
        self.commentViews=[NSMutableArray array];
    }
    for (int i=0; i<self.commentModel.replayContents.count; i++) {
        DetailCommentSubview* subview=[DetailCommentSubview detailCommentSubviewWithModel:self.commentModel.replayContents[i]];
        [self.commentViews addObject:subview];
    }
}

-(void)initReplayTableView{
    CGFloat totalHeight=0;
    for (int i=0; i<self.commentViews.count; i++) {
        totalHeight+=[self.commentViews[i] frame].size.height;
    }
    self.replayTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.mainView.frame.size.height, 320, totalHeight) style:UITableViewStylePlain];
    self.replayTableView.scrollEnabled=NO;
    self.replayTableView.delegate=self;
    self.replayTableView.dataSource=self;
    self.replayTableView.allowsSelection=NO;
    self.replayTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:self.replayTableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.commentViews[indexPath.row] frame].size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentViews.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.commentViews[indexPath.row]];
    cell.contentView.backgroundColor=BackGround;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)initSelf{
    self.frame=CGRectMake(0, 0, 320, self.replayTableView.frame.origin.y+self.replayTableView.frame.size.height+10);
}
@end
