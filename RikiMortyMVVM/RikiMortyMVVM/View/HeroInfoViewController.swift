import UIKit
import Constraints

final class HeroInfoViewController: UIViewController {
    
    public  var character: Characters.Result?
    
    private var content = UIView()
  
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
 
    private lazy var frameImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.compact.down")
        image.tintColor = UIColor.black
        return image
    }()
   
    private lazy var spinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spiner.startAnimating()
        spiner.hidesWhenStopped = false
        spiner.startAnimating()
        return spiner
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        getImage()
        
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(content)
        content.addSubview(characterImage)
        content.addSubview(spinner)
        content.addSubview(frameImage)
   
    }
    
    private func layout() {
        
        content.layout
            .box(in: view)
            .activate()
        
        characterImage.layout
            .size(170)
            .centerX.equal(content.centerY)
            .horizontally()
            .top(50)
            .activate()
        
        spinner.layout
            .centerX.equal(characterImage.centerY)
            .horizontally()
            .top(130)
            .activate()
        
        frameImage.layout
            .size(w: 40, h: 28)
            .centerX.equal(content.centerY)
            .horizontally()
            .top(6)
            .activate()
    }
   
    public func getImage() {
        spinner.startAnimating()
     
        Task {
            guard let url = character?.normalUrl else { return }
            await characterImage.load(for: url)
            self.spinner.isHidden = true
        }
    }
}
