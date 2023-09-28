import UIKit
import Constraints
import Foundation

final class CharactersCell: UICollectionViewCell, UITextFieldDelegate {
   
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
   
    private lazy var frameImage: UIImageView = {
        let image = UIImageView (image: UIImage(named: "Frame"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var elipseImage: UIImageView = {
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
        characterName.text = "\(hero.name)"
        alive.text = "\(hero.status.rawValue) - \(hero.species.rawValue)"
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
        contentView.layer.backgroundColor = UIColor(red: 0.967, green: 0.967, blue: 0.967, alpha: 1).cgColor
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
        contentView.addSubview(alive)
        contentView.addSubview(frameImage)
        contentView.addSubview(elipseImage)
    
        characterImage.layout
            .size(70)
            .leading.equal(characterImage.leading)
            .top()
            .activate()
        
        characterName.layout
            .size(w: 140, h: 19)
            .leading(82)
            .top.equal(characterImage.top, 17)
            .activate()
        
        frameImage.layout
            .size(w: 8, h: 15)
            .trailing(30)
            .top(30)
            .leading(345)
            .activate()
       
        elipseImage.layout
            .size(w: 6, h: 6)
            .top(45)
            .leading(85)
            .activate()
        
        alive.layout
            .size(w: 127, h: 17)
            .top(38)
            .leading.equal(elipseImage.trailing,5)
            .activate()

    }
}
  

extension CharactersCell {
        public static let identifier: String = "charactersCell"
    }
    


