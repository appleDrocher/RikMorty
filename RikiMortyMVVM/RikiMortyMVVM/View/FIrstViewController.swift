import Constraints
import UIKit

final class FirstViewController: UIViewController {
  
    private lazy var forecastCollection = ForecastCollection()
    private var content = UIView()
    private let heroes: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 187, height: 38)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Персонажи", attributes: [NSAttributedString.Key.kern: -0.3])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        

    }
    
    private func setup() {
        
        view.addSubview(content)
        content.addSubview(heroes)
        content.addSubview(forecastCollection)

    }
    
    
    private func layout() {
        content.layout
            .box(in: view)
            .activate()
        
        heroes.layout
            .top(-20)
            .leading(16)
            .width(187)
            .height(38)
            .activate()
       
        forecastCollection.layout
            .leading()
            .trailing()
            .top(20)
            .height(100)
            .activate()
    }
    
}
