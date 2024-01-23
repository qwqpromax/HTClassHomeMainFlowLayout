//
//  EXAMPLEViewController.m
//  HTClassHomeMainFlowLayout
//
//  Created by hedongquanzi on 01/23/2024.
//  Copyright (c) 2024 hedongquanzi. All rights reserved.
//
#import "CustomCollectionViewCell.h"
#import "HTClassHomeMainFlowLayout.h"
#import "EXAMPLEViewController.h"

@interface EXAMPLEViewController ()<UICollectionViewDataSource,HTClassHomeMainFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EXAMPLEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
  
    HTClassHomeMainFlowLayout * var_layout = [[HTClassHomeMainFlowLayout alloc]init];
    var_layout.delegate = self;
    
    self.collectionView.collectionViewLayout = var_layout;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}


- (void)ht_reloadData {
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  10;

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    if(indexPath.section == 0){
        return  250;
    }
    
    if (indexPath.section == 1){
        return  180;
    }
    
    CGFloat var_itemWidth = (self.view.bounds.size.width - 14-14-10)/2;
    CGFloat var_itemHeight = 180;
    return  var_itemHeight;
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout columnNumberAtSection:(NSInteger)section {

    if (section ==0){
        return  1;
    }
    if (section ==1){
        return 2;
    }
    return 3;
   
    
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout*)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section {
   
    return  4.;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:( HTClassHomeMainFlowLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section {
    return 16.;
}



@end
