
import Foundation

final class Storage {
    enum Key: String {
        
        case favorites
        
    }
    
    static func setFavorites(id: Int, value: Bool) {
        
        
        guard var dictinory =  user.dictionary(forKey: Key.favorites.rawValue) as? [String: Bool] else {
            var dictinory = ["\(id)": value]
            dictinory["\(id)"] = value
            user.setValue(dictinory, forKey: Key.favorites.rawValue)
           
            return
        }
        
        dictinory["\(id)"] = value
        
        user.setValue(dictinory, forKey: Key.favorites.rawValue)
    }
    
    private static var user = UserDefaults.standard
    
    static func getFavorites(id: Int) -> Bool {
       
        guard let dictinory =  user.dictionary(forKey: Key.favorites.rawValue) as? [String: Bool] else {
          
            return false
        }
        return dictinory["\(id)"] ?? false
    }
    
}
