//
//  ReportMoodThumbImageSection.h
//  ReportMood
//
//  Created by 同乐 on 15/12/16.
//  Copyright © 2015年 tKyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportMoodThumbImageSection : UICollectionViewCell

@property (strong,nonatomic) UIImageView *thumbImge;

@property (strong,nonatomic) UIButton *imagePickerController;

-(void) AddOpenImagePickerControllerAction:(void(^)(UIButton *))block;

@end
