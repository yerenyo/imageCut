//
//  ALCutCollectionViewCell.m
//  imageCut
//
//  Created by GuJinyou on 14-10-17.
//  Copyright (c) 2014年 Qoocc. All rights reserved.
//

#import "ALCutCollectionViewCell.h"
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
    self.cellectionView.dataSource = self;
    self.cellectionView.delegate = self;
}

#pragma mark = datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark = delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
