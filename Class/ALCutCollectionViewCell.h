//
//  ALCutCollectionViewCell.h
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *keyPlatform;
extern NSString *keyCutType;

@interface ALCutCollectionViewCell : UICollectionViewCell
//@{keyPlatform:平台类型, keyCutType:切图类型}
@property(nonatomic, strong) NSDictionary *cutDataDictionary;

@end
