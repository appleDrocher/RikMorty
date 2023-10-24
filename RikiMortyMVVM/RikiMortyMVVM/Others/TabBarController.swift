import UIKit

final class Fabric {
    public static func createTabBar() -> UITabBarController? {
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColor.backgroundCell.cgColor
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
            return nil
        }
        
        let images = ["Home", "History", "Hearts"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(named: images[i])
            
        }
        
        return tabBarController
    }
}
