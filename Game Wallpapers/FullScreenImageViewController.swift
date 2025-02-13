//
//  FullScreenImageViewController.swift
//  Game Wallpapers
//
//  Created by MacBook on 13.02.2025.
//

//import UIKit
//
//class FullScreenImageViewController: UIViewController {
//    var image: UIImage?
//    
//    private let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    private func setupUI() {
//        view.backgroundColor = .black
//        view.addSubview(imageView)
//        imageView.image = image
//        
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: view.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}

//import UIKit
//
//class FullScreenImageViewController: UIViewController {
//    @IBOutlet var fullScreenImageView: UIImageView!
//    @IBOutlet var installFullButton: UIButton!
//    
//    var image: UIImage?
//    var imageId: Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fullScreenImageView.image = image
//    }
//    
//    @IBAction func installFullButtonAction(_ sender: Any) {
//    }
//}

import UIKit

class FullScreenImageViewController: UIViewController {
    @IBOutlet var fullScreenImageView: UIImageView!
    @IBOutlet var installFullButton: UIButton!
    
    var image: UIImage?
    var imageId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenImageView.image = image
    }
    
    @IBAction func installFullButtonAction(_ sender: Any) {
        guard let imageToSave = fullScreenImageView.image else {
            print("No image to save")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
            // Здесь можно показать пользователю сообщение об ошибке
        } else {
            print("Image saved successfully")
            // Здесь можно показать пользователю сообщение об успехе
        }
    }
}
