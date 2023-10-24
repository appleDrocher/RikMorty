import Constraints
import UIKit

final class CharactersViewController: UIViewController, UISearchBarDelegate {
    
    private lazy var charactersCollection = CharactersCollection()
    
    private var content = UIView()
    
    public lazy var mainSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spiner.startAnimating()
        spiner.style = .large
        return spiner
    }()
    
    public lazy var loadNextPageSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spiner.style = .medium
        return spiner
    }()
    
    
    private lazy var searchCharactersController: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Поиск персонажей"
        search.searchBar.delegate = self
        search.searchBar.searchBarStyle = .minimal
        return search
    }()
    
    private var searchText: String? = nil
    
    
    @objc private func sortedFavoritesTapped() {
        
        
        let favoritesVC = FavoritesViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
        
    }
    
    
    
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
    
    //    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //
    //    }
    
    private func setup() {
        charactersCollection.showsVerticalScrollIndicator = false
        charactersCollection.charactersController = self
        navigationItem.searchController = searchCharactersController
        
        
        view.addSubview(content)
        content.addSubview(charactersCollection)
        content.addSubview(mainSpinner)
        content.addSubview(loadNextPageSpinner)
        
        load(for: 0)
        
        let sortedFavoritesButton = UIBarButtonItem(
            title: "Sorted Favorites",
            style: .done,
            target: self,
            action: #selector(sortedFavoritesTapped)
        )
        
        
        navigationItem.rightBarButtonItem = sortedFavoritesButton
        
        
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
        
        
        mainSpinner.layout
            .centerX.equal(content.centerY)
            .horizontally()
            .bottom.equal(charactersCollection.bottom, 300)
            .activate()
        
        
        
        loadNextPageSpinner.layout
            .centerX.equal(content.centerY)
            .horizontally()
            .bottom.equal(charactersCollection.bottom, 10)
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
              self.mainSpinner.isHidden = true
              self.loadNextPageSpinner.isHidden = true
            } catch {
                sleep(5)
                guard let failure = error as? Failure else { return }
                showAlert(message: failure.description)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "ОК", style: .cancel))
        present(alert, animated: true)
    }
}
