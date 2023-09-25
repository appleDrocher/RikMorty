import Constraints
import UIKit

final class FirstViewController: UIViewController {
    
    private lazy var forecastCollection = ForecastCollection()
    private var content = UIView()
 
    
        override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Персонажи"
        
    }
    
    private func setup() {
        
        forecastCollection.showsVerticalScrollIndicator = false
        view.addSubview(content)
        content.addSubview(forecastCollection)
        forecastCollection.controller = self
       
        Task {
            
            do {
                let characters = try await Networker.shared.get(
                    object: Characters.self,
                    for: .characters
                )

                forecastCollection.set(hero: characters)
                
            } catch {
                guard error is Failure else { return }
                
            }
        }
    
    }
    
    private func layout() {
        content.layout
            .box(in: view)
            .activate()
        
        forecastCollection.layout
            .leading(16)
            .trailing(16)
            .top(0)
            .height(800)
            .bottom(0)
            .activate()
        
        
    }
  
}
