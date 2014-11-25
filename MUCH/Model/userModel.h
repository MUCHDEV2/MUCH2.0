//
//  userModel.h
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSDictionary *dict;
@end
