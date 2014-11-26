//
//  RightViewCell.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewCellModel : NSObject
@property(nonatomic,copy)NSString* isChoose;
@end

@interface RightViewCell : UITableViewCell
-(void)setCellIsChoose:(BOOL)isChoose content:(NSString*)content;
@end
