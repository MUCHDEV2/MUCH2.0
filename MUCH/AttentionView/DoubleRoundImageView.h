//
//  DoubleRoundImageView.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoubleRoundImageView;
@protocol DoubleRoundImageViewDelegate <NSObject>
-(void)chooseUserImageViewInDoubleRoundView:(DoubleRoundImageView*)doubleRoundImageVIew;
@end
@interface DoubleRoundImageView : UIView
@property(nonatomic,weak)id<DoubleRoundImageViewDelegate>delegate;
@end
