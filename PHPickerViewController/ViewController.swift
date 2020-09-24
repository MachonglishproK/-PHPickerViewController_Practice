//
//  ViewController.swift
//  PHPickerViewController
//
//  Created by 伊藤走 on 9/24/20.
//

import UIKit
import PhotosUI


class ViewController: UIViewController {
    
    
    @IBOutlet var cameraImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func takePhotoBtn(_ sender: Any) {
        configurePhotoPicker()
    }
}

extension ViewController: PHPickerViewControllerDelegate{
    
    func configurePhotoPicker(){
        // Pickerの設定
        var config = PHPickerConfiguration()
        // Pickerで選択するメディアの種類をフィルタリング
        config.filter = .images
        // 選択できる数を指定
        config.selectionLimit = 1
        // configを渡して初期化
        let controller = PHPickerViewController(configuration:config)
        // delegateをセット
        controller.delegate = self
        // 表示
        present(controller, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       dismiss(animated: true, completion: nil)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self)
            { [weak self]  image, error in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let image = image as? UIImage {
                        self.display(image: image)
                    } else {
                        print("error")
                    }
                }
            }
        }
    }
    
    
    
    func display(image: UIImage){
        cameraImageView.image = image
        
    }
}
