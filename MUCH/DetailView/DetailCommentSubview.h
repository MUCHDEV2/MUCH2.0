//
//  DetailCommentSubview.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCommentSubviewModel.h"
//本类为评论的回复视图，从属于为评论视图，存在于评论视图的一个属性数组里
@interface DetailCommentSubview : UIView
+(DetailCommentSubview*)detailCommentSubviewWithModel:(DetailCommentSubviewModel*)model;
@end
#define NameHeight 14
#define ContentHeight 14
#define NameFont [UIFont boldSystemFontOfSize:12]
#define ContentFont [UIFont systemFontOfSize:12]
#define ContentWidth 250
#define UserNameColor RGBCOLOR(10,95,254)
#define BackGround RGBCOLOR(237,237,237)
#define ContentColor RGBCOLOR(128,128,128)