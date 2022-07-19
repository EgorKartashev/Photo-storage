

import UIKit

class AddNewPhotoViewController: UIViewController {
    @IBOutlet var addImageView: UIImageView!
    var arrayOfImageView: [UIImage]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
        if let image = self.addImageView.image{
            let nameImage = saveImage(Image: image)
            UserDefaults.standard.set(nameImage, forKey: "image")
        }
        guard let imageName =  UserDefaults.standard.value(forKey: "image") as? String else {return}
        if let image = loadImage(fileName: imageName) {
            self.arrayOfImageView.append(image)
            print(arrayOfImageView!)
        }
        let controller = UIStoryboard(name: "AddNewPhotoViewController", bundle: nil).instantiateViewController(withIdentifier: "SavedPhotoViewController") as! SavedPhotoViewController
        controller.arrayOfImages = self.arrayOfImageView
    }
    
    
    
    
    private func saveImage(Image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil} // проверяем имя в папке приложения
        
        let fileName = UUID().uuidString // это имя файла ( в консоли это символы просто)
        let fileURL = documentsDirectory.appendingPathComponent(fileName) // путь файла
        guard let data = Image.jpegData(compressionQuality: 1) else {return nil} // берем файл по имени и переводим в jpg, 1 это качестов то есть без сжатия)
        
        // проверка на повтор имени файла в заданом пути. так же проверям что бы не удалить файл во время его использования с помощью do + catch
        if FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Remove old image")
            } catch let error {
                print("Couldn't remove file at path", error)
            }
        }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
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

extension AddNewPhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // проверка изменили ли фото? если да то юзаем его
        var chosenImage = UIImage()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            chosenImage = image
        }
        self.addImageView.image = chosenImage
        
        picker.dismiss(animated: true)
    }
}
