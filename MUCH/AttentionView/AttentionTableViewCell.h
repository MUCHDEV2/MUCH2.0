//
//  AttentionTableViewCell.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionViewCellModel : NSObject
@property(nonatomic,copy)NSString* imageName;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic)BOOL isFocuse;
+(AttentionViewCellModel*)modelWithImageName:(NSString*)imageName userName:(NSString*)userName isFocuse:(BOOL)isFocuse;
@end

@interface AttentionTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(AttentionViewCellModel*)model;
@end
