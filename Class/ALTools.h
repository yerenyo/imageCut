//
//  ALTools.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    kImageCutNine=9,
    kImageCutSix=6,
    kImageCutFour=4,
    kImageCutThree=3,
    kImageCutTwo=2
}kImageCutType;

typedef enum{
    kPlatformWeixin=0,
    kPlatformWeibo,
    kPlatformMomo,
}kPlatformType;

@interface ALTools : NSObject

@end
