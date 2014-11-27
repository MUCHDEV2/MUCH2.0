//
//  CommentModel.m
//  MUCH
//
//  Created by 汪洋 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "CommentModel.h"
#import "ReplyModel.h"
@implementation CommentModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.commentid = dict[@"commentid"];
    self.avatar = dict[@"avatar"];
    self.content = dict[@"content"];
    self.userid = dict[@"userid"];
    self.nickname = dict[@"nickname"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *item in dict[@"reply"]) {
        NSLog(@"%@",item[@"content"]);
        ReplyModel *model = [[ReplyModel alloc] init];
        [model setDict:item];
        [arr addObject:model];
    }
    self.reply = arr;
}
@end
