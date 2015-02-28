//
//  NoDataView.m
//  MUCH
//
//  Created by 孙元侃 on 15/2/28.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "NoDataView.h"
#import "GetImagePath.h"
@interface NoDataView()
@property(nonatomic,weak)id<NoDataViewDelegate>delegate;
@end
@implementation NoDataView
+(NoDataView *)getNoDataViewWithDelegate:(id<NoDataViewDelegate>)delegate{
    NoDataView* mainView=[[NoDataView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    mainView.delegate=delegate;
    
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"NoDataImage"]];
    imageView.center=CGPointMake(160, 175);
    [mainView addSubview:imageView];
    
    UIImageView* contentImageView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"NoDataContent"]];
    contentImageView.center=CGPointMake(160, 248);
    [mainView addSubview:contentImageView];
    
    UIButton* addBtn=[mainView getAddBtn];
    addBtn.center=CGPointMake(160, 568-addBtn.frame.size.height*.5);
    [mainView addSubview:addBtn];
    
    return mainView;
}

//+(UIImageView*)getImageView{
//
//}
//
//+(UIImageView*)getContentImageView{
//
//}

-(UIButton*)getAddBtn{
    UIButton* addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image=[GetImagePath getImagePath:@"NoDataViewAddBack"];
    addBtn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [addBtn setBackgroundImage:image forState:UIControlStateNormal];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(noDataViewAddBtnClicked)]) {
        [addBtn addTarget:self.delegate action:@selector(noDataViewAddBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImageView* addImageView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"NoDataViewAddBtn"]];
    addImageView.center=CGPointMake(addBtn.frame.size.width*.5, addBtn.frame.size.height-18);
    [addBtn addSubview:addImageView];
    
    return addBtn;
}
@end
