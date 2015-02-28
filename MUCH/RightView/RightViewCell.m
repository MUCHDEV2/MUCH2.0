//
//  RightViewCell.m
//  MUCH
//
//  Created by 孙元侃 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "RightViewCell.h"
@implementation RightViewCellModel
@end

@interface RightViewCell()
@property(nonatomic,strong)UIImageView* chooseImgView;
@property(nonatomic,strong)UILabel* contentLabel;
@end
@implementation RightViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSelf];
    }
    return self;
}

-(void)loadSelf{
    self.chooseImgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 24, 24)];
    [self addSubview:self.chooseImgView];
    
    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 7, 150, 30)];
    [self addSubview:self.contentLabel];
    UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230, 1)];
    separatorLine.image=[GetImagePath getImagePath:@"divid_line"];
    [self addSubview:separatorLine];
}

-(void)setCellIsChoose:(BOOL)isChoose content:(NSString*)content{
    self.chooseImgView.image=[GetImagePath getImagePath:isChoose?@"selected_icon":@"unselect_icon"];
    self.contentLabel.text=content;
}

@end
