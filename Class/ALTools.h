//
//  ALTools.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    kImageCutNine=0,
    kImageCutSix,
    kImageCutFour,
    kImageCutThree,
    kImageCutTwo
}kImageCutType;

typedef enum{
    kPlatformWeixin=0,
    kPlatformWeibo,
    kPlatformMomo,
}kPlatformType;


#define kPlatormLogoImageName @[@"", @"", @""]
#define kCutPlatormImage @[@[@"",@""],@[@"",@""],@[@"",@""]]
#define kCutPlatormText @[@[@"",@""],@[@"",@""],@[@"",@""]]
#define kCutNumber @[@"9", @"6", @"4", @"3", @"2"]
#define kPlatormCutTypes @[@[@(kImageCutNine),@(kImageCutSix),@(kImageCutFour),@(kImageCutThree),@(kImageCutTwo)],@[@(kImageCutNine),@(kImageCutSix),@(kImageCutFour),@(kImageCutThree),@(kImageCutTwo)],@[@(kImageCutNine),@(kImageCutSix),@(kImageCutFour),@(kImageCutThree),@(kImageCutTwo)]]

@interface ALTools : NSObject

@end
