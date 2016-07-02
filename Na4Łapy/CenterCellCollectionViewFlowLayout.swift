//
//  CenterCellCollectionViewFlowLayout.swift
//  Na4Łapy
//
//  Created by mac on 02/07/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            if let attributesArray:NSArray = self.layoutAttributesForElementsInRect(cvBounds)!
                    as [UICollectionViewLayoutAttributes] {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesArray {
                    
                    let _attributes = attributes as? UICollectionViewLayoutAttributes
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.Cell {
                        continue
                    }
                    
                    if let candAttrs = candidateAttributes {
                        
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = _attributes
                        }
                        
                    }
                    else { // == First time in the loop == //
                        
                        candidateAttributes = _attributes
                        continue;
                    }
                    
                    
                }
                
                return CGPoint(x: round(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
                
            }
            
        }
        
        // Fallback
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }
}
