
import Foundation

class UsersVCViewModel : NSObject{
    
    //MARK: - Variable Declaration
    private var apiController: APIControllerProtocol
    var userList = UsersModel()
    var reloadTableView: (() -> Void)?
    var userCellViewModel = [UserCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(userService: APIControllerProtocol = UserService()) {
        self.apiController = userService
    }
    
    //MARK: - GET TOKEN, POSTS and USER DATA
    func get(){
       
        self.apiController.getAPI(apiUrl: WebServiceURLs.userAPI){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(UsersModel.self, from: responseData as! Data)
                        self.userList = dicResponseData
                        self.fetchUsers(post: self.userList)

                    }catch let err {
                        print("Session Error: ",err)
                        
                        
                    }
                }
                else{
                }
            }
        }
       
    }


    func fetchUsers(post: UsersModel) {
        self.userList = post
        var objCellModel = [UserCellViewModel]()
        for j in 0..<post.count{
            objCellModel.append(createCellModelUser(post: post[j], username: post[j].username ?? "", address: "\(post[j].address?.suite ?? ""), \(post[j].address?.street ?? ""), \(post[j].address?.city ?? "") \(post[j].address?.zipcode ?? "")", id: "\(post[j].id ?? 1)"))

          
        }
        userCellViewModel = objCellModel
    }
    //MARK: - Create cell and add data
  
    func createCellModelUser(post: UsersModelElement, username: String, address: String, id: String) -> UserCellViewModel {
        let username = post.username ?? ""
        let address = "\(post.address?.suite ?? ""), \(post.address?.street ?? ""), \(post.address?.city ?? "") \(post.address?.zipcode ?? "")"
        let id = post.id
        
        return UserCellViewModel(username: username, address: address, userID: "\(id ?? 1)")
    }
    //MARK: - return Cell to controller with Data
    func getCellViewModel(at indexPath: IndexPath) -> UserCellViewModel {
        return userCellViewModel[indexPath.row]
    }
}

struct UserCellViewModel {
    var username: String
    var address: String
    var userID: String

}

