//
//  MuchApi.h
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MuchApi : NSObject
//获取列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block start:(int)start indexSize:(int)indexSize log:(NSString *)log lat:(NSString *)lat;

//发布
+ (NSURLSessionDataTask *)ReleaseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block price:(NSString *)price imgStr:(NSString *)imgStr log:(NSString *)log lat:(NSString *)lat;
@end