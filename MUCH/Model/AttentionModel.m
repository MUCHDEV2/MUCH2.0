//
//  AttentionModel.m
//  MUCH
//
//  Created by 汪洋 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionModel.h"

@implementation AttentionModel
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    self.aid = dict[@"_id"];
    self.avatar = dict[@"avatar"];
    self.created = dict[@"created"];
    self.gender = dict[@"gender"];
    self.nickname = dict[@"nickname"];
    self.username = dict[@"username"];
    self.unreadDot = [NSString stringWithFormat:@"%@",dict[@"unreadDot"]];
    self.isFocuse=YES;
}
@end
