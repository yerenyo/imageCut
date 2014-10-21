//
//  ALCutCollectionViewCell.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTools.h"

@interface ALCutCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) ALPlatormObject *platormObject;
@property(nonatomic, copy) void(^SelectCellBlock)(ALPlatormObject *platormObject, ALCutObject *cutObject);
@end
