//
//  AttentionViewCellModel.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionViewCellModel.h"

@implementation AttentionViewCellModel
+(AttentionViewCellModel*)modelWithImageName:(NSString*)imageName userName:(NSString*)userName isFocuse:(BOOL)isFocuse indexPathRow:(NSInteger)indexPathRow{
    AttentionViewCellModel* model=[[AttentionViewCellModel alloc]init];
    model.imageName=imageName;
    model.userName=userName;
    model.isFocuse=isFocuse;
    model.indexPathRow=indexPathRow;
    return model;
}
@end
