//
//  DetailContentTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/24.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "DetailContentTableViewCell.h"

@implementation DetailContentTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(195, 195, 195);
        [self addContent];
    }
    return self;
}

-(void)addContent{
    UIImageView *bgHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
}
@end
