
import UIKit

class PostsVC: UIViewController {
    
    @IBOutlet weak var tblPosts: UITableView!
    
    @IBOutlet weak var btnCreatePost: UIButton!
    
    @IBOutlet weak var btnSubmitOut: UIButton!
    @IBOutlet weak var txtVwDesc: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var vwNewPost: UIView!
    @IBOutlet weak var vwBlur: UIView!
    @IBAction func btnCreatePostAct(_ sender: Any) {
        self.vwBlur.isHidden = false
        self.vwNewPost.isHidden = false
    }
    
    
    var strUserID = ""
    //MARK: - Variable Declaration
    lazy var postVCViewModel = {
        PostVCViewModel()
    }()
    
    
    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Initialization Method
    
    func initView() {
        self.navigationItem.title = "Posts"
        tblPosts.register(PostsTblCell.nib, forCellReuseIdentifier: PostsTblCell.identifier)
        tblPosts.tableFooterView = UIView()
        tblPosts.separatorStyle = .none
        tblPosts.allowsSelection = false
    }
    
    func initViewModel() {
        postVCViewModel.post(strUserID)
        // Reload TableView closure
        postVCViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tblPosts.reloadData()
            }
        }
    }
    @IBAction func btnSort(_ sender: Any) {
        postVCViewModel.sortByOrder(tag: 0)
        postVCViewModel.sortByOrder = { [weak self] in
            DispatchQueue.main.async {
                self?.tblPosts.reloadData()
            }
        }    }
    @IBAction func btnSubmitAct(_ sender: Any) {
        if Validation().isEmpty(txtField: txtTitle.text ?? ""){
            showToast(message:AlertMessage.msgTitlePost)
        }else  if Validation().isEmpty(txtField: txtVwDesc.text ?? "") {
            showToast(message:AlertMessage.msgDescPost)
        }else{
            postVCViewModel.createPost(title: txtTitle.text ?? "", desc: txtVwDesc.text ?? "", userID: strUserID)
            postVCViewModel.createPost = { [weak self] in
                DispatchQueue.main.async {
                    self?.vwBlur.isHidden = true
                    self?.vwNewPost.isHidden = true
                }
            }
        }
    }
    
    
}

//MARK: - Post Delegate Extension

extension PostsVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postVCViewModel.userCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.cellPostTbl, for: indexPath) as? PostsTblCell else { fatalError("xib does not exists") }
        let cellVM = postVCViewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
}
extension UIViewController {
    
    func showToast(message : String){
        var toastLabel =  UILabel()
        
        
        toastLabel = UILabel(frame: CGRect(x: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame.size.width)!/2 - 150, y: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame.size.height)!-100, width:300,  height : 50))
        toastLabel.font = UIFont(name: "Lato", size: 18.0)
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center;
        let window: UIWindow? = UIApplication.shared.windows.last
        window?.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 7, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        })
    }
}
