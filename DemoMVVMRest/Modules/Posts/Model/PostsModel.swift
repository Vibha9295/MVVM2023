
import Foundation

// MARK: - PostListModelElement
struct PostListModelElement: Codable {
    let userID, id: Int?
    let title, body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID
        case id, title, body
    }
}

typealias PostListModel = [PostListModelElement]
