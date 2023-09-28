import UIKit

final class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Избранное"
       
    }
       
}
