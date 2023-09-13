import UIKit
import Constraints

final class ForecastCell: UICollectionViewCell {
    private lazy var imageView = UIImageView()
    private lazy var temp = UILabel()
    private lazy var time = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(imageView)
        contentView.addSubview(temp)
        contentView.addSubview(time)
        
        imageView.layout
            .size(30)
            .horizontally()
            .top(10)
            .activate()
        
        temp.layout
            .horizontally()
            .top.equal(imageView.bottom, 4)
            .activate()
        
        time.layout
            .horizontally()
            .top.equal(temp.bottom, 4)
            .activate()
    }
}
    extension ForecastCell {
        public static let identifier: String = "forecastCell"
    }
    

