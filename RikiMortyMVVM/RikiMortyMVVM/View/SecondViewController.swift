import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Информация"
        view.backgroundColor = .systemYellow
    }

}
