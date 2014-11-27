//
//  DetailCommentSubviewModel.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailCommentSubviewModel.h"
/**
 @property(nonatomic,copy)NSString* soureceUserName;
 @property(nonatomic,copy)NSString* targetUserName;
 @property(nonatomic,copy)NSString* replayContent;
 */
@implementation DetailCommentSubviewModel
+(DetailCommentSubviewModel*)detailCommentSubviewModelWithSoureceUserName:(NSString*)soureceUserName targetUserName:(NSString*)targetUserName replayContent:(NSString*)replayContent{
    
    DetailCommentSubviewModel* model=[[DetailCommentSubviewModel alloc]init];
    model.soureceUserName=soureceUserName;
    model.targetUserName=targetUserName;
    model.replayContent=replayContent;
    
    return model;
}
@end
