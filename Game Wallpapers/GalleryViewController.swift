import UIKit

// MARK: - GalleryViewController
class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GameCellDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var imageSliderScrollView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var gamesCollectionView2: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!

    var images: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "gaming club")!
    ]

    var gameImages: [UIImage] = [
        UIImage(named: "Among Us")!,
        UIImage(named: "Halo")!,
        UIImage(named: "Red Dead Redemption")!,
        UIImage(named: "Kirby")!,
        UIImage(named: "The Last of Us")!
    ]

    var gameNames: [String] = [
        "Among Us",
        "Halo",
        "Red Dead Redemption",
        "Kirby",
        "The Last of Us"
    ]

    var gameImages2: [UIImage] = [
        UIImage(named: "Grand Theft Auto: San Andreas")!,
        UIImage(named: "image3")!,
        UIImage(named: "Minecraft")!,
        UIImage(named: "image2")!,
        UIImage(named: "Hollow Knight")!
    ]

    var gameNames2: [String] = [
        "Grand Theft Auto: San Andreas",
        "The Legend of Zelda",
        "Minecraft",
        "Mario & Sonic",
        "Hollow Knight"
    ]

    var timer: Timer?
    var currentIndex = 0
    let activeImageViewWidth: CGFloat = 178
    let activeImageViewHeight: CGFloat = 318
    let dimmedAlpha: CGFloat = 0.4
    let cornerRadius: CGFloat = 20
    let spacing: CGFloat = 10
    var isScrolling = false
    let sideImageWidth: CGFloat = 156
    let sideImageHeight: CGFloat = 283
    let normalAlpha: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupImageSliderCollectionView()
        startTimer()

        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")

        gamesCollectionView2.delegate = self
        gamesCollectionView2.dataSource = self
        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
    }
    
    func setupUI() {
        view.backgroundColor = .black
        titleLabel.textColor = .white
        popularLabel.textColor = .white
        gamesLabel.textColor = .white
    }

    func setupImageSliderCollectionView() {
        let layout = CustomFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: activeImageViewWidth, height: activeImageViewHeight)

        let insetX = (view.bounds.width - activeImageViewWidth) / 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
      
        layout.sideItemScale = sideImageWidth / activeImageViewWidth
        layout.sideItemAlpha = dimmedAlpha

        imageSliderScrollView.collectionViewLayout = layout
        imageSliderScrollView.isPagingEnabled = false
        imageSliderScrollView.showsHorizontalScrollIndicator = false

        imageSliderScrollView.register(ImageSliderCell.self, forCellWithReuseIdentifier: "ImageSliderCell")
        imageSliderScrollView.dataSource = self
        imageSliderScrollView.delegate = self

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage() {
        if !isScrolling {
            let nextIndex = (currentIndex + 1) % images.count
            scrollToIndex(nextIndex)
            pageControl.currentPage = nextIndex
            currentIndex = nextIndex
        }
    }

    func scrollToIndex(_ index: Int) {
        guard index >= 0 && index < images.count else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        imageSliderScrollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = index
        currentIndex = index
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageSliderScrollView {
            return images.count
        } else if collectionView == gamesCollectionView {
            return gameImages.count
        } else if collectionView == gamesCollectionView2 {
            return gameImages2.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageSliderScrollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCell", for: indexPath) as! ImageSliderCell
            cell.imageView.image = images[indexPath.item]
            return cell
        } else if collectionView == gamesCollectionView {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedImage: UIImage?

        if collectionView == imageSliderScrollView {
            selectedImage = images[indexPath.item]
        }
        else if collectionView == gamesCollectionView {
            selectedImage = gameImages[indexPath.row]
        } else if collectionView == gamesCollectionView2 {
            selectedImage = gameImages2[indexPath.row]
        }

        guard let image = selectedImage else {
            print("No image selected")
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let fullScreenVC = storyboard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController else {
            print("Could not instantiate FullScreenImageViewController")
            return
        }
        
        fullScreenVC.image = image
        fullScreenVC.imageId = indexPath.row

        self.present(fullScreenVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageSliderScrollView {
            return CGSize(width: activeImageViewWidth, height: activeImageViewHeight)
        } else {
            return CGSize(width: 90, height: 206)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == imageSliderScrollView {
            let insetX = (view.bounds.width - activeImageViewWidth) / 2.0
            return UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = true
            timer?.invalidate()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = false

            let visibleRect = CGRect(origin: imageSliderScrollView.contentOffset, size: imageSliderScrollView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

            if let indexPath = imageSliderScrollView.indexPathForItem(at: visiblePoint) {
                currentIndex = indexPath.item
                pageControl.currentPage = currentIndex
            }

            startTimer()
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = false
        }
    }

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

// MARK: - ImageSliderCell

class ImageSliderCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.alpha = 1.0
    }
}

// MARK: - CustomFlowLayout
class CustomFlowLayout: UICollectionViewFlowLayout {
    
    var sideItemScale: CGFloat = 1.0
    var sideItemAlpha: CGFloat = 1.0

    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 10
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let centerX = visibleRect.midX

        return super.layoutAttributesForElements(in: rect)?.map { attributes in
            let distance = abs(attributes.center.x - centerX)
            let scale = sideItemScale + (1 - sideItemScale) * (1 - distance / (collectionView.bounds.width / 2))
            let alpha = sideItemAlpha + (1 - sideItemAlpha) * (1 - distance / (collectionView.bounds.width / 2))

            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
            attributes.alpha = alpha
            return attributes
        }
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let layoutAttributes = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + (collectionView.bounds.width / 2)

        for layoutAttribute in layoutAttributes {
            let itemHorizontalCenter = layoutAttribute.center.x
            if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
