import UIKit

final class ForecastCollection: UICollectionView {
    
   
    
    
    
    public init() {
        let layout = UICollectionViewFlowLayout()
           let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    private func setup() {
        dataSource = self
        delegate = self
        register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.identifier)
        
       
        showsHorizontalScrollIndicator = false
        contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        decelerationRate = .fast
    }
}

extension ForecastCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 50, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension ForecastCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.identifier, for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        
            fatalError("Не удалось извлечь ячейку YourCollectionViewCell")
        }
        
        // Настройте ячейку данными или выполните любую необходимую настройку
        
        return cell
    }
}
