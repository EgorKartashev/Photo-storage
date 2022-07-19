
import UIKit

class AddPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func menuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
