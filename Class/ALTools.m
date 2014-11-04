//
//  ALTools.m
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ALTools.h"
#define kPlatormLogoImageName @[@"Wechat", @"Momo", @"Weibo"]
#define kPlatormName @[@"朋友圈", @"陌陌相册", @"微博"]
#define kCutPlatormImage @[@[@"w-9",@"w-6",@"w-3",@"w-4",@"w-2"],@[@"m-8",@"m-4"],@[@"wb-9",@"wb-6",@"wb-3",@"wb-4",@"wb-2"]]
#define kCutPlatormText @[@[@"3×3张",@"3×2张",@"3×1张",@"2×2张",@"2×1张"],@[@"4×2张",@"4×1张"],@[@"3×3张",@"3×2张",@"3×1张",@"2×2张",@"2×1张"]]

#define kCutNumber @[@[@"9",@"6",@"3",@"4",@"2"],@[@"8",@"4"],@[@"9",@"6",@"3",@"4",@"2"]]

#define kPlatormCutTypes @[@[@(kImageCutNine),@(kImageCutSix),@(kImageCutThree),@(kImageCutFour),@(kImageCutTwo)],@[@(kImageCutEight),@(kImageCutFour)],@[@(kImageCutNine),@(kImageCutSix),@(kImageCutThree),@(kImageCutFour),@(kImageCutTwo)]]
#define kPlatormBGColors @[kColorFromRGB(78, 223, 87), kColorFromRGB(93, 160, 225),kColorFromRGB(252, 96, 114)]

@implementation ALCutObject



@end

@implementation ALPlatormObject


@end

@implementation ALTools

+ (NSArray *)platormsCreate{
    NSMutableArray *platorms = [NSMutableArray arrayWithCapacity:3];
    for (int i=0; i<kPlatormLogoImageName.count; i++) {
        ALPlatormObject *platorm = [[ALPlatormObject alloc] init];
        platorm.platormName = kPlatormName[i];
        platorm.platformType = (kPlatformType)i;
        platorm.platormLogoImageName = kPlatormLogoImageName[i];
        platorm.bgColor = kPlatormBGColors[i];
        NSMutableArray *cuts = [NSMutableArray arrayWithCapacity:6];
        NSArray *cutImages = kCutPlatormImage[i];
        NSArray *cutTexts = kCutPlatormText[i];
        NSArray *cutTypes = kPlatormCutTypes[i];
        NSArray *cutsNumbers = kCutNumber[i];
        for (int j=0; j<cutsNumbers.count; j++) {
            ALCutObject *cut = [[ALCutObject alloc] init];
            cut.cutNumber = [cutsNumbers[j] integerValue];
            cut.cutPlatormImageName = cutImages[j];
            cut.cutPlatormText = cutTexts[j];
            cut.cutType = (kImageCutType)[cutTypes[j] integerValue];
            [cuts addObject:cut];
        }
        platorm.cutObjects = [NSArray arrayWithArray:cuts];
        [platorms addObject:platorm];
    }
    return [NSArray arrayWithArray:platorms];
}
@end
