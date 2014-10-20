//
//  ALCutCollectionViewCell.m
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ALCutCollectionViewCell.h"
#import "ALPlatformCollectionViewCell.h"
const NSString *keyPlatform = @"platform";
const NSString *keyCutType = @"cutType";
const NSString *keyPlatformLogo = @"PlatformLogo";

@interface ALCutCollectionViewCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cellectionView;
@property (weak, nonatomic) IBOutlet UIImageView *platformImageView;
@property (weak, nonatomic) IBOutlet UILabel *platformLable;

@end

@implementation ALCutCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.cellectionView registerClass:[ALPlatformCollectionViewCell class] forCellWithReuseIdentifier:@"ALPlatformCollectionViewCell"];
    self.cellectionView.dataSource = self;
    self.cellectionView.delegate = self;
    
}

- (void)setCutDataDictionary:(NSDictionary *)cutDataDictionary{
    if (_cutDataDictionary != cutDataDictionary) {
        
    }
}
#pragma mark = datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *cutTypes = self.cutDataDictionary[keyCutType];
    return cutTypes.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ALPlatformCollectionViewCell";
    ALPlatformCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSArray *cutTypes = self.cutDataDictionary[keyCutType];
    NSArray *platformTypes = self.cutDataDictionary[keyPlatform];
    [cell platfom:(kPlatformType)[platformTypes[indexPath.row] integerValue] cutType:(kImageCutType)[cutTypes[indexPath.row] integerValue]];
    return cell;
}

#pragma mark = delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.SelectCellBlock) {
        NSArray *cutTypes = self.cutDataDictionary[keyCutType];
        NSArray *platformTypes = self.cutDataDictionary[keyPlatform];
        self.SelectCellBlock((kImageCutType)[cutTypes[indexPath.row] integerValue], (kPlatformType)[platformTypes[indexPath.row] integerValue]);
    }
}


@end
