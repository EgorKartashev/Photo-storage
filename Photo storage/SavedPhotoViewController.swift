
import UIKit

class SavedPhotoViewController: UIViewController {

    @IBOutlet var loadImageView: UIImageView!
    
    var arrayOfImages: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        print(arrayOfImages)
    }
    
    func loadImage(fileName: String) -> UIImage? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageURL = documentDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image
        }
        return nil
    }
}
