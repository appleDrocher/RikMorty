import UIKit

final class ViewedCharactersCollection: UICollectionView {
    
    
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
        register(ViewedCharactersCell.self, forCellWithReuseIdentifier: ViewedCharactersCell.identifierrr)
        decelerationRate = .fast

    }
}


extension ViewedCharactersCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return numberOfSection
    }
    
}

extension ViewedCharactersCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewedCharactersCell.identifierrr, for: indexPath) as? ViewedCharactersCell else {
            return UICollectionViewCell()
            
        }
        
        return cell
    }
    
}
