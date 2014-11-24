//
//  MainListHeadTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainListHeadTableViewCell.h"

@implementation MainListHeadTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(int)index{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(195, 195, 195);
        [self addContent:index];
    }
    return self;
}

-(void)addContent:(int)index{
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, 320, 2)];
    lineImage.backgroundColor = RGBCOLOR(77, 77, 77);
    [self.contentView addSubview:lineImage];
    if(index == 0){
        filtrateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [filtrateBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
        filtrateBtn.frame = CGRectMake(100, 15.5, 17, 20);
        [filtrateBtn addTarget:self action:@selector(filtrateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:filtrateBtn];
        
        toListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [toListBtn setImage:[UIImage imageNamed:@"large_view"] forState:UIControlStateNormal];
        toListBtn.frame = CGRectMake(200, 15.5, 20, 20);
        [toListBtn addTarget:self action:@selector(toListBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:toListBtn];
    }else{
        addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addPhotoBtn setImage:[UIImage imageNamed:@"new_post_icon"] forState:UIControlStateNormal];
        addPhotoBtn.frame = CGRectMake(149, 16.5, 22, 22);
        [addPhotoBtn addTarget:self action:@selector(addPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addPhotoBtn];
    }
}

-(void)filtrateBtnClick{
    [self.delegate gotofiltrate];
}

-(void)toListBtnClick{
    [self.delegate gotoList];
}

-(void)addPhotoBtnClick{
    [self.delegate addPhoto];
}

@end
