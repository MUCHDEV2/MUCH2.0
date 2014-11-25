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
@property(nonatomic,strong)AttentionViewCellModel* model;
@end
@implementation AttentionTableViewCell

-(DoubleRoundImageView *)userView{
    struct model;
    if (!_userView) {
        _userView=[DoubleRoundImageView doubleRoundImageViewWithBigRoundWidth:45 smallRoundWidth:39];
        _userView.center=CGPointMake(28, 27.5);
        [self addSubview:_userView];
    }
    return _userView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(58, 17.5, 200, 20)];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UIImageView *)focuseBtn{
    if (!_focuseBtn) {
        _focuseBtn=[[UIImageView alloc]initWithFrame:CGRectMake(232, 12, 74, 31)];
        [self addSubview:_focuseBtn];
    }
    return _focuseBtn;
}

-(UIImageView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(13, 54, 294, 1)];
        _separatorLine.image=[UIImage imageNamed:@"divid_line"];
    }
    return _separatorLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(AttentionViewCellModel*)model{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.model=model;
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(AttentionViewCellModel *)model{
    self.nameLabel.text=model.userName;
    self.userView;
    self.nameLabel;
    self.focuseBtn;
}
@end

@implementation AttentionViewCellModel
+(AttentionViewCellModel*)modelWithImageName:(NSString*)imageName userName:(NSString*)userName isFocuse:(BOOL)isFocuse{
    AttentionViewCellModel* model=[[AttentionViewCellModel alloc]init];
    model.imageName=imageName;
    model.userName=userName;
    model.isFocuse=isFocuse;
    return model;
}
@end
