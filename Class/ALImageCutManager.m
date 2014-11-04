//
//  ALImageCutManager.m
//  imageCut
//
//  Created by GuJinyou on 14-10-11.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ALImageCutManager.h"
@interface ALImageCutManager()
@property(nonatomic, strong) NSMutableArray *imageList;
@property(nonatomic, assign) NSInteger cutNumber;
@end

@implementation ALImageCutManager
- (instancetype)init{
    self = [super init];
    if (self) {
        self.enableSaveToAlbum = YES;
        self.imageList = [NSMutableArray array];
    }
    return self;
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

-(void) saveNext:(UIImage *)image{
    if (self.progressBlcok) {
        self.progressBlcok(kImageCutSave, self.cutNumber, self.cutNumber-self.imageList.count);
    }
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
        if (self.progressBlcok) {
            self.progressBlcok(kImageCutSuccess, self.cutNumber, self.cutNumber-self.imageList.count);
        }
        NSLog(@"\nover");
    }
}

- (void)cut:(UIImage *)image Type:(NSInteger)cutNumber Platform:(kPlatformType)platformType{
    switch (platformType) {
        case kPlatformWeixin:
        case kPlatformWeibo:{
            
            [self cut3Column:image with:cutNumber];
        }break;
        case kPlatformMomo:{
            [self cut4Column:image with:cutNumber];
        }break;
        default:
            break;
    }
}

- (void)cutImage:(UIImage *)image Row:(NSInteger)row Colume:(NSInteger)column{
    self.cutNumber = row*column;
    if (self.progressBlcok) {
        self.progressBlcok(kImageCutBegin, row*column, 0);
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
            //           NSLog(@"\nrow:%d column:%d    :%@", i, j ,[NSValue valueWithCGRect:rects[i*j]]);
        }
    }
    [self.imageList removeAllObjects];
    NSLog(@"\nimage cut begin");
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
    if (self.progressBlcok) {
        self.progressBlcok(kImageCutCutSuccess, row*column, 0);
    }
    NSLog(@"\nimage cut end");
    if(self.enableSaveToAlbum){
        [self saveNext:self.imageList[0]];
    }
}

- (void)cut4Column:(UIImage *)image with:(NSInteger)cutNumber{
    NSLog(@"\n begin");
    NSInteger column = 4;
    NSInteger row = cutNumber/column;
    [self cutImage:image Row:row Colume:column];
}

- (void)cut3Column:(UIImage *)image with:(NSInteger)cutNumber{
    NSLog(@"\n begin");
    NSInteger row, column;
    if (cutNumber%3==0) {
        column = 3;
        row = cutNumber/3;
    }else if(cutNumber%2==0){
        column = 2;
        row = cutNumber/2;
    }
    [self cutImage:image Row:row Colume:column];
}

@end
