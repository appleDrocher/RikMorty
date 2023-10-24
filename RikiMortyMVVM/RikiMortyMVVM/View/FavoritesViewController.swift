import UIKit
import Constraints

final class FavoritesViewController: UIViewController {
    
    private var content = UIView()
    private var favoritesCollection = FavoritesCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Избранное"
        setup()
        layout()
    }
    
    private func setup() {
        favoritesCollection.showsVerticalScrollIndicator = false
        favoritesCollection.auto = true
      
        view.addSubview(content)
        content.addSubview(favoritesCollection)
        
    }
    
        
        private func layout() {
            content.layout
                .box(in: view)
                .activate()
            
            favoritesCollection.layout
                .leading(16)
                .trailing(16)
                .top(0)
                .height(100)
                .bottom(0)
                .activate()
            
        }
        
        
    }
    
