//
//  AttentionModel.h
//  MUCH
//
//  Created by 汪洋 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionModel : NSObject
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic)BOOL isFocuse;
@end
