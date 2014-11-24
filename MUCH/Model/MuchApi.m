//
//  MuchApi.m
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MuchApi.h"
#import "LoginSqlite.h"
#import "AFAppDotNetAPIClient.h"
#import "ListModel.h"
@implementation MuchApi
//获取列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block start:(int)start log:(NSString *)log lat:(NSString *)lat{
    NSString *urlStr = [NSString stringWithFormat:@"/post?offset=%d&size=5&userid=%@&longitude=%@&latitude=%@",start,[LoginSqlite getdata:@"userId"],log,lat];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"result"]){
                //NSLog(@"%@",item[@"comments"][0]);
                ListModel *model = [[ListModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}
@end
