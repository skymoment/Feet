import UIKit
import RealmSwift
import SwiftyJSON
class RealmFeetItem: Object {
    dynamic var id = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].string ?? ""
    }
    
}
