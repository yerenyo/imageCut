//
//  ALTools.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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


#define kColorFromRGBA(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kColorFromRgbA(rgb, a)      kColorFromRGBA(rgb, rgb, rgb, a)
#define kColorFromRGB(r, g, b)      kColorFromRGBA(r, g, b, 1.0)


@interface ALCutObject : NSObject
@property(nonatomic, assign) kImageCutType cutType;
@property(nonatomic, strong) NSString *cutPlatormImageName;
@property(nonatomic, strong) NSString *cutPlatormText;
@property(nonatomic, assign) NSUInteger cutNumber;
@end

@interface ALPlatormObject : NSObject
@property(nonatomic, assign) kPlatformType platformType;
@property(nonatomic, strong) NSString *platormLogoImageName;
@property(nonatomic, strong) NSString *platormName;
@property(nonatomic, strong) NSArray *cutObjects;
@property(nonatomic, strong) UIColor *bgColor;
@end


@interface ALTools : NSObject
+ (NSArray *)platormsCreate;
@end
