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
    let inactiveAlpha: CGFloat = 0.4
    let cornerRadius: CGFloat = 20
    let spacing: CGFloat = 10
    
    var isScrolling = false // Track user-initiated scrolling

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

    // MARK: - Image Slider Collection View Setup
    func setupImageSliderCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: activeImageViewWidth, height: activeImageViewHeight)

        // Настраиваем отступы, чтобы центральное изображение находилось в центре экрана
        let insetX = (view.bounds.width - activeImageViewWidth) / 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)

        imageSliderScrollView.collectionViewLayout = layout
        imageSliderScrollView.isPagingEnabled = false // Отключаем стандартный пейджинг
        imageSliderScrollView.showsHorizontalScrollIndicator = false

        imageSliderScrollView.register(ImageSliderCell.self, forCellWithReuseIdentifier: "ImageSliderCell")
        imageSliderScrollView.dataSource = self
        imageSliderScrollView.delegate = self

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
    }

    func startTimer() {
        timer?.invalidate() // Stop any existing timer
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage() {
        if !isScrolling { // Prevent automatic scrolling during manual scroll
            let nextIndex = (currentIndex + 1) % images.count
            scrollToIndex(nextIndex)
            pageControl.currentPage = nextIndex // Обновляем текущую страницу на pageControl
            currentIndex = nextIndex // Обновляем currentIndex для таймера
        }
    }

    func scrollToIndex(_ index: Int) {
        guard index >= 0 && index < images.count else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        
        // Прокрутка к элементу с анимацией.
        imageSliderScrollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // Обновляем текущий индекс и номер страницы.
        pageControl.currentPage = index
        currentIndex = index
    }

    
    // MARK: - UICollectionViewDataSource

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

    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageSliderScrollView {
            return CGSize(width: activeImageViewWidth, height: activeImageViewHeight)
        } else {
            return CGSize(width: 90, height: 162)
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

    
   // MARK: - UIScrollViewDelegate

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = true // Пользователь начал прокрутку
            timer?.invalidate() // Остановите таймер
        }
   }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = false // Пользователь закончил прокрутку

            let layout = imageSliderScrollView.collectionViewLayout as! UICollectionViewFlowLayout
            let visibleRect = CGRect(origin: imageSliderScrollView.contentOffset, size: imageSliderScrollView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

            if let indexPath = imageSliderScrollView.indexPathForItem(at: visiblePoint) {
                currentIndex = indexPath.item // Обновите currentIndex
                pageControl.currentPage = currentIndex
            }

            startTimer() // Перезапустите таймер
        }
   }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == imageSliderScrollView {
            isScrolling = false // Конец программной прокрутки
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
        imageView.image = nil // Ensure image is reset for cell reuse
    }
}
