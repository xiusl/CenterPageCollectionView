//
//  CenterPageCollectionLayout.m
//  CenterPageCollectionView
//
//  Created by QMP on 2018/7/30.
//  Copyright © 2018年 xiusl. All rights reserved.
//
//  Reference:
//  https://github.com/MaherKSantina/MSPeekCollectionViewDelegateImplementation
//  https://github.com/maximbilan/UICollectionViewHorizontalPaging
//  https://github.com/Instagram/IGListKit/issues/825
//  https://github.com/hershalle/CollectionViewWithPaging-Finish

#import "CenterPageCollectionLayout.h"

@implementation CenterPageCollectionLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset withScrollingVelocity:(CGPoint)velocity {
    CGRect cvBounds = self.collectionView.bounds;
    CGFloat halfWidth = cvBounds.size.width * 0.5f;
    
    
    NSArray *attributesArray = [self layoutAttributesForElementsInRect:cvBounds];
    if (velocity.x == 0) { // 按住拖动
        CGFloat proposedContentOffsetCenterX = offset.x + halfWidth;
        
        UICollectionViewLayoutAttributes *candidateAttributes;
        for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
            
            if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
                continue;
            }
            
            if(!candidateAttributes) {
                candidateAttributes = attributes;
                continue;
            }
            
            if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
                candidateAttributes = attributes;
            }
        }
        return CGPointMake(candidateAttributes.center.x - halfWidth, offset.y);
    } else {

        UICollectionViewLayoutAttributes *candidateAttributes;
        for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
            if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
                continue;
            }
            if ((attributes.center.x == 0) || (attributes.center.x > (self.collectionView.contentOffset.x + halfWidth) && velocity.x < 0)) {
                continue;
            }
            candidateAttributes = attributes;
        }
        
        if (!candidateAttributes) {
            return [super targetContentOffsetForProposedContentOffset:offset];
        }
        
        return CGPointMake(floor(candidateAttributes.center.x - halfWidth), offset.y);
    }
}
@end
