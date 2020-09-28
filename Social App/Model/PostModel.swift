import SwiftUI

struct PostModel : Identifiable {
    
    var id: String
    var title : String
    var pic: String
    var time : Date
    var user: UserModel
}
