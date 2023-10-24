import UIKit
import Constraints
import Foundation

final class FavoritesCell: UICollectionViewCell {
   
    private var content = UIView()
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    var id: Int?
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
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
  
    public func configure(with hero: Characters.Result) {
        characterName.attributedText = NSMutableAttributedString(string: "\(hero.name)", attributes: [NSAttributedString.Key.kern: -0.3])
        alive.attributedText = NSMutableAttributedString(string: "\(hero.status.russifikationStatus) - \(hero.speciesRus)", attributes: [NSAttributedString.Key.kern: -0.3])
        Task {
            guard let url = hero.normalUrl else { return }
            await characterImage.load(for: url)
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
        contentView.layer.backgroundColor = UIColor.backgroundCell.cgColor
        contentView.clipsToBounds = true
        
        contentView.addSubview(content)
   
        
        content.addSubview(characterImage)
        content.addSubview(characterName)
        content.addSubview(alive)
       
        
        content.layout
            .box(in: contentView)
            .activate()
        
        
        characterImage.layout
            .size(70)
            .leading.equal(characterImage.leading)
            .top()
            .activate()
         
        
    }
}

extension FavoritesCell {
        public static let identifierr: String = "FavoritesCell"
    }
    


