import UIKit
import Constraints
import Foundation

final class ForecastCell: UICollectionViewCell, UITextFieldDelegate {
   
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 18
        image.clipsToBounds = true
        return image
    }()
       
    
    private lazy var heroName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
   
    private lazy var imageView2: UIImageView = {
        let image = UIImageView (image: UIImage(named: "Frame"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var imageView3: UIImageView = {
        let image = UIImageView (image: UIImage(named: "Ellipse 1"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    private lazy var alive: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .justified
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.3])
        return label
    }()
  
    private lazy var status: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .justified
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.3])
        return label
    }()
  
    public func configure(with hero: Characters.Result ) {
        heroName.text = "\(hero.name)"
        alive.text = "\(hero.status.rawValue) - \(hero.species.rawValue)"
        Task {
            guard let url = hero.url5 else { return }
            await imageView.load(for: url)
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.layer.backgroundColor = UIColor(red: 0.967, green: 0.967, blue: 0.967, alpha: 1).cgColor
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(heroName)
        contentView.addSubview(alive)
        contentView.addSubview(imageView2)
        contentView.addSubview(imageView3)
    
        imageView.layout
            .size(70)
            .leading.equal(imageView.leading)
            .top()
            .activate()
        
        heroName.layout
            .size(w: 140, h: 19)
            .leading(82)
            .top.equal(imageView.top, 17)
            .activate()
        
        imageView2.layout
            .size(w: 8, h: 15)
            .trailing(30)
            .top(30)
            .leading(345)
            .activate()
       
        imageView3.layout
            .size(w: 6, h: 6)
            .top(45)
            .leading(85)
            .activate()
        
        alive.layout
            .size(w: 127, h: 17)
            .top(38)
            .leading.equal(imageView3.trailing,5)
            .activate()

    }
}
  

extension ForecastCell {
        public static let identifier: String = "forecastCell"
    }
    


