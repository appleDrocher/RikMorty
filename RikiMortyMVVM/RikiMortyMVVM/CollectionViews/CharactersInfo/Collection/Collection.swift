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
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = hero[indexPath.item]
        let storyVC = StoryViewController()
        storyVC.character = selectedCharacter
        charactersController?.navigationController?.pushViewController(storyVC, animated: true)
        
    }
    
    
    
    private func setup() {
        dataSource = self
        delegate = self
        register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.identifier)
        decelerationRate = .fast
        
    //  contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    //  charactersController?.mainSpinner.layer.zPosition = -1
    //  charactersController?.mainSpinner.frame = self.frame
    
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
        return .init(width: collectionView.frame.width, height: 70)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == hero.count - 1 {
            page += 1
            charactersController?.load(for: page)
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
