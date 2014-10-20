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

- (void)platfom:(kPlatformType)type cutType:(kImageCutType)cutType{
    _platformType = type;
    _cutType = cutType;
    NSArray *cutNumbers = kCutNumber[type];
//    NSInteger index = [cutNumbers indexOfObject:@(9)];
    self.cutTypeImageview.image = [UIImage imageNamed:kCutPlatormImage[type][0]];
    self.cutTypeLable.text = kCutPlatormText[type][0];
}

@end
