
//  HTClassHomeMainFlowLayout.h
//  CommonOCProject
//
//  Created by ajie on 2024/1/14.
//
#import <UIKit/UIKit.h>


@class  HTClassHomeMainFlowLayout;

@protocol  HTClassHomeMainFlowLayoutDelegate <NSObject>

@required

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth ;

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section;

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout*)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout*)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section;

@end


@interface  HTClassHomeMainFlowLayout : UICollectionViewLayout


@property (nonatomic, weak) id<HTClassHomeMainFlowLayoutDelegate> delegate;

@property (nonatomic,assign) UIEdgeInsets sectionInsets;

@property (nonatomic,assign) NSInteger columnCount;

@property (nonatomic,assign) CGFloat lineSpacing;

@property (nonatomic,assign) CGFloat interitemSpacing;

@property (nonatomic,assign) CGSize headerReferenceSize;

@property (nonatomic,assign) CGSize footerReferenceSize;



@end
