//
//  ALCutCollectionViewCell.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTools.h"

extern NSString *keyPlatform;
extern NSString *keyCutType;
extern NSString *keyPlatformLogo;

@interface ALCutCollectionViewCell : UICollectionViewCell
//@{keyPlatform:平台类型, keyCutType:切图类型}
@property(nonatomic, strong) NSDictionary *cutDataDictionary;
@property(nonatomic, copy) void(^SelectCellBlock)(kImageCutType cutType, kPlatformType platformType);
@end
