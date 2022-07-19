
import UIKit

class StarViewController: UIViewController {
    @IBOutlet var inputPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let controller = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let password = UserDefaults.standard.value(SaveData.self, forKey: "password")
        print(password?.password)
        if self.inputPasswordTextField.text == password?.password {
            guard let controller = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            showAlert()
        }
    }
    
    private func showAlert(){
        let allert = UIAlertController(title:" Wrong password", message: "please try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        allert.addAction(okAction)
        present(allert, animated: true, completion: nil)

    }
    
    
}
