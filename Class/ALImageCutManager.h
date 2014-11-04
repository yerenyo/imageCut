//
//  ALImageCutManager.h
//  imageCut
//
//  Created by GuJinyou on 14-10-11.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALTools.h"

typedef NS_ENUM(NSUInteger, kImageCutStatus){
    kImageCutBegin,
    kImageCutCutSuccess,
    kImageCutSave,
    kImageCutSuccess
};

typedef void(^ImageCutStatusBlock)(kImageCutStatus status, NSInteger allCount, NSInteger currentIndex);

@interface ALImageCutManager : NSObject
//默认是YES
@property(nonatomic, assign) BOOL enableSaveToAlbum;
@property(nonatomic, copy) ImageCutStatusBlock progressBlcok;
- (void)cut:(UIImage *)image Type:(NSInteger)cutNumber Platform:(kPlatformType)platformType;
@end
