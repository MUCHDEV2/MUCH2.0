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
@end
