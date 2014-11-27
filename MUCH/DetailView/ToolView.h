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
@end
@interface ToolView : UIView<UITextFieldDelegate>{
    UIView *theSuperView;
    id<ToolViewDelegate>delegate;
}
@property(nonatomic,strong)UITextField *_textfield;
@property(nonatomic,strong)id<ToolViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame superView:(UIView *)superView;
@end
