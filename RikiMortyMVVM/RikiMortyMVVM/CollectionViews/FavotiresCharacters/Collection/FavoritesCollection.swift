import UIKit

final class FavoritesCollection: UICollectionView {
    
    
    public init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public var favoritesHero: [Int] = [] {
        didSet{
            reloadData()
        }
    }
    
    private func setup() {
        dataSource = self
        delegate = self
        register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.identifierr)
        decelerationRate = .fast

    }
}


extension FavoritesCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return numberOfSection
    }
    
}

extension FavoritesCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifierr, for: indexPath) as? FavoritesCell else {
            return UICollectionViewCell()
            
        }
        
        return cell
    }
    
}
