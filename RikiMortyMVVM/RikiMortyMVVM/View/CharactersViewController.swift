import Constraints
import UIKit

final class CharactersViewController: UIViewController {
    
    private lazy var charactersCollection = CharactersCollection()
    private var content = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Персонажи"
        guard let items = tabBarController?.tabBar.items else { return }
        for tab in items where tab.title == title {
            tab.title = "Главная"
        }
    }
    
    private func setup() {
        charactersCollection.showsVerticalScrollIndicator = false
        view.addSubview(content)
        content.addSubview(charactersCollection)
        charactersCollection.controller = self
        
        Task {
            do {
                let characters = try await Networker.shared.get(
                    object: Characters.self,
                    for: .characters
                )
                charactersCollection.set(hero: characters)
            } catch {
                guard error is Failure else { return }
                
            }
        }
    }
    
    private func layout() {
        content.layout
            .box(in: view)
            .activate()
        
        charactersCollection.layout
            .leading(16)
            .trailing(16)
            .top(0)
            .height(800)
            .bottom(0)
            .activate()
        
        
    }
    
}
