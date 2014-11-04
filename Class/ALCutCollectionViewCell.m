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
    self.layer.cornerRadius = 16.0;
    self.layer.masksToBounds = YES;
    [self.cellectionView registerNib:[UINib nibWithNibName:@"ALPlatformCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ALPlatformCollectionViewCell"];
    self.cellectionView.dataSource = self;
    self.cellectionView.delegate = self;
}

- (void)setPlatormObject:(ALPlatormObject *)platormObject{
    if (_platormObject != platormObject) {
        _platormObject = platormObject;
        self.backgroundColor = platormObject.bgColor;
        self.platformImageView.image = [UIImage imageNamed:platormObject.platormLogoImageName];
        self.platformLable.text = platormObject.platormName;
        [self.cellectionView reloadData];
    }
}

- (void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.cellectionView.collectionViewLayout;
    if (flowLayout && [flowLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        flowLayout.itemSize = itemSize;
    }
}
#pragma mark = datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.platormObject.cutObjects.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"ALPlatformCollectionViewCell";
    ALPlatformCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.cutObject = self.platormObject.cutObjects[indexPath.row];
    cell.lineHidden = indexPath.row == 0;
    return cell;
}

#pragma mark = delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.SelectCellBlock) {
        self.SelectCellBlock(self.platormObject, self.platormObject.cutObjects[indexPath.row]);
    }
}


@end
