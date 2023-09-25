
import Foundation

// MARK: - Welcome
struct Characters: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info

extension Characters {
    
    struct Info: Codable {
        let count, pages: Int
        let next: String
        
    }
    
    // MARK: - Result
    struct Result: Codable {
        let id: Int
        let name: String
        let status: Status
        let species: Species
        let type: String
        let gender: Gender
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
        
        
        var url5: URL? {
            let normal =  image
            return URL(string: normal)
        }
    }
        
    }
    
    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }
    
    // MARK: - Location
    
    enum Species: String, Codable {
        case alien = "Alien"
        case human = "Human"
    }
    
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
  
    struct Location: Codable {
        let name: String
        let url: String
    }


