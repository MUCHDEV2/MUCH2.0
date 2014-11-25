//
//  AttentionTableViewCell.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/25.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "DoubleRoundImageView.h"
@interface AttentionTableViewCell()
@property(nonatomic,strong)DoubleRoundImageView* userView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UIImageView* focuseBtn;
@property(nonatomic,strong)UIImageView* separatorLine;
@property(nonatomic,weak)id<AttentionTableViewCellDelegate>delegate;
@end
@implementation AttentionTableViewCell

-(DoubleRoundImageView *)userView{
    if (!_userView) {
        _userView=[DoubleRoundImageView doubleRoundImageViewWithBigRoundWidth:45 smallRoundWidth:39];
        _userView.center=CGPointMake(28, 27.5);
    }
    return _userView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(58, 17.5, 200, 20)];
    }
    return _nameLabel;
}

-(UIImageView *)focuseBtn{
    if (!_focuseBtn) {
        _focuseBtn=[[UIImageView alloc]initWithFrame:CGRectMake(232, 12, 74, 31)];
    
        if (self.delegate&&[self.delegate respondsToSelector:@selector(userFocuseWithIndexPathRow:)]) {
            _focuseBtn.userInteractionEnabled=YES;
            UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseUserFocuse:)];
            [_focuseBtn addGestureRecognizer:tap];
        }
    }
    return _focuseBtn;
}

-(void)chooseUserFocuse:(UITapGestureRecognizer*)tap{
    [self.delegate userFocuseWithIndexPathRow:self.model.indexPathRow];
}

-(UIImageView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(13, 54, 294, 1)];
        _separatorLine.image=[UIImage imageNamed:@"divid_line"];
    }
    return _separatorLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AttentionTableViewCellDelegate>)delegate{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.delegate=delegate;
        [self addSubview:self.userView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.focuseBtn];
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(AttentionViewCellModel *)model{
    _model=model;
    NSLog(@"=====%d",self.model.indexPathRow);
    self.nameLabel.text=model.userName;
    //暂时不要去除下面三行
    self.focuseBtn.image=[UIImage imageNamed:model.isFocuse?@"unfollow":@"follow"];
    
}
@end

