//
//  ReplyModel.m
//  MUCH
//
//  Created by 汪洋 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.avatar = dict[@"avatar"];
    self.content = dict[@"content"];
    self.nickname = dict[@"nickname"];
    self.userid = dict[@"userid"];
}
@end
