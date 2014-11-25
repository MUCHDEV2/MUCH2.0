//
//  AttentionViewCellModel.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionViewCellModel : NSObject
@property(nonatomic,copy)NSString* imageName;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic)BOOL isFocuse;
@property(nonatomic)NSInteger indexPathRow;
+(AttentionViewCellModel*)modelWithImageName:(NSString*)imageName userName:(NSString*)userName isFocuse:(BOOL)isFocuse indexPathRow:(NSInteger)indexPathRow;
@end
