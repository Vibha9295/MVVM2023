
import Foundation
import UIKit

let USERDEFAULTS = UserDefaults.standard
let APPDELEGATE = UIApplication.shared.delegate as? AppDelegate

enum UserDefaultsKeys: String {
    case accessToken // access token
    
}
struct WebServiceURLs {
    static let domain = "https://jsonplaceholder.typicode.com/"
    static let userAPI = domain + "users"
    static let postsAPI = domain + "posts"
}
struct AlertMessage{
    static let msgNotReachable = "Internet is not reachable"
    static let msgTitlePost = "Please enter Post title"
    static let msgDescPost = "Please enter Post Description"
}

struct CellID{
    static let cellUserTbl = "UsersTblCell"
    static let cellPostTbl = "PostsTblCell"
}
