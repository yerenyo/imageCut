//
//  ALPlatformCollectionViewCell.m
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ALPlatformCollectionViewCell.h"

@interface ALPlatformCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *cutTypeImageview;
@property (weak, nonatomic) IBOutlet UILabel *cutTypeLable;

@end
@implementation ALPlatformCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.layer.cornerRadius = 2;
    self.contentView.layer.masksToBounds = YES;
}

- (void)setCutObject:(ALCutObject *)cutObject{
    if (_cutObject != cutObject) {
        _cutObject = cutObject;
        self.cutTypeImageview.image = [UIImage imageNamed:cutObject.cutPlatormImageName];
        self.cutTypeLable.text = cutObject.cutPlatormText;
    }
}
@end
