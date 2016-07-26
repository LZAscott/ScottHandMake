//
//  ScottBoundsLayout.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottBoundsLayout.h"

@implementation ScottBoundsLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    CGFloat numOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            
            CGRect cellRect = attr.frame;
            if (offsetY <= 0) {
                CGFloat distance = fabs(offsetY) / 8;
                cellRect.origin.y += offsetY + distance * (CGFloat)(attr.indexPath.section + 1);
                
            }else if (bottomOffset > 0 ){
                CGFloat distance = bottomOffset / 8;
                cellRect.origin.y += bottomOffset - distance *(CGFloat)(numOfItems - attr.indexPath.section);
            }
            attr.frame = cellRect;
        }
    }
    return attrsArray;
}

@end
