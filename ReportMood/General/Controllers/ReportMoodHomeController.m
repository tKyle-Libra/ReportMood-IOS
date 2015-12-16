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
#import <JFImagePicker/JFImagePickerController.h>
#import "UtilsMacro.h"
#import "ReportMoodThumbImageSection.h"

@interface ReportMoodHomeController() <UIGestureRecognizerDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,JFImagePickerDelegate>

@property (strong,nonatomic) UIView *reportView;

@property (strong,nonatomic) UITextView *reportMoodTextView;

@property (strong,nonatomic) JFImagePickerController *imgPickerController;

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

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    _thumbImageView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, 250, 350) collectionViewLayout:flowLayout];
    _thumbImageView.delegate = self;
    [_thumbImageView registerClass:[ReportMoodThumbImageSection class] forCellWithReuseIdentifier:ThumbImageCellIdentifier];
    _thumbImageView.dataSource = self;
    _thumbImageView.backgroundColor = [UIColor whiteColor];
    [_reportView addSubview:_thumbImageView];
    
#if DEBUG
    [self WireFrameModel];
#endif
    self.tableView.tableHeaderView = _reportView ;
    [self InitConstraint];
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
    
    _thumbImageView.layer.borderColor = [UIColor blueColor].CGColor;
    _thumbImageView.layer.borderWidth = 2;
}

#endif


-(void) InitConstraint
{
    [_reportMoodTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_reportView.mas_top).offset(Padding);
        make.left.mas_equalTo(_reportView.mas_left).offset(Padding);
        make.right.mas_equalTo(_reportView.mas_right).offset(-Padding);
        make.bottom.mas_equalTo(_thumbImageView.mas_top).offset(-Padding);
        
        CGFloat width = _reportView.frame.size.width - 2*Padding;
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(DefaultWH);
    }];
    
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_reportView.mas_top).offset(Padding);
        make.left.mas_equalTo(_reportView.mas_left).offset(Padding);
        make.right.mas_equalTo(_reportView.mas_right).offset(-Padding);
        make.bottom.mas_equalTo(_reportMoodTextView.mas_top).offset(-(DefaultWH-PlaceHoliderHigh));
        
        make.width.mas_equalTo(_reportMoodTextView.mas_width);
        make.height.mas_equalTo(PlaceHoliderHigh);
    }];
    
    [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_reportMoodTextView.mas_bottom).offset(DefaultZero);
        make.left.mas_equalTo(_reportView.mas_left).offset(Padding);
        make.right.mas_equalTo(_reportView.mas_right).offset(-Padding);
        make.bottom.mas_equalTo(_reportView.mas_bottom).offset(-Padding);
        
        make.width.mas_equalTo(DefaultWH);
        make.height.mas_equalTo(DefaultWH);
    }];
    
    [_reportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.tableView).offset(DefaultZero);
        make.bottom.mas_equalTo(self.tableView.tableHeaderView.mas_bottom).offset(DefaultZero);
        make.width.mas_equalTo(self.tableView.mas_width);
        CGFloat totalHeigh = DefaultNumber;
        totalHeigh += DefaultWH;
        NSInteger number = [_thumbImageView numberOfSections]/4;
        number = number ? number:DefaultNumber;
        totalHeigh += number * ThumbImageCellHeigh;
        totalHeigh += DefaultInterval;
        make.height.mas_equalTo(totalHeigh);
    }];
}

-(void) UpdateConstraint
{
    [_thumbImageView mas_updateConstraints:^(MASConstraintMaker *make)
    {
        NSInteger number = [_imgChoseArray count];
 
        NSInteger heigh = ([self CollectionViewCellWithRowNumber] * ThumbImageCellHeigh) + (number * DefaultEdgeInsets);
        make.height.mas_equalTo(heigh);
    }];
    
    [_reportView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat totalHeigh = DefaultNumber;
        totalHeigh += DefaultWH;
        totalHeigh += ([self CollectionViewCellWithRowNumber] * ThumbImageCellHeigh);
        totalHeigh += DefaultInterval;
        make.height.mas_equalTo(totalHeigh);
    }];
}

-(NSInteger) CollectionViewCellWithRowNumber
{
    NSInteger number = [_imgChoseArray count];
    if (number < MaxImageCount)
    {
        number += DefaultNumber;
    }
    NSInteger remainder = number%ThumbImageCellDividend;
    NSInteger rowNumber = number/ThumbImageCellDividend;
    return (rowNumber ? rowNumber :DefaultNumber) + (remainder ? DefaultNumber : DefaultZero);
}

-(JFImagePickerController *) imgPickerController
{
    if (!_imgPickerController)
    {
        _imgPickerController = [[JFImagePickerController alloc] initWithRootViewController:self.navigationController];
        _imgPickerController.pickerDelegate = self;
    }
    return _imgPickerController;
}

-(void) KeyBoardDisMiss:(UITapGestureRecognizer *)obj
{
    [self.reportMoodTextView resignFirstResponder];
}

#pragma mark UICollectionView DataSource or Delegate 


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [_imgChoseArray count];
    if (count == MinImageCount)
    {
        return DefaultNumber;
    }
    else if (count < MaxImageCount)
    {
        return count + DefaultNumber;
    }
    else
    {
        return  count;
    }
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return DefaultNumber;;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReportMoodThumbImageSection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThumbImageCellIdentifier forIndexPath:indexPath];;
    NSInteger number = [_imgChoseArray count];
    if (number == MinImageCount)
    {
        [cell AddOpenImagePickerControllerAction:^(UIButton *btn) {
            [btn addTarget:self action:@selector(OpenImagePickerController) forControlEvents:UIControlEventTouchUpInside];
        }];
    }else
    {
        if (indexPath.row < number)
        {
            UIImage *image = [_imgChoseArray objectAtIndex:indexPath.row];
            UIImageView *thumbImgView = [[UIImageView alloc] initWithImage:image];
            cell.thumbImge = thumbImgView;
        }else if(indexPath.row != MaxImageCount)
        {
            [cell AddOpenImagePickerControllerAction:^(UIButton *btn) {
                [btn addTarget:self action:@selector(OpenImagePickerController) forControlEvents:UIControlEventTouchUpInside];
            }];
        }
    }
    
    return cell;
}

-(void) OpenImagePickerController
{
    [self presentViewController:self.imgPickerController animated:YES completion:nil];
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(DefaultThumbImageHW,DefaultThumbImageHW);
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DefaultEdgeInsets, DefaultEdgeInsets, DefaultEdgeInsets, DefaultEdgeInsets);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

#pragma mark JFImagePickerController Delegate

-(void) imagePickerDidFinished:(JFImagePickerController *)picker
{
    NSArray *photoImageArray = [picker imagesWithType:MinImageCount];
    if ([_imgChoseArray count] != MinImageCount)
    {
       [_imgChoseArray removeAllObjects];
        _imgChoseArray = nil;
        [_thumbImageView reloadData];
    }
     _imgChoseArray = (NSMutableArray *)photoImageArray;
    
    [picker dismissViewControllerAnimated:YES completion:^
    {
        [_thumbImageView reloadData];
        [self UpdateConstraint];
    }];
}

-(void) imagePickerDidCancel:(JFImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

-(void) textViewDidBeginEditing:(UITextView *)textView
{
    _placeHolderLabel.hidden = YES;
}

-(void) textViewDidEndEditing:(UITextView *)textView
{
    if ([_reportMoodTextView.text length] == 0)
    {
        _placeHolderLabel.hidden = NO;
    }
}

@end
