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
#import "userModel.h"
#import "AttentionModel.h"
#import "JSONKit.h"
#import "LoginSqlite.h"
#import "CommentModel.h"
@implementation MuchApi
//获取列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block start:(int)start indexSize:(int)indexSize log:(NSString *)log lat:(NSString *)lat range:(NSString *)range from:(NSString *)from{
    NSString *urlStr = [NSString stringWithFormat:@"/post?offset=%d&size=%d&userid=%@&longitude=%@&latitude=%@&range=%@&from=%@",start,indexSize,[LoginSqlite getdata:@"userId"],log,lat,range,from];
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


//发布
+(NSURLSessionDataTask *)ReleaseWithBlock:(void (^)(NSMutableArray *, NSError *))block price:(NSString *)price imgStr:(NSString *)imgStr log:(NSString *)log lat:(NSString *)lat{
    NSLog(@"=====>%@",[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userId"]]);
    
    NSString *urlStr = [NSString stringWithFormat:@"/post"];
    NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    price,@"title",
                                    imgStr,@"content",
                                    lat,@"latitude",
                                    log,@"longitude",
                                    [LoginSqlite getdata:@"userId"],@"createdby",
                                    nil];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:parametersdata forKey:@"post"];
    //NSLog(@"parametersdata ===> %@",parameters);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:[JSON objectForKey:@"status"]];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//点赞
+ (NSURLSessionDataTask *)LikeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block aid:(NSString *)aid{
    NSString *urlStr = [NSString stringWithFormat:@"/like"];
    NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:aid,@"postid",[LoginSqlite getdata:@"userId"],@"userid",nil];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:parametersdata forKey:@"like"];
    NSLog(@"==>%@",parameters);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"result"][@"comments"]];
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


//获取个人信息
+ (NSURLSessionDataTask *)GetUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block{
    NSString *urlStr = [NSString stringWithFormat:@"user/%@",[LoginSqlite getdata:@"userId"]];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            userModel *model = [[userModel alloc] init];
            [model setDict:JSON[@"result"]];
            [mutablePosts addObject:model];
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

//关注人
+ (NSURLSessionDataTask *)AddFavWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"fav/"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:dic forKey:@"fav"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"result"]];
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

//获取关注的人
+ (NSURLSessionDataTask *)GetFavWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block{
    NSString *urlStr = [NSString stringWithFormat:@"user/%@",[LoginSqlite getdata:@"userId"]];
    NSLog(@"==??==%@",urlStr);
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"result"][@"favs"]){
                AttentionModel *model = [[AttentionModel alloc] init];
                NSLog(@"item==%@",item);
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

//登录
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord{
    NSString *urlStr = [NSString stringWithFormat:@"user/signin"];
    NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    userName,@"username",
                                    passWord,@"password",
                                    nil];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//注册
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString *)userName passWord:(NSString *)passWord passwordConfirmation:(NSString *)passwordConfirmation avatar:(NSString *)avatar nickName:(NSString *)nickName{
    NSString *urlStr = [NSString stringWithFormat:@"user/register"];
    NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    userName,@"username",
                                    passWord,@"password",
                                    passwordConfirmation,@"passwordConfirmation",
                                    avatar,@"avatar",
                                    nickName,@"nickname",
                                    nil];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
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

//更新个人信息
+ (NSURLSessionDataTask *)UpdataWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"user/"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:dic forKey:@"user"];
    NSLog(@"parameters ===> %@",parameters);
    return [[AFAppDotNetAPIClient sharedClient] PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON[@"result"]];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//获取自己发的帖子
+ (NSURLSessionDataTask *)GetMyListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block aid:(NSString *)aid log:(NSString *)log lat:(NSString *)lat{
    NSString *urlStr = [NSString stringWithFormat:@"/mypost/%@?longitude=%@&latitude=%@",aid,log,lat];
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

//第三方登录
+ (NSURLSessionDataTask *)ThirdpartyWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block openId:(NSString *)openId avatar:(NSString *)avatar nickName:(NSString *)nickName{
    NSString *urlStr = [NSString stringWithFormat:@"user/thirdparty"];
    NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    openId,@"openid",
                                    nickName,@"nickname",
                                    avatar,@"avatar",
                                    nil];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//修改密码
+ (NSURLSessionDataTask *)FindpwdWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"user/findpwd"];
    NSMutableDictionary *parametersdata = [[NSMutableDictionary alloc] init];
    [parametersdata setObject:dic forKey:@"find"];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//发评论
+ (NSURLSessionDataTask *)CommentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"comment/"];
    NSMutableDictionary *parametersdata = [[NSMutableDictionary alloc] init];
    [parametersdata setObject:dic forKey:@"comment"];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//恢复评论
+ (NSURLSessionDataTask *)ReplyWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"reply/"];
    NSMutableDictionary *parametersdata = [[NSMutableDictionary alloc] init];
    [parametersdata setObject:dic forKey:@"reply"];
    NSLog(@"parametersdata ===> %@",parametersdata);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parametersdata success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"text"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//发评论
+ (NSURLSessionDataTask *)AddCommentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"/comment"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:dic forKey:@"comment"];
    NSLog(@"==>%@",parameters);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        //[mutablePosts addObject:[JSON objectForKey:@"token"]];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//回复
+ (NSURLSessionDataTask *)AddReplyWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"/reply"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:dic forKey:@"reply"];
    NSLog(@"==>%@",parameters);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        //[mutablePosts addObject:[JSON objectForKey:@"token"]];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//获取单条帖子
+ (NSURLSessionDataTask *)GetSingleListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block postId:(NSString *)postId{
    NSString *urlStr = [NSString stringWithFormat:@"/post/%@?userid=%@",postId,[LoginSqlite getdata:@"userId"]];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON[@"result"][@"comments"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"result"][@"comments"]){
                //NSLog(@"%@",item[@"commentid"]);
                CommentModel *model = [[CommentModel alloc] init];
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

//关闭帖子
+ (NSURLSessionDataTask *)GetCloseListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"/close"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:dic forKey:@"close"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON[@"result"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
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

//验证微信
+(void)GetWeiXin:(void (^)(NSDictionary *posts, NSError *error))block code:(NSString *)code{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx2fe5e9a05cc63f07&secret=03abac544342b22288ae0fdf5a05d630&code=%@&grant_type=authorization_code",code]];//创建URL
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:30];//设置超时时间
    [request setHTTPMethod:@"GET"];//设置请求方式
    NSError *err;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    //NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *resultDict = [data objectFromJSONData];
    //NSLog(@"temp is :%@",resultDict);
    if(block){
        block([NSDictionary dictionaryWithDictionary:resultDict],nil);
    }
}

//微信个人信息
+ (void)GetWeiXinUser:(void (^)(NSDictionary *dic, NSError *error))block access_token:(NSString *)access_token{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=OPENID",access_token]];//创建URL
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:30];//设置超时时间
    [request setHTTPMethod:@"GET"];//设置请求方式
    NSError *err;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    //NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *resultDict = [data objectFromJSONData];
    NSLog(@"temp is :%@",resultDict);
    if(block){
        block([NSDictionary dictionaryWithDictionary:resultDict],nil);
    }
}

+ (NSURLSessionDataTask *)GetPostWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block aid:(NSString *)aid{
    NSString *urlStr = [NSString stringWithFormat:@"/owner?id=%@&viewerid=%@",aid,[LoginSqlite getdata:@"userId"]];
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"code"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"result"]];
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
