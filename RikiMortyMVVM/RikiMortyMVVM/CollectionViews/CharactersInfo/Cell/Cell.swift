
import UIKit
import Constraints
import Foundation

final class CharactersCell: UICollectionViewCell {
    
    private var content = UIView()
    
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    
    private lazy var favorites: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tintColor = .gray
        return button
    }()
       
    
    private var id: Int?
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var frameImage: UIImageView = {
        let image = UIImageView (image: .circle)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var elipseImage: UIImageView = {
        let image = UIImageView (image: .chevron)
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
    
    public func configure(with hero: Characters.Result) {
        characterName.attributedText = NSMutableAttributedString(string: "\(hero.name)", attributes: [NSAttributedString.Key.kern: -0.3])
        alive.attributedText = NSMutableAttributedString(string: "\(hero.status.russifikationStatus) - \(hero.speciesRus)", attributes: [NSAttributedString.Key.kern: -0.3])
        Task {
            guard let url = hero.normalUrl else { return }
            await characterImage.load(for: url)
        }
        
        let isFavorit = Storage.getFavorites(id: hero.id)
        
        if isFavorit {
            let image = UIImage(systemName: "heart.fill")
            favorites.setImage(image, for: .normal)
            favorites.tintColor = .red
        } else {
            let image = UIImage(systemName: "heart")
            favorites.setImage(image, for: .normal)
            favorites.tintColor = .gray
        }
        id = hero.id
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
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
        
        contentView.addSubview(content)
        
        content.addSubview(characterImage)
        content.addSubview(characterName)
        content.addSubview(alive)
        content.addSubview(frameImage)
        content.addSubview(elipseImage)
        content.addSubview(favorites)
        
        
        content.layout
            .box(in: contentView)
            .activate()
        characterImage.layout
            .size(70)
            .leading.equal(characterImage.leading)
            .top()
            .activate()
        
        characterName.layout
            .size(w: 140, h: 19)
            .leading(82)
            .trailing.equal(favorites.leading, 15)
            .top.equal(characterImage.top, 17)
            .width(300)
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
            .width(300)
            .trailing.equal(favorites.leading, 15)
            .leading.equal(elipseImage.trailing,5)
            .activate()
        
        
        favorites.layout
            .size(w: 15, h: 15)
            .trailing(30)
            .top(30)
            .leading(310)
            .activate()
        
    }
    
    @objc private func buttonTapped() {
        var isFavorit = Storage.getFavorites(id: id ?? 0)
        isFavorit.toggle()
        Storage.setFavorites(id: id ?? 0, value: isFavorit)
        if !isFavorit {
            let image = UIImage(systemName: "heart")
            favorites.setImage(image, for: .normal)
            favorites.tintColor = .gray
            print("ne tap /xD")
        } else {
            let image = UIImage(systemName: "heart.fill")
            favorites.setImage(image, for: .normal)
            favorites.tintColor = .red
            print("tap")
        }
        
    }
    
    
}


extension CharactersCell {
    public static let identifier: String = "charactersCell"
} // сделай что бы состояние кнопки сохранялись по indexPath
