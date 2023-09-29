
import Foundation

// MARK: - Welcome
struct Characters: Decodable {
    let info: Info
    let results: [Result]
}

// MARK: - Info

extension Characters {
    
    
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String
        
    }
    
    // MARK: - Result
    struct Result: Decodable {
        let id: Int
        let name: String
        let status: Status
        let species: Species
        let type: String
        let gender: Gender
        let origin: Location
        let location: Location
        let image: String
        let episode: [String]
        let created: String
        
        private let url: String
        
        var normalUrl: URL? {
            let normal =  image
            return URL(string: normal)
        }
    }
    
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }
    
    // MARK: - Location
    
    enum Species: String, Decodable {
        case alien = "Alien"
        case human = "Human"
    }
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
  
    struct Location: Decodable {
        let name: String
        let url: String
    }
    
}
    
    

