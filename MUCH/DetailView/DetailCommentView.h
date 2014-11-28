//
//  DetailCommentView.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCommentViewModel.h"

@interface DetailCommentView : UIView
+(DetailCommentView*)detailCommentViewWithModel:(DetailCommentViewModel*)model;

//数据层部分
@property(nonatomic,strong)DetailCommentViewModel* commentModel;//该评论model,包括评论内容以及评论被回复的内容model
@end
