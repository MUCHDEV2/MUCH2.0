//
//  FavoritesTableViewCell.m
//  MUCH
//
//  Created by 汪洋 on 14/11/26.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "FavoritesTableViewCell.h"

@implementation FavoritesTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _timeFormatter = [[NSDateFormatter alloc] init];
        _timeFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]];
        _timeFormatter.timeStyle = NSDateFormatterShortStyle;
        _timeFormatter.doesRelativeDateFormatting = YES;
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]];
        _dateFormatter.dateStyle = NSDateFormatterShortStyle;
        _dateFormatter.doesRelativeDateFormatting = YES;
        
        [self addContent];
    }
    return self;
}


-(void)addContent{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 150)];
    bgImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bgImageView];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(278, 21, 32, 32)];
    imageview.image = [GetImagePath getImagePath:@"clock"];
    [self.contentView addSubview:imageview];
    
    _hours = [[UIView alloc] initWithFrame:CGRectMake(292.5, 32.5, 1, 7)];
    _hours.layer.anchorPoint = CGPointMake(0.5f, 1.0/11.0f);
    _hours.layer.cornerRadius = 1.0;
    _hours.layer.shouldRasterize = YES;
    _hours.layer.contentsScale = [[UIScreen mainScreen] scale];
    _hours.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_hours];
    
    _minutes = [[UIView alloc] initWithFrame:CGRectMake(292, 31, 1, 10)];
    _minutes.layer.anchorPoint = CGPointMake(0.5f, 1.0/13.0f);
    _minutes.layer.cornerRadius = 1.0;
    _minutes.layer.shouldRasterize = YES;
    _minutes.layer.contentsScale = [[UIScreen mainScreen] scale];
    _minutes.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_minutes];
    
    
    distanceImage = [[UIImageView alloc] initWithFrame:CGRectMake(11, 21, 48, 48)];
    [distanceImage setImage:[GetImagePath getImagePath:@"distance_icon_green"]];
    [self.contentView addSubview:distanceImage];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    distanceLabel.font = [UIFont systemFontOfSize:12];
    distanceLabel.text = @"200m";
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.textColor = [UIColor whiteColor];
    [distanceImage addSubview:distanceLabel];
    
    priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(11, 79, 48, 48)];
    [priceImage setImage:[GetImagePath getImagePath:@"price_icon_red"]];
    [self.contentView addSubview:priceImage];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.text = @"¥299";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    [priceImage addSubview:priceLabel];
    
    statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 318, 150)];
    statusImageView.backgroundColor = [UIColor whiteColor];
    statusImageView.alpha = 0;
    [self.contentView addSubview:statusImageView];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 20, 180, 30)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:timeLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(293, 60, 1, 80)];
    [lineImage setImage:[GetImagePath getImagePath:@"distance"]];
    [self.contentView addSubview:lineImage];
    
    UILongPressGestureRecognizer *closePress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(closeLong:)];
    closePress.minimumPressDuration = 0.8; //定义按的时间
    [self addGestureRecognizer:closePress];
    
}

-(void)setModel:(ListModel *)model{
    NSLog(@"%@",model.created);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSArray *arr = [model.created componentsSeparatedByString:@"."];
    NSArray *arr2 = [arr[0] componentsSeparatedByString:@"T"];
    NSString *str = [NSString stringWithFormat:@"%@ %@",arr2[0],arr2[1]];
    NSDate *tableDate = [dateFormatter dateFromString:str];
    NSLog(@"%@",[tableDate dateByAddingTimeInterval:8*60*60]);
    // Update date
    NSDate *date = [tableDate dateByAddingTimeInterval:8*60*60];
    if (!date || [date isEqualToDate:_lastDate]){
        return;
    }
    if (!_lastDate) {
        _lastDate = [NSDate date];
    }
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
    
    CGFloat minuteHourAngle = 180.0f + dateComponents.minute * 6.0f;
    CGFloat dateHourAngle = 180.0f + 0.5 * (dateComponents.hour * 60.0f);
    
    [UIView animateWithDuration:0.2f delay:0.0f options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowAnimatedContent)  animations:^{
        // Animate clock rotation
        _hours.transform = CGAffineTransformMakeRotation(dateHourAngle * (M_PI / 180.0f));
        _minutes.transform = CGAffineTransformMakeRotation(minuteHourAngle * (M_PI / 180.0f));
        self.layer.mask.frame = self.bounds;
    } completion:^(BOOL finished){
    
    }];
    
    _lastDate = date;
    
    NSString *str2 = [[dateFormatter stringFromDate:date] substringWithRange:NSMakeRange(0,[dateFormatter stringFromDate:date].length-3)];
    timeLabel.text = [NSString stringWithFormat:@"%@",str2];
    
    
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片裁剪
        UIImage *srcimg = image;
        CGRect rect =  CGRectMake(0, 170, 640, 300);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
        CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
        bgImageView.image = [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    }];
    
    distanceLabel.text = model.distance_str;
    priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    
    
    if([model.is_closed isEqualToString:@"0"]){
        statusImageView.alpha = 0;
        if([model.compare isEqualToString:@"2"]){
            [distanceImage setImage:[GetImagePath getImagePath:@"distance_icon_green"]];
        }else if ([model.compare isEqualToString:@"5"]){
            [distanceImage setImage:[GetImagePath getImagePath:@"distance_5km"]];
        }else if([model.compare isEqualToString:@"all"]){
            [distanceImage setImage:[GetImagePath getImagePath:@"distance_all"]];
        }
        [priceImage setImage:[GetImagePath getImagePath:@"price_icon_red"]];
    }else{
        statusImageView.alpha = 0.3;
        [distanceImage setImage:[GetImagePath getImagePath:@"closed_icon_grey"]];
        [priceImage setImage:[GetImagePath getImagePath:@"closed_icon_grey"]];
    }
}

-(void)setIndexrow:(int)indexrow{
    _indexrow = indexrow;
}

-(void)closeLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        [self.delegate showAlertView:self.indexrow];
    }
}
@end
