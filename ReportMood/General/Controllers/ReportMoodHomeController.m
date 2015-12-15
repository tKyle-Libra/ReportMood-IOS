//
//  ReportMoodHomeController.m
//  ReportMood
//
//  Created by 乐同 on 15/12/15.
//  Copyright © 2015年 tKyle. All rights reserved.
//

#import "ReportMoodHomeController.h"
#import <Photos/Photos.h>
#import <Masonry/Masonry.h>
#import <AGImagePickerController/AGImagePickerController.h>
#import "UtilsMacro.h"

@interface ReportMoodHomeController() <UIGestureRecognizerDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) UIView *reportView;

@property (strong,nonatomic) UITextView *reportMoodTextView;

@property (strong,nonatomic) AGImagePickerController *imgPickerController;

@property (strong,nonatomic) UILabel *placeHolderLabel;

@property (strong,nonatomic) UIButton *addPictureButton;

@property (strong,nonatomic) NSMutableArray *imgChoseArray;

@property (strong,nonatomic) UICollectionView *thumbImageView;
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

    _reportView = [[UIView alloc] init];
    
    _reportMoodTextView = [[UITextView alloc] init];
    _reportMoodTextView.returnKeyType = UIReturnKeyDone;
    _reportMoodTextView.font = [UIFont systemFontOfSize:15];
    _reportMoodTextView.delegate = self;
    [_reportView addSubview:_reportMoodTextView];
    
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = PlaceHolder;
    _placeHolderLabel.font = [UIFont systemFontOfSize:15];
    _placeHolderLabel.textColor = [UIColor grayColor];
    [_reportView addSubview:_placeHolderLabel];
    
    _thumbImageView = [[UICollectionView alloc] init];
    _thumbImageView.delegate = self;
    _thumbImageView.dataSource = self;
#if 0
    NSInteger count = [_imgChoseArray count];
    if(count < MaxImageCount)
    {
        _addPictureButton = [[UIButton alloc] init];
        [_addPictureButton addTarget:self action:@selector(AddPictures:) forControlEvents:UIControlEventTouchUpInside];
        [_reportView addSubview:_addPictureButton];
    }
    for(int i = 0; i < count; i++)
    {
        UIImageView *thumbImageView = [[UIImageView alloc] init];
        thumbImageView.image = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)((PHAsset *)[_imgChoseArray objectAtIndex:i])];
        [_reportView addSubview:thumbImageView];
    }
#endif
    
#if DEBUG
    [self WireFrameModel];
#endif
    [self InitConstraint];
    self.tableView.tableHeaderView = _reportView;
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
    [_reportMoodTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(_reportView).offset(Padding);
        make.right.mas_equalTo(_reportView.mas_right).offset(-Padding);
        make.height.mas_equalTo(MoodTextViewHeigh);
    }];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    //添加或更新 addPictureBtn 和 thumbImageViewArray 约束
    NSInteger count = [_imgChoseArray count];
    if (count < MaxImageCount)
    {
        
    }
    [self AddThumbImageViewConstraint];
}

-(void) AddThumbImageViewConstraint
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

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
#if 0
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImage"];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.imagePickerArray;
    [self.navigationController pushViewController:vc animated:YES];
#endif
}

-(void) AddPictures:(id)sender
{

}

#pragma mark UICollectionView DataSource or Delegate 

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [_imgChoseArray count];
    if (count == MinImageCount)
    {
        return DefaultNumber;
    }
    return count + DefaultNumber;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return DefaultNumber;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(0,0);
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}



@end
