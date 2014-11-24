//
//  MainListHeadTableViewCell.h
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainListHeadTableViewCellDelegate <NSObject>
-(void)gotofiltrate;
-(void)gotoList;
-(void)addPhoto;
@end
@interface MainListHeadTableViewCell : UITableViewCell{
    UIButton *filtrateBtn;
    UIButton *toListBtn;
    UIButton *addPhotoBtn;
}
@property(nonatomic,weak)id<MainListHeadTableViewCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(int)index;
@end
