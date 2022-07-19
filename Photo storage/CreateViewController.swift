
import UIKit

class CreateViewController: UIViewController {
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if self.firstTextField.text == self.secondTextField.text {
            let password = SaveData(password: self.secondTextField.text!)
            UserDefaults.standard.set(encodable: password, forKey: "password")
            self.navigationController?.popViewController(animated: true)
            print(password.password)
        } else {
            self.showAlert()
        }
    }
    
    private func showAlert(){
        let allert = UIAlertController(title:" Wrong password", message: "please try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        allert.addAction(okAction)
        present(allert, animated: true, completion: nil)

    }

}
