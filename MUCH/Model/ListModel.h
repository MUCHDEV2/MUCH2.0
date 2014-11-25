//
//  ListModel.h
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *youlikeit;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *is_closed;
@property (nonatomic, copy) NSString *is_faved;
@property (nonatomic, copy) NSDictionary *createdby;
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, copy) NSDictionary *dict;
@end
