
import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var tblUsers: UITableView!
    //MARK: - Variable Declaration
    lazy var userVCModel = {
        UsersVCViewModel()
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
        tblUsers.register(UsersTblCell.nib, forCellReuseIdentifier: UsersTblCell.identifier)
        tblUsers.tableFooterView = UIView()
        tblUsers.separatorStyle = .none
       // tblUsers.allowsSelection = false
    }
    
    func initViewModel() {
        userVCModel.get()
        // Reload TableView closure
        userVCModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tblUsers.reloadData()
            }
        }
    }
}

//MARK: - Post Delegate Extension

extension UsersVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userVCModel.userCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.cellUserTbl, for: indexPath) as? UsersTblCell else { fatalError("xib does not exists") }
        let cellVM = userVCModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objCreateShiftVC = self.storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        objCreateShiftVC.strUserID = userVCModel.userCellViewModel[indexPath.row].userID
       
        
        self.navigationController?.pushViewController(objCreateShiftVC, animated: true)
    }
}

