
import UIKit

class PostsTblCell: UITableViewCell {
    @IBOutlet weak var lblPostTitle: UILabel!
    
    @IBOutlet weak var vwOut: UIView!
    @IBOutlet weak var lblPostBody: UILabel!
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    //MARK: - Variable Declaration
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    var cellViewModel: PostCellViewModel? {
        // Set values in cell
        didSet {
            lblPostTitle.text = cellViewModel?.title
            lblPostBody.text = cellViewModel?.description
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
        lblPostTitle.text = nil
        lblPostBody.text = nil
    }
}
