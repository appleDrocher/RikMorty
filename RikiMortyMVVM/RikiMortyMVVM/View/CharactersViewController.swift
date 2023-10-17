import Constraints
import UIKit

final class CharactersViewController: UIViewController, UISearchBarDelegate {
  
    private lazy var charactersCollection = CharactersCollection()
  
    private var content = UIView()

    private lazy var searchCharactersController: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Поиск персонажей"
        search.searchBar.delegate = self
        search.searchBar.searchBarStyle = .minimal
        return search
    }()
    
    private var searchText: String? = nil
    
    
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let name = searchText.isEmpty ? nil : searchText
        self.searchText = name
        charactersCollection.page = 0
        
        Task {
            do {
                let characters = try await Networker.shared.get(
                    object: Characters.self,
                    for: .characters(name: name)
                )
                charactersCollection.hero = characters.results
        
            } catch {
                guard error is Failure else { return }
                
                }
        }
    }
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
    private func setup() {
        charactersCollection.showsVerticalScrollIndicator = false
        charactersCollection.auto = true
        navigationItem.searchController = searchCharactersController
        charactersCollection.controller = self
        view.addSubview(content)
        content.addSubview(charactersCollection)
  
        load(for: 0)
    }
    
    private func layout() {
        content.layout
            .box(in: view)
            .activate()
        
        charactersCollection.layout
            .leading(16)
            .trailing(16)
            .top(0)
            .height(100)
            .bottom(0)
            .activate()
        
    }

    
   public func load(for page: Int) {
        Task {
            do {
                let characters = try await Networker.shared.get(
                    object: Characters.self,
                    for: .characters(name: searchText, page: page)
                )
                charactersCollection.hero.append(contentsOf: characters.results)
            } catch {
                guard error is Failure else { return }
                
            }
        }
    }
    
}
