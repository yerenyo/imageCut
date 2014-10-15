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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) ALImageCutManager *imageCutManager;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageCutManager = [[ALImageCutManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
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



#pragma mark - tableview data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 35)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    iconImageView.center = CGPointMake((view.bounds.size.width-iconImageView.bounds.size.width)/2.0, (view.bounds.size.height-iconImageView.bounds.size.height)/2.0);
    [view addSubview:iconImageView];
    return view;
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
