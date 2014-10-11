//
//  ViewController.m
//  imageCut
//
//  Created by GuJinyou on 14-10-10.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

typedef enum{
    kImageCutNine=9,
    kImageCutSix=6,
    kImageCutFour=4,
    kImageCutThree=3,
    kImageCutTwo=2
}kImageCutType;

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) NSMutableArray *imageList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageList = [NSMutableArray array];
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

- (void)cutImage:(UIImage *)image Type:(kImageCutType)type{
    NSLog(@"\n begin");
    NSInteger row, column;
    if (type%3==0) {
        column = 3;
        row = type/3;
    }else if(type%2==0){
        column = 2;
        row = type/2;
    }
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat spaceWidth = width/column;
    CGFloat spaceHeight = height/row;
    CGFloat x,y;
    NSMutableArray *rects = [NSMutableArray arrayWithCapacity:row*column];
    for (int i=0; i<row; i++) {
        y = i*spaceHeight;
        for (int j=0; j<column; j++) {
            x = j*spaceWidth;
            [rects addObject:[NSValue valueWithCGRect:CGRectMake(-x, -y, spaceWidth, spaceHeight)]];
//            NSLog(@"\nrow:%d column:%d    :%@", i, j ,[NSValue valueWithCGRect:rects[i*j]]);
        }
    }
    [self.imageList removeAllObjects];
    for (int i=0; i<rects.count; i++) {
        CGRect rect = [rects[i] CGRectValue];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        view.clipsToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(rect.origin.x, rect.origin.y, imageView.bounds.size.width, imageView.bounds.size.height);
        [view addSubview:imageView];
        UIImage *image = [self captureView:view];
        [self.imageList addObject:image];
    }
    [self saveNext:self.imageList[0]];
}

-(void) saveNext:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
}

-(void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        //NSLog(@"%@", error.localizedDescription);
    }else {
        [self.imageList removeObjectAtIndex:0];
    }
    if (self.imageList.count>0) {
        [self saveNext:self.imageList[0]];
    }else{
        NSLog(@"\nover");
    }

}

-(UIImage*)captureView:(UIView *)theView{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, theView.bounds);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
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
        [self cutImage:img Type:9];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
