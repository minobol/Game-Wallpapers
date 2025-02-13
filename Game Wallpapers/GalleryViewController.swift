import UIKit

// MARK: - GalleryViewController
class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GameCellDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var imageSliderScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var gamesCollectionView2: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!

    var images: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!
    ]

    var gameImages: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!
    ]

    var gameNames: [String] = [
        "Among Us",
        "Halo",
        "Red Dead Redemption",
        "Kirby",
        "Grand Theft Auto"
    ]

    var gameImages2: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!
    ]

    var gameNames2: [String] = [
        "Among Us",
        "Halo",
        "Red Dead Redemption",
        "Kirby",
        "Grand Theft Auto"
    ]

    var timer: Timer?
    var currentIndex = 0
    let activeImageViewWidth: CGFloat = 178
    let activeImageViewHeight: CGFloat = 318
    let inactiveAlpha: CGFloat = 0.4
    let cornerRadius: CGFloat = 20
    let spacing: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImages()
        startTimer()
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")

        gamesCollectionView2.delegate = self
        gamesCollectionView2.dataSource = self
        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")

        imageSliderScrollView.delegate = self
        imageSliderScrollView.showsHorizontalScrollIndicator = false
    }
    
    func setupUI() {
        view.backgroundColor = .black
        titleLabel.textColor = .white
        popularLabel.textColor = .white
        gamesLabel.textColor = .white
    }

    func loadImages() {
        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2

        for i in 0..<images.count {
            let xPosition = CGFloat(i) * (activeImageViewWidth + spacing)
            let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = cornerRadius
            imageSliderScrollView.addSubview(imageView)
            imageView.tag = i
            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.isUserInteractionEnabled = true
        }

        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        imageSliderScrollView.clipsToBounds = false
        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0

        updateImageSlider()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage() {
        let pageWidth = activeImageViewWidth + spacing
        let maxOffset = imageSliderScrollView.contentSize.width - imageSliderScrollView.bounds.width
        let currentOffset = imageSliderScrollView.contentOffset.x
        var nextOffset = currentOffset + pageWidth

        if nextOffset > maxOffset {
            nextOffset = 0
        }
        imageSliderScrollView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        updateImageSlider()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            updateImageSlider()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            updateImageSlider()
        }
    }

    func updateImageSlider() {
        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
        let xOffset = imageSliderScrollView.contentOffset.x + inset
        let fractionalPage = xOffset / (activeImageViewWidth + spacing)
        let page = round(fractionalPage)

        pageControl.currentPage = Int(page)

        for i in 0..<images.count {
            if let imageView = imageSliderScrollView.viewWithTag(i) as? UIImageView {
                let distance = abs(CGFloat(i) - fractionalPage)
                let scale = max(0.7, 1 - distance * 0.3)
                let alpha = (distance > 1) ? inactiveAlpha : (1 - distance) * (1 - inactiveAlpha) + inactiveAlpha

                imageView.alpha = alpha
                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gamesCollectionView {
            return gameImages.count
        } else if collectionView == gamesCollectionView2 {
            return gameImages2.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
            cell.gameImageView.image = gameImages[indexPath.row]
            cell.gameNameLabel.text = gameNames[indexPath.row]
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
            cell.gameImageView.image = gameImages2[indexPath.row]
            cell.gameNameLabel.text = gameNames2[indexPath.row]
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 162)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let fullScreenVC = storyboard?.instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController {
            if collectionView == gamesCollectionView {
                fullScreenVC.image = gameImages[indexPath.row]
                fullScreenVC.imageId = indexPath.row
            } else if collectionView == gamesCollectionView2 {
                fullScreenVC.image = gameImages2[indexPath.row]
                fullScreenVC.imageId = indexPath.row + gameImages.count
            }
            present(fullScreenVC, animated: true, completion: nil)
        }
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedImageView = gesture.view as? UIImageView else { return }
        if let fullScreenVC = storyboard?.instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController {
            fullScreenVC.image = tappedImageView.image
            fullScreenVC.imageId = tappedImageView.tag
            present(fullScreenVC, animated: true, completion: nil)
        }
    }

    // MARK: - GameCellDelegate
    func downloadButtonTapped(at indexPath: IndexPath) {
        var imageToSave: UIImage?

        if indexPath.section == 0 {
            imageToSave = gameImages[indexPath.row]
        } else if indexPath.section == 1 {
            imageToSave = gameImages2[indexPath.row]
        }

        guard let image = imageToSave else {
            print("No image to save")
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully")
        }
    }
}
