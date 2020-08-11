//
//  TAVHallCollectionViewCellLayout.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallCollectionViewCellLayout.h"



@interface TAVHallCollectionViewCellLayout()
@property (nonatomic, strong) NSMutableArray *attArr;

@property (nonatomic, assign) CGFloat lastestOX;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation TAVHallCollectionViewCellLayout

- (void)prepareLayout {
    [super prepareLayout];

    self.attArr = [NSMutableArray array];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        [self.attArr addObject: [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    
}

-(CGSize)collectionViewContentSize
{
    float height = CenterX(self.collectionView); //(SIZE + self.margin) * ([self.collectionView numberOfItemsInSection:0] / 4 + 1);
    return CGSizeMake(320, _contentHeight);
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat oX = CenterX(self.collectionView);
    CGFloat oY = CenterX(self.collectionView) * 0.5;
    
    
    CGFloat cellHeight = TallCellHeight(self.collectionView);
    // 高度值
    if ((indexPath.item + 6) % 6 == 0 || (indexPath.item + 1) % 6 == 0) {
        oY += (indexPath.item / 3) * cellHeight;
    } else {
        
        oY += (indexPath.item / 3) * cellHeight - (oY * 0.5) * ((indexPath.item % 2) == 0 ? -1 : 1);
        cellHeight = cellHeight * 0.5;
        
    }
    
    if (indexPath.item % 3 == 0) {
        oX *= 0.5;
    } else {
        if ((indexPath.item % 2) == 0) {
            oX = _lastestOX;
        } else {
            oX *= 1.5;
        }
        
    }
    
    attributes.center = CGPointMake(oX, oY);
    attributes.size = CGSizeMake(CellWidth(self.collectionView), cellHeight);
    
    self.lastestOX = oX;
    
    if (oY > _contentHeight) {
        _contentHeight += cellHeight;
    }
    NSLog(@"attributes %@", attributes);
    return attributes;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{

    return _attArr;
}


@end
