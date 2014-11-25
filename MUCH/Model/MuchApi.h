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

//点赞
+ (NSURLSessionDataTask *)LikeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block aid:(NSString *)aid;

//上传头像
+ (NSURLSessionDataTask *)UpdataHeadWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block imaStr:(NSString *)imaStr;

//获取个人信息
+ (NSURLSessionDataTask *)GetUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block;

//关注人
+ (NSURLSessionDataTask *)AddFavWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//获取关注的人
+ (NSURLSessionDataTask *)GetFavWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block;

//登录
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord;

//注册
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord passwordConfirmation:(NSString *)passwordConfirmation avatar:(NSString *)avatar nickName:(NSString *)nickName;

//验证微信
+(void)GetWeiXin:(void (^)(NSDictionary *posts, NSError *error))block code:(NSString *)code;

//微信个人信息
+ (void)GetWeiXinUser:(void (^)(NSDictionary *dic, NSError *error))block access_token:(NSString *)access_token;
@end
