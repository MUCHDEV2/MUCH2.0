//
//  NoDataView.h
//  MUCH
//
//  Created by 孙元侃 on 15/2/28.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoDataViewDelegate <NSObject>

//点击加号的委托
-(void)noDataViewAddBtnClicked;

@end

@interface NoDataView : UIView
+(NoDataView*)getNoDataViewWithDelegate:(id<NoDataViewDelegate>)delegate;
@end
