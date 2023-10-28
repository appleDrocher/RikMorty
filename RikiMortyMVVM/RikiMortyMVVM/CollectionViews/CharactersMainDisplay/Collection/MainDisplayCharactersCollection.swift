import UIKit


final class CharactersCollection: UICollectionView {
        
    public weak var charactersController : CharactersViewController?
    
    public weak var collectionView: CharactersCollection?
    
    public var page = 0
    
    public var hero: [Characters.Result] = [] {
        didSet{
            reloadData()
        }
    }
    
    var isLoadingData = false
    
    public init() {
        let flow = SnappingCollectionViewLayout()
        flow.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: flow)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = hero[indexPath.item]
        let storyVC = HeroInfoViewController()
        storyVC.character = selectedCharacter
        charactersController?.navigationController?.present(storyVC, animated: true)
        
    }
    
    private func setup() {
        dataSource = self
        delegate = self
        register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.identifier)
        decelerationRate = .fast
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")

    }
}

extension CharactersCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return numberOfSection
        
    }
}



extension CharactersCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 60)
   
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath)
            
            for subview in footerView.subviews {
                subview.removeFromSuperview()
            }
            
            if let loadNextPageSpinner = charactersController?.contentIndicator {
                footerView.addSubview(loadNextPageSpinner)
            }
            
            return footerView
        }
        
        return UICollectionReusableView()
    }


    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      
        if indexPath.item == hero.count - 1 {
            page += 1
            charactersController?.load(for: page)
            charactersController?.loadNextPageSpinner.startAnimating()
            

        }
        
        if indexPath.item == hero.count - 1 && !isLoadingData {
            isLoadingData = false
            charactersController?.loadNextPageSpinner.isHidden = false
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hero.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.identifier, for: indexPath) as? CharactersCell else {
            return UICollectionViewCell()
            
        }
        let characters = hero[indexPath.item]
        
        cell.configure(with: characters)
        
        return cell
    }
    
}
