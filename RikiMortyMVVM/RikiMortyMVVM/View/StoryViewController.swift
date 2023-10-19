import UIKit
import Constraints

final class StoryViewController: UIViewController {
    
    public  var character: Characters.Result?
    
    private var content = UIView()
  
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Информация"
        view.backgroundColor = .white
        view.addSubview(content)
        content.addSubview(characterImage)
        content.addSubview(spinner)
       
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
        
        spinner.layout
            .centerX.equal(content.centerY)
            .horizontally()
            .top(90)
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
