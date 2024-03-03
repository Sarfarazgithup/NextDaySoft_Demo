
import UIKit

class saveDataTableViewCell: UITableViewCell {
    @IBOutlet weak var stepperBtn: UIStepper!
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var batchNo: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        myImage.layer.cornerRadius = 16
        buyBtn.layer.cornerRadius = 8
        stepperBtn.layer.cornerRadius = 8
        stepperBtn.isHidden = true
    }

    @IBAction func buyActionBtn(_ sender: Any) {
        buyBtn.isHidden = true
        stepperBtn.isHidden = false
        
        
    }
    
    
    @IBAction func stepperActionBtn(_ sender: Any) {
        print("Stepper value changed to ")
       
        
    }
    
    
}
