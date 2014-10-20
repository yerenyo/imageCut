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

@interface ALCutCollectionViewCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cellectionView;
@property (weak, nonatomic) IBOutlet UIImageView *platformImageView;
@property (weak, nonatomic) IBOutlet UILabel *platformLable;

@end

@implementation ALCutCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.cellectionView registerNib:[UINib nibWithNibName:@"ALPlatformCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ALPlatformCollectionViewCell"];
    self.cellectionView.dataSource = self;
    self.cellectionView.delegate = self;
    
}

- (void)setCutDataDictionary:(NSDictionary *)cutDataDictionary{
    if (_cutDataDictionary != cutDataDictionary) {
        _cutDataDictionary = cutDataDictionary;
        NSInteger platform = [_cutDataDictionary[keyPlatform] integerValue];
        self.platformImageView.image = [UIImage imageNamed: kPlatormLogoImageName[platform]];
        self.platformLable.text = kPlatormName[platform];
        [self.cellectionView reloadData];
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
    [cell platfom:(kPlatformType)[self.cutDataDictionary[keyPlatform] integerValue] cutType:(kImageCutType)[cutTypes[indexPath.row] integerValue]];
    return cell;
}

#pragma mark = delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.SelectCellBlock) {
        NSArray *cutTypes = self.cutDataDictionary[keyCutType];
        self.SelectCellBlock((kImageCutType)[cutTypes[indexPath.row] integerValue], (kPlatformType)[self.cutDataDictionary[keyPlatform] integerValue]);
    }
}


@end
