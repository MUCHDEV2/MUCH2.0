//
//  CommentModel.h
//  MUCH
//
//  Created by 汪洋 on 14/11/27.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,copy)NSString *commentid;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSMutableArray *reply;
@property (nonatomic, copy) NSDictionary *dict;
@end
