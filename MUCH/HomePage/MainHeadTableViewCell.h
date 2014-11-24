//
//  MainHeadTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/21.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainHeadTableViewCellDelegate <NSObject>
-(void)gotofiltrate;
-(void)gotoList;
-(void)addPhoto;
@end
@interface MainHeadTableViewCell : UITableViewCell{
    UIButton *filtrateBtn;
    UIButton *toListBtn;
    UIButton *addPhotoBtn;
}
@property(nonatomic,weak)id<MainHeadTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index;
@end
