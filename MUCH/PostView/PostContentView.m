//
//  PostContentView.m
//  MUCH
//
//  Created by 汪洋 on 15/2/13.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import "PostContentView.h"

@implementation PostContentView

+(PostContentView *)setFram:(NSMutableArray *)imgArr{
    PostContentView *postcontent = [[PostContentView alloc] init];
    [postcontent setBackgroundColor:[UIColor clearColor]];
    int imgcount = imgArr.count;
    if(imgcount%3==0){
        [postcontent setFrame:CGRectMake(35, 15, 95*3, 105*(imgcount/3)+22.5)];
    }else{
        [postcontent setFrame:CGRectMake(35, 15, 95*3, 105*(imgcount/3)+127.5)];
    }
    //NSLog(@"%d",imgcount);
    for(int i=0;i<imgcount;i++){
        int row = i/3;
        int line = i%3;
        UIImageView *bgImage = [[UIImageView alloc] init];
        [bgImage setBackgroundColor:[UIColor whiteColor]];
        [bgImage setFrame:CGRectMake(line*(90+5), row*(105+5), 90, 90)];
        UIImageView *contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 90-4, 90-4)];
        [contentImage sd_setImageWithURL:[NSURL URLWithString:imgArr[i][@"content"]] placeholderImage:nil];
        [bgImage addSubview:contentImage];
        [postcontent addSubview:bgImage];
        
        UILabel *pricelabel = [[UILabel alloc] init];
        [pricelabel setFrame:CGRectMake(line*(90+5), row*(105+5)+88, 90, 30)];
        pricelabel.text = [NSString stringWithFormat:@"￥ %@",imgArr[i][@"title"]];
        pricelabel.font = [UIFont systemFontOfSize:14];
        pricelabel.textColor = RGBCOLOR(20, 118, 243);
        [postcontent addSubview:pricelabel];
    }
    return postcontent;
}

@end
