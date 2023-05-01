
import UIKit

class UsersTblCell: UITableViewCell {
    //MARK: -  Outlets

    @IBOutlet weak var vwOut: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    //MARK: - Variable Declaration
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    var cellViewModel: UserCellViewModel? {
        // Set values in cell
        didSet {
            lblUsername.text = cellViewModel?.username
            lblAddress.text = cellViewModel?.address
        }
    }
    
    //MARK: - Initialization Method
    
    func initView() {
        // Cell view customization
        preservesSuperviewLayoutMargins = false
        vwOut.layer.cornerRadius = 10
    }
    
    //MARK: - Default Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()    // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblUsername.text = nil
        lblAddress.text = nil
    }
}
