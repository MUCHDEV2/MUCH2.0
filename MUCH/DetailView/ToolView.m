//
//  ToolView.m
//  MUCH
//
//  Created by 汪洋 on 14-8-12.
//  Copyright (c) 2014年 lanjr. All rights reserved.
//

#import "ToolView.h"
#import "LoginSqlite.h"
@implementation ToolView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        theSuperView = superView;
        [self setBackgroundColor:RGBCOLOR(206, 205, 205)];
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        [lineImage setImage:[UIImage imageNamed:@"07_03.png"]];
        [self addSubview:lineImage];
        
        UIImageView *fieldBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 240, 30)];
        [fieldBgView setImage:[UIImage imageNamed:@"04_14.png"]];
        [self addSubview:fieldBgView];
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 7, 230, 30)];
        _textfield.delegate = self;
        _textfield.font = [UIFont systemFontOfSize:14.0];
        //_textfield.returnKeyType = UIReturnKeySend;
        [self addSubview:_textfield];
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn setFrame:CGRectMake(260, 7, 49, 29)];
        [sendBtn setImage:[UIImage imageNamed:@"04_033"] forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]-0.01 animations:^{
        theSuperView.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        theSuperView.transform = CGAffineTransformIdentity;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(![_textfield.text isEqualToString:@""]){
        // 1、增加数据源
        NSString *content = _textfield.text;
        if ([delegate respondsToSelector:@selector(addMessageWithContent:)]){
            [delegate addMessageWithContent:content];
        }
        // 4、清空文本框内容
        _textfield.text = nil;
    }
    [_textfield resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([delegate respondsToSelector:@selector(gotoLoginView)]){
            [delegate gotoLoginView];
        }
    }
}

-(void)sendClick{
    if(![_textfield.text isEqualToString:@""]){
        // 1、增加数据源
        NSString *content = _textfield.text;
        if ([delegate respondsToSelector:@selector(addMessageWithContent:)]){
            [delegate addMessageWithContent:content];
        }
        // 4、清空文本框内容
        _textfield.text = nil;
        [_textfield resignFirstResponder];
    }
}
@end
