import UIKit

class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let collectionViewWidth = collectionView.bounds.size.width
        let halfCollectionViewWidth = collectionViewWidth / 2
        
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfCollectionViewWidth
        
        var closestAttribute: UICollectionViewLayoutAttributes?
        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for attribute in layoutAttributesForElements(in: collectionView.bounds)! {
            let centerX = attribute.center.x
            let distance = abs(centerX - proposedContentOffsetCenterX)
            
            if distance < closestDistance {
                closestAttribute = attribute
                closestDistance = distance
            }
        }
        
        guard let closest = closestAttribute else { return proposedContentOffset }
        
        let targetContentOffsetX = floor(closest.center.x - halfCollectionViewWidth)
        
        return CGPoint(x: targetContentOffsetX, y: proposedContentOffset.y)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = collectionView else { return }
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let currentOffset = collectionView.contentOffset
        let targetOffset = targetContentOffset.pointee
        
        var newTargetOffset = targetOffset
        
        let width = layout.itemSize.width + layout.minimumLineSpacing
        
        let currentPage = round(currentOffset.x / width)
        let targetPage = round(targetOffset.x / width)
        
        let nextOrPreviousPage: CGFloat = velocity.x > 0 ? 1 : -1
        
        if targetPage == currentPage {
            newTargetOffset = CGPoint(x: (currentPage + nextOrPreviousPage) * width, y: targetOffset.y)
        } else {
            newTargetOffset = CGPoint(x: targetPage * width, y: targetOffset.y)
        }
        
        targetContentOffset.pointee = newTargetOffset
    }
}

