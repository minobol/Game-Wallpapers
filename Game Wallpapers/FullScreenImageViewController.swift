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
        showActivityIndicator()
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        hideActivityIndicator()
        if let error = error {
            showAlert(title: "Ошибка", message: "Не удалось сохранить изображение: \(error.localizedDescription)")
            print("Error saving image: \(error.localizedDescription)")
        } else {
            showAlert(title: "Успех", message: "Изображение успешно сохранено в фотоальбом.")
            print("Image saved successfully")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    private func hideActivityIndicator() {
        view.subviews.forEach {
            if let activityIndicator = $0 as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
