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
    kImageCutEight,
    kImageCutSix,
    kImageCutFour,
    kImageCutThree,
    kImageCutTwo
}kImageCutType;

typedef enum{
    kPlatformWeixin=0,
    kPlatformMomo,
    kPlatformWeibo,
}kPlatformType;


#define kPlatormLogoImageName @[@"Wechat", @"Momo", @"Weibo"]
#define kPlatormName @[@"朋友圈", @"陌陌相册", @"微博"]
#define kCutPlatormImage @[@[@"w-9",@"w-6",@"w-4",@"w-3",@"w-2"],@[@"m-8",@"m-4"],@[@"w-9",@"w-6",@"w-4",@"w-3",@"w-2"]]
#define kCutPlatormText @[@[@"3×3张",@"3×2张",@"2×2张",@"3×1张",@"2×1张"],@[@"4×2张",@"4×1张"],@[@"3×3张",@"3×2张",@"2×2张",@"3×1张",@"2×1张"]]

#define kCutNumber @[@[@"9",@"6",@"4",@"3",@"2"],@[@"8",@"4"],@[@"9",@"6",@"4",@"3",@"2"]]

#define kPlatormCutTypes @[@[@(kImageCutNine),@(kImageCutSix),@(kImageCutFour),@(kImageCutThree),@(kImageCutTwo)],@[@(kImageCutEight),@(kImageCutFour)],@[@(0),@(kImageCutSix),@(kImageCutFour),@(kImageCutThree),@(kImageCutTwo)]]

@interface ALTools : NSObject

@end
