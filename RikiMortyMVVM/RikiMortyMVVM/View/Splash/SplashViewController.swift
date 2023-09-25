
import UIKit

class SplashViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1).cgColor
   
              
        let vc1 = FirstViewController()
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
       
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.title = "Главная"
        nav2.title = "История"
        nav3.title = "Избранное"
        
        tabBarController.setViewControllers([nav1, nav3, nav2], animated: false)
        
       guard let items = tabBarController.tabBar.items else {
            return
       }
        
        let images = ["FrameHome", "History", "Hearts"]
        let selectedImages = ["home_icon_selected", "history_icon_selected", "favorite_icon_selected"]

        for i in 0..<items.count {
            items[i].image = UIImage(named: images[i])
            items[i].selectedImage = UIImage(named: selectedImages[i])
        }

        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
        
    }
}

