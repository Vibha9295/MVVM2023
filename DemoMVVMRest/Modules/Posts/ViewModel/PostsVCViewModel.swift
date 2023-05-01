
import Foundation

class PostVCViewModel : NSObject{
    
    //MARK: - Variable Declaration
    private var apiController: APIControllerProtocol
    var postList = PostListModel()
    var reloadTableView: (() -> Void)?
    var createPost: (() -> Void)?
    var sortByOrder: (() -> Void)?
    var userCellViewModel = [PostCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init(userService: APIControllerProtocol = UserService()) {
        self.apiController = userService
    }
    
    
    
    func createPost(title: String,desc: String, userID: String){
        var paramDic = Dictionary<String, AnyObject>()
        paramDic ["userId"] = userID as AnyObject
        paramDic["title"] = title as AnyObject
        paramDic["body"] = desc as AnyObject
        self.apiController.postAPI(apiUrl: WebServiceURLs.postsAPI, requestParams: paramDic){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(PostListModel.self, from: responseData as! Data)
                        self.createPost?()
                    }catch let err {
                        print("Session Error: ",err)
                        self.createPost?()
                        
                        
                    }
                }
                
            }
        }
        
    }
    func post(_ id : String){
        
        self.apiController.getAPI(apiUrl: "\(WebServiceURLs.postsAPI)?userId=" + id){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(PostListModel.self, from: responseData as! Data)
                        self.postList = dicResponseData
                        self.fetchUsers(post: self.postList)
                        
                    }catch let err {
                        print("Session Error: ",err)
                        
                        
                    }
                }
                else{
                }
            }
        }
    }
    
    
    func fetchUsers(post: PostListModel) {
        self.postList = post
        var objCellModel = [PostCellViewModel]()
        for j in 0..<post.count{
            objCellModel.append(createCellModelPost(post: post[j], username: post[j].title ?? "", address: post[j].body ?? ""))
            
            
        }
        userCellViewModel = objCellModel
    }
    
    func sortByOrder(tag: Int){
        self.postList = self.postList.sorted { $0.title ?? "" > $1.title ?? "" }
        var objCellModel = [PostCellViewModel]()
        for j in 0..<self.postList.count{
            objCellModel.append(createCellModelPost(post: self.postList[j], username: self.postList[j].title ?? "", address: self.postList[j].body ?? ""))
            
            
        }
        userCellViewModel = objCellModel
        
    }
    
    //MARK: - Create cell and add data
    
    func createCellModelPost(post: PostListModelElement, username: String, address: String) -> PostCellViewModel {
        let title = post.title ?? ""
        let desc = post.body ?? ""
        
        
        return PostCellViewModel(title: title, description: desc)
    }
    //MARK: - return Cell to controller with Data
    func getCellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return userCellViewModel[indexPath.row]
    }
}
//MARK: - Variable Declaration

struct PostCellViewModel {
    var title: String
    var description: String
}


