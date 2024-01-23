
//   HTClassHomeMainFlowLayout.m
//  CommonOCProject
//
//  Created by ajie on 2024/1/14.

#import "HTClassHomeMainFlowLayout.h"

static const NSInteger DefaultColumnCpunt = 3;

@interface  HTClassHomeMainFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat lastContentHeight;
@property (nonatomic, assign) CGFloat spacingWithLastSection;
@end

@implementation  HTClassHomeMainFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    [self.attrsArray removeAllObjects];
    self.lastContentHeight = 0;
    self.spacingWithLastSection = 0;
    self.sectionInsets = UIEdgeInsetsZero;
    self.headerReferenceSize = CGSizeZero;
    self.footerReferenceSize = CGSizeZero;
    self.lineSpacing = 0;
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger i = 0; i < sectionCount; i ++) {

        NSIndexPath *indexPat = [NSIndexPath indexPathWithIndex:i];
        if ([_delegate respondsToSelector:@selector(collectionView:layout:columnNumberAtSection:)]) {
            self.columnCount = [_delegate collectionView:self.collectionView layout:self columnNumberAtSection:indexPat.section];
        }
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            self.sectionInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPat.section];
        }
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:spacingWithLastSectionForSectionAtIndex:)]) {
            self.spacingWithLastSection = [_delegate collectionView:self.collectionView layout:self spacingWithLastSectionForSectionAtIndex:indexPat.section];
        }
        
        
        NSInteger itemCountOfSection = [self.collectionView numberOfItemsInSection:i];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *headerAttributs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [self.attrsArray addObject:headerAttributs];
        [self.columnHeights removeAllObjects];
        
        self.lastContentHeight = self.contentHeight;
        
        for (NSInteger i = 0; i < self.columnCount; i ++) {
            [self.columnHeights addObject:@(self.contentHeight)];
        }
        
        for (NSInteger j = 0; j < itemCountOfSection; j ++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attributes];
        }

        UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        
            [self.attrsArray addObject:footerAttributes];
 
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(collectionView:layout:columnNumberAtSection:)]) {
        self.columnCount = [_delegate collectionView:self.collectionView layout:self columnNumberAtSection:indexPath.section];
    }
    
    if ([_delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)]) {
        self.lineSpacing = [_delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:indexPath.section];
    }
    
    if ([_delegate  respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)]) {
        self.interitemSpacing = [_delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:indexPath.section];
    }
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWeight = self.collectionView.frame.size.width;
    CGFloat cellWeight = (collectionViewWeight - self.sectionInsets.left - self.sectionInsets.right - (self.columnCount - 1) * self.interitemSpacing) / self.columnCount;
    
    CGFloat cellHeight = [self.delegate collectionView:self.collectionView layout:self heightForRowAtIndexPath:indexPath itemWidth:cellWeight];
    
    NSInteger tempMinColumn = 0;
 
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        CGFloat columnH = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnH) {
            minColumnHeight = columnH;
            tempMinColumn = i;
        } else {}
    }

    CGFloat cellX = self.sectionInsets.left + tempMinColumn * (cellWeight + self.interitemSpacing);
    
    CGFloat cellY = 0;
    
    cellY = minColumnHeight;
    if (cellY != self.lastContentHeight) {
        cellY += self.lineSpacing;
    } else {}
    
    if (self.contentHeight < minColumnHeight) {
        self.contentHeight = minColumnHeight;
    } else {}
    
    
    attributes.frame = CGRectMake(cellX, cellY, cellWeight, cellHeight);
    
    self.columnHeights[tempMinColumn] = @(CGRectGetMaxY(attributes.frame));
    for (NSInteger i = 0; i < self.columnHeights.count; i++ ) {
        if (self.contentHeight < [self.columnHeights[i] doubleValue]) {
            self.contentHeight = [self.columnHeights[i] doubleValue];
        }
    }
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            self.headerReferenceSize = [_delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
        self.contentHeight += self.spacingWithLastSection;
        attributes.frame = CGRectMake(0,  self.contentHeight, self.headerReferenceSize.width, self.headerReferenceSize.height);
        ;
        self.contentHeight += self.headerReferenceSize.height;
        self.contentHeight += self.sectionInsets.top;
        
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter] ){
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            self.footerReferenceSize = [_delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
        
        self.contentHeight += self.sectionInsets.bottom;
        attributes.frame = CGRectMake(0, self.contentHeight, self.footerReferenceSize.width, self.footerReferenceSize.height);
 
        self.contentHeight += self.footerReferenceSize.height;
    }
 
    return attributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (NSInteger)columnCount {
    if (_columnCount) {
        return _columnCount;
    }  else {}
    return DefaultColumnCpunt;
}


- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }  else {}
    return _attrsArray;
}


-(NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray arrayWithCapacity:DefaultColumnCpunt];
        
    }  else {}
    return _columnHeights;
}

 


@end
