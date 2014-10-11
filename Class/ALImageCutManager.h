//
//  ALImageCutManager.h
//  imageCut
//
//  Created by GuJinyou on 14-10-11.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    kImageCutNine=9,
    kImageCutSix=6,
    kImageCutFour=4,
    kImageCutThree=3,
    kImageCutTwo=2
}kImageCutType;

@interface ALImageCutManager : NSObject
@property(nonatomic, assign) BOOL enableSaveToAlbum;//默认是YES
- (void)cut:(UIImage *)image with:(kImageCutType)type;
@end
