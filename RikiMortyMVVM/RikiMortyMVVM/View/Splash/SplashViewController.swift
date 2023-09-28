
import UIKit

final class SplashViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1).cgColor
                 
        let characterVc = CharactersViewController()
        let storyVc = StoryViewController()
        let favoriteVc = FavoritesViewController()
       
        let home = UINavigationController(rootViewController: characterVc)
        let storyes = UINavigationController(rootViewController: storyVc)
        let favorites = UINavigationController(rootViewController: favoriteVc)
        
        home.title = "Главная"
        storyes.title = "История"
        favorites.title = "Избранное"
        
        tabBarController.setViewControllers([home, storyes, favorites], animated: false)
        
       guard let items = tabBarController.tabBar.items else {
            return
       }
        
        let images = ["Home", "History", "Hearts"]
      
        for i in 0..<items.count {
            items[i].image = UIImage(named: images[i])
            
        }

        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
        
    }
}
