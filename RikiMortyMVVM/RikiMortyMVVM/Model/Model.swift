import Foundation

// MARK: - Welcome
public struct Characters: Decodable {
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
        let species: String
        let type: String
        let gender: Gender
        let origin: Location
        let location: Location
        let image: String
        let episode: [String]
        let created: String
        
        private let url: String
        
        var normalUrl: URL? {
            return URL(string: image)
        }
        
        var speciesRus: String {
            switch species {
            case "Alien": return "Инопланетянин"
            case "Human": return "Человек"
            case "Animal": return "Животное"
            case "Humanoid": return "Гуманоид"
            default: return species
            }
        }
    }
    
    // MARK: - Location
    
    
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var russifikationStatus: String {
            switch self  {
            case .alive: return "Живой"
            case .dead:  return "Мертвый"
            case .unknown: return "Неизвестно"
            }
            
        }
        
    }
    
    struct Location: Decodable {
        let name: String
        let url: String
    }
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }
    
    
}


