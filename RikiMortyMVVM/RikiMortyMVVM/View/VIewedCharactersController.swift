import UIKit
import Constraints

final class VIewedCharactersViewController: UIViewController {
    
    public  var character: Characters.Result?
    
    private var collection = ViewedCharactersCollection()
    
    private var content = UIView()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        getImage()
        
    }
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "История"
        view.backgroundColor = .white
        view.addSubview(content)
        content.addSubview(characterImage)
        content.addSubview(collection)
        collection.showsVerticalScrollIndicator = false
        
    }
    
    private func layout() {
        
        content.layout
            .box(in: view)
            .activate()
        
        characterImage.layout
            .size(100)
            .centerX.equal(content.centerY)
            .horizontally()
            .top(50)
            .activate()
        
        collection.layout
            .leading(16)
            .trailing(16)
            .top(0)
            .height(100)
            .bottom(0)
            .activate()
        
    }
    
    public func getImage() {
        
        
        Task {
            guard let url = character?.normalUrl else { return }
            await characterImage.load(for: url)
            
        }
    }
}
