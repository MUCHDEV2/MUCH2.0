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
    self.distance = [NSString stringWithFormat:@"%@",dict[@"distance"]];
    self.distance_str = dict[@"distance_str"];
    self.compare = [self compareDistance:self.distance];
    self.is_closed = [NSString stringWithFormat:@"%@",dict[@"is_closed"]];
    self.is_faved = [NSString stringWithFormat:@"%@",dict[@"is_faved"]];
}

-(NSString *)compareDistance:(NSString *)dis{
    NSString *str = nil;
    float newDis = [dis floatValue]/1000;
    if(2<newDis && newDis<5){
        //(75,198,104);
        return str=@"2";
    }else if(0<newDis && newDis<2){
        //(37,161,78)
        return str=@"5";
    }else if(newDis>5){
        return str=@"all";
    }else{
        return str=@"";
    }
}
@end
