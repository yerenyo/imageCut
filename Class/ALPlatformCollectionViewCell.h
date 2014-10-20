//
//  ALPlatformCollectionViewCell.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTools.h"

@interface ALPlatformCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign, readonly)kImageCutType cutType;
@property(nonatomic, assign, readonly)kPlatformType platformType;

- (void)platfom:(kPlatformType)type cutType:(kImageCutType)cutType;
@end
