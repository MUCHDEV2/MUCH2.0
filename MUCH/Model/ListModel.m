//
//  ListModel.m
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.aid = dict[@"_id"];
    self.price = dict[@"title"];
    self.content = dict[@"content"];
    self.likes = [NSString stringWithFormat:@"%@",dict[@"likes"]];
    self.youlikeit = [NSString stringWithFormat:@"%@",dict[@"youlikeit"]];
    self.created = dict[@"created"];
    self.createdby = dict[@"createdby"];
    self.comments = dict[@"comments"];
    self.distance = dict[@"distance"];
    self.is_closed = [NSString stringWithFormat:@"%@",dict[@"is_closed"]];
    self.is_faved = [NSString stringWithFormat:@"%@",dict[@"is_faved"]];
}
@end
