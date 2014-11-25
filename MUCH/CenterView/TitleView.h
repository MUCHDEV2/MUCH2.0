//
//  TitleView.h
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>
-(void)makeSure;
@end

@interface TitleView : UIView
+(TitleView*)titleViewWithTitle:(NSString*)title delegate:(id<TitleViewDelegate>)delegate;
@end
