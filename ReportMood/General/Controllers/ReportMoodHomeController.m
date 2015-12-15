//
//  ReportMoodHomeController.m
//  ReportMood
//
//  Created by 乐同 on 15/12/15.
//  Copyright © 2015年 tKyle. All rights reserved.
//

#import "ReportMoodHomeController.h"
#import <Masonry/Masonry.h>
#import <AGImagePickerController/AGImagePickerController.h>
#import "UtilsMacro.h"

@interface ReportMoodHomeController() <UIGestureRecognizerDelegate,UITextViewDelegate>

@property (strong,nonatomic) UIView *reportView;

@property (strong,nonatomic) UITextView *reportMoodTextView;

@property (strong,nonatomic) AGImagePickerController *imgPickerController;

@property (strong,nonatomic) UILabel *placeHolderLabel;

@property (strong,nonatomic) UIButton *addPictureButton;

@property (strong,nonatomic) NSMutableArray *imgChoseArray;

@end

@implementation ReportMoodHomeController

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:6/255.0f green:165/255.0 blue:195/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyBoardDisMiss:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    [self InitControl];
}

-(void) InitControl
{
    /*
        心情回复 RootView
     */
    _reportView = [[UIView alloc] init];
    [_reportView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.width.mas_equalTo(self.tableView.mas_width);
        make.top.left.right.bottom.mas_equalTo(self.tableView.tableHeaderView).offset(0);
    }];
    
    _reportMoodTextView = [[UITextView alloc] init];
    _reportMoodTextView.returnKeyType = UIReturnKeyDone;
    _reportMoodTextView.font = [UIFont systemFontOfSize:15];
    _reportMoodTextView.delegate = self;
    [_reportView addSubview:_reportMoodTextView];
    
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = PLACE_HOLDER;
    _placeHolderLabel.font = [UIFont systemFontOfSize:15];
    _placeHolderLabel.textColor = [UIColor grayColor];
    [_reportView addSubview:_placeHolderLabel];
    
    NSInteger count = [_imgChoseArray count];
    if(count == MIN_IMG_COUNT)
    {
        _addPictureButton = [[UIButton alloc] init];
        [_addPictureButton addTarget:self action:@selector(AddPictures:) forControlEvents:UIControlEventTouchUpInside];
        [_reportView addSubview:_addPictureButton];
    }
    else if(count > MIN_IMG_COUNT)
    {
        
    }
    
}

#if DEBUG

-(void) WireFrameModel
{
    _reportView.layer.borderColor = [UIColor redColor].CGColor;
    _reportView.layer.borderWidth = 2;
    
    _reportMoodTextView.layer.borderColor = [UIColor yellowColor].CGColor;
    _reportMoodTextView.layer.borderWidth = 2;
    
    _placeHolderLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _placeHolderLabel.layer.borderWidth = 2;
    
    _addPictureButton.layer.borderColor = [UIColor greenColor].CGColor;
    _addPictureButton.layer.borderWidth = 2;
}

#endif

-(void) InitConstraint
{
    
}

-(NSMutableArray *) imgChoseArray
{
    if(!_imgChoseArray)
    {
        _imgChoseArray = [NSMutableArray array];
    }
    return _imgChoseArray;
}

-(void) KeyBoardDisMiss:(UITapGestureRecognizer *)obj
{
    [self.reportMoodTextView resignFirstResponder];
}

-(void) AddPictures:(id)sender
{

}

@end
