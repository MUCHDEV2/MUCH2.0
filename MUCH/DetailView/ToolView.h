//
//  ToolView.h
//  MUCH
//
//  Created by 汪洋 on 14-8-12.
//  Copyright (c) 2014年 lanjr. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToolViewDelegate<NSObject>
- (void)addMessageWithContent:(NSString *)content;
- (void)gotoLoginView;
@end
@interface ToolView : UIView<UITextFieldDelegate>{
    UIView *theSuperView;
    UITextField *_textfield;
    id<ToolViewDelegate>delegate;
}
@property(nonatomic,strong)id<ToolViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame superView:(UIView *)superView;
@end
