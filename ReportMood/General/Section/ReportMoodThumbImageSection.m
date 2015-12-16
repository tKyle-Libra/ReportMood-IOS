//
//  ReportMoodThumbImageSection.m
//  ReportMood
//
//  Created by 同乐 on 15/12/16.
//  Copyright © 2015年 tKyle. All rights reserved.
//

#import "ReportMoodThumbImageSection.h"
#import <Masonry/Masonry.h>
#import "UtilsMacro.h"

@implementation ReportMoodThumbImageSection

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return  self;
}

-(void) AddOpenImagePickerControllerAction:(void(^)(UIButton *))block
{
    if (!_imagePickerController)
    {
        _imagePickerController = [[UIButton alloc] init];
        _imagePickerController.backgroundColor = [UIColor redColor];
        [self InitConstraints:_imagePickerController];
    }
    block(_imagePickerController);
}

-(void) setThumbImge:(UIImageView *)thumbImge
{
    _thumbImge = thumbImge;
    [self InitConstraints:_thumbImge];
}

-(void) InitConstraints:(id)obj
{
    [self addSubview:obj];
    [obj mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(self.mas_left).offset(DefaultZero);
        make.right.mas_equalTo(self.mas_right).offset(DefaultZero);
        make.top.mas_equalTo(self.mas_top).offset(DefaultZero);
        make.bottom.mas_equalTo(self.mas_bottom).offset(DefaultZero);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
    }];
}

@end
