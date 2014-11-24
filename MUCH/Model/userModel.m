//
//  userModel.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "userModel.h"

@implementation userModel
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.aid = dict[@"_id"];
    self.avatar = dict[@"avatar"];
    self.created = dict[@"created"];
    self.gender = dict[@"gender"];
    self.nickname = dict[@"nickname"];
    self.username = dict[@"username"];
}
@end
