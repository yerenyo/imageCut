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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) ALImageCutManager *imageCutManager;
@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.collectionView registerClass:[ALCutCollectionViewCell class] forCellWithReuseIdentifier:@"ALCutCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ALCutCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ALCutCollectionViewCell"];
    self.imageCutManager = [[ALImageCutManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [ALTools platormsCreate];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ALCutCollectionViewCell";
    ALCutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.platormObject = self.dataArray[indexPath.row];
    [cell setSelectCellBlock:^(ALPlatormObject *platormObject, ALCutObject *cutObject) {
        
    }];
    return cell;
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
        [self.imageCutManager cut:image with:kImageCutNine];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
