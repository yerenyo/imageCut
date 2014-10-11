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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) ALImageCutManager *imageCutManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageCutManager = [[ALImageCutManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onTouch) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:button];
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
