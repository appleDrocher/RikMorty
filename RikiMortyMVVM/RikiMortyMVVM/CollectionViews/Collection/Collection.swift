import UIKit

final class ForecastCollection: UICollectionView {
    
    public weak var controller : UIViewController?
    
    private var hero: Characters?
    
    
    public init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
       
}
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = SecondViewController()
        controller?.navigationController?.pushViewController(newViewController, animated: true)
        
    }
   
    public func set(hero: Characters?) {
        self.hero = hero
        reloadData()
    }
    
    
    
    private func setup() {
        dataSource = self
        delegate = self
        register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.identifier)
        
       
        
        contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        decelerationRate = .fast
    }
}

extension ForecastCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width:  364, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension ForecastCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hero?.results.count ?? 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.identifier, for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
            
        }
        if let chatac = hero?.results[indexPath.item] { cell.configure(with: chatac) }
      
        return cell
    }
  
    
    
    
}
