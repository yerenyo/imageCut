//
//  ViewController.m
//  imageCut
//
//  Created by GuJinyou on 14-10-10.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ALImageCutManager.h"
#import "ALTools.h"
#import "ALCutCollectionViewCell.h"
#import "MBProgressHUD+Utility.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>
@property(nonatomic, strong) ALImageCutManager *imageCutManager;
@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) ALCutObject *selectCutObject;
@property(nonatomic, strong) ALPlatormObject *selectPlatormObject;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ALCutCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ALCutCollectionViewCell"];
    self.imageCutManager = [[ALImageCutManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [ALTools platormsCreate];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.imageCutManager.progressBlcok = ^(kImageCutStatus status, NSInteger allCount, NSInteger currentIndex){
        switch (status) {
            case kImageCutBegin:{
                [MBProgressHUD showLoading:@"分图开始"];
            }break;
            case kImageCutCutSuccess:{
                [MBProgressHUD showLoading:@"分图完成"];
            }break;
            case kImageCutSave:{
                [MBProgressHUD showLoading:[NSString stringWithFormat:@"保存到相册--%ld/%ld", currentIndex, allCount]];
            }break;
            case kImageCutSuccess:{
                [MBProgressHUD showText:@"保存完成"];
            }break;
            default:
                break;
        }
    };
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-16, 200);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
    
}

- (void)onTouch{
    UIImagePickerControllerSourceType type;
    if (/* DISABLES CODE */ (0)) {
        type = UIImagePickerControllerSourceTypeCamera;
    }else{
        type = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = type;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else {
        
    }
}

- (void)actionSelect:(NSUInteger)index{
    UIImagePickerControllerSourceType type;
    if (index==0) {
        type = UIImagePickerControllerSourceTypeCamera;
    }else{
        type = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = type;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ALCutCollectionViewCell";
    ALCutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.platormObject = self.dataArray[indexPath.row];
    if (1==indexPath.row) {
        cell.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-16)/2.0, 150);
    }
    __weak ViewController *weakSelf = self;
    [cell setSelectCellBlock:^(ALPlatormObject *platormObject, ALCutObject *cutObject) {
        weakSelf.selectCutObject = cutObject;
        weakSelf.selectPlatormObject = platormObject;
        UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        [sexSheet showInView:weakSelf.view];
    }];
    return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        case 1:{
            [self actionSelect:buttonIndex];
        }break;
        default:
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        if (img == nil) {
            img = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        UIImage *image = [UIImage imageWithData:imageData scale:1.0];
        [self.imageCutManager cut:image Type:self.selectCutObject.cutNumber Platform:self.selectPlatormObject.platformType];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
