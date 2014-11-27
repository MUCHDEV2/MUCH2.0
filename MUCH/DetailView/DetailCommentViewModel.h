//
//  DetailCommentViewModel.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailCommentViewModel : NSObject
@property(nonatomic,copy)NSString* userImageUrl;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* userComment;
@property(nonatomic,strong)NSMutableArray* replayContents;//该评论被回复的数组，数组元素为DetailCommentSubviewModel类
+(DetailCommentViewModel*)detailCommentViewModelWithUserImageUrl:(NSString*)userImageUrl userName:(NSString*)userName userComment:(NSString*)userComment replayContents:(NSMutableArray*)replayContents;
@end
