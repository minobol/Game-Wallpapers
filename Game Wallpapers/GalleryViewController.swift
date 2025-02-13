//
//  ViewController.swift
//  Game Wallpapers
//
//  Created by MacBook on 12.02.2025.
//
//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//    
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178
//    let activeImageViewHeight: CGFloat = 318
//    let inactiveAlpha: CGFloat = 0.4
//    let cornerRadius: CGFloat = 20
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настройка UI
//        setupUI()
//
//        // Настройка слайдера
//        loadImages()
//        startTimer()
//
//        // Настройка Collection View
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//        
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//        gamesCollectionView2.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//        
//      
//    }
//
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let spacing: CGFloat = 10
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (activeImageViewWidth + spacing), y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = cornerRadius
//            imageSliderScrollView.addSubview(imageView)
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
//        }
//
//        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        imageSliderScrollView.clipsToBounds = false
//        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }
//
//    @objc func moveToNextPage() {
//        currentIndex += 1
//        if currentIndex >= images.count {
//            currentIndex = 0
//        }
//        scrollToPage(index: currentIndex, animated: true)
//    }
//
//    func scrollToPage(index: Int, animated: Bool) {
//        let spacing: CGFloat = 10
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = CGFloat(index) * (activeImageViewWidth + spacing) - inset
//        imageSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
//        pageControl.currentPage = index
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let spacing: CGFloat = 10
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let pageWidth = activeImageViewWidth + spacing
//
//        let fractionalPage = (scrollView.contentOffset.x + inset) / pageWidth
//
//        let page = round(fractionalPage)
//        pageControl.currentPage = Int(page)
//        currentIndex = Int(page)
//
//        for subview in scrollView.subviews {
//            guard let imageView = subview as? UIImageView else { continue }
//            let xPosition = imageView.frame.origin.x - scrollView.contentOffset.x
//            let distance = abs(xPosition - (scrollView.frame.width / 2 - activeImageViewWidth / 2))
//            let scale = 1 - distance / scrollView.frame.width * 0.5
//
//            imageView.alpha = max(1 - distance / (scrollView.frame.width / 2) * (1 - inactiveAlpha), inactiveAlpha)
//            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
//        }
//    }
//
//    deinit {
//        timer?.invalidate()
//    }
//}
//
//// MARK: - Collection View Delegate & DataSource
//extension GalleryViewController {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        }
//        else if (collectionView == gamesCollectionView2) {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//        
//        if collectionView == gamesCollectionView {
//                   cell.gameImageView.image = gameImages[indexPath.row]
//                   cell.gameNameLabel.text = gameNames[indexPath.row]
//               } else if collectionView == gamesCollectionView2 {
//                   cell.gameImageView.image = gameImages2[indexPath.row]
//                   cell.gameNameLabel.text = gameNames2[indexPath.row]
//               }
//        
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         return CGSize(width: 100, height: 150) // Пример: размер ячейки
//     }
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//         return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // Отступы
//     }
//}

//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//    
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178
//    let activeImageViewHeight: CGFloat = 318
//    let inactiveAlpha: CGFloat = 0.4
//    let cornerRadius: CGFloat = 20
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настройка UI
//        setupUI()
//
//        // Настройка слайдера
//        loadImages()
//        startTimer()
//
//        // Настройка Collection View
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        
//        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//        
//      
//    }
//
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let spacing: CGFloat = 10
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (activeImageViewWidth + spacing), y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = cornerRadius
//            imageSliderScrollView.addSubview(imageView)
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
//        }
//
//        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        imageSliderScrollView.clipsToBounds = false
//        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }
//
//    @objc func moveToNextPage() {
//        currentIndex += 1
//        if currentIndex >= images.count {
//            currentIndex = 0
//        }
//        scrollToPage(index: currentIndex, animated: true)
//    }
//
//    func scrollToPage(index: Int, animated: Bool) {
//        let spacing: CGFloat = 10
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = CGFloat(index) * (activeImageViewWidth + spacing) - inset
//        imageSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
//        pageControl.currentPage = index
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let page = round(imageSliderScrollView.contentOffset.x / imageSliderScrollView.frame.size.width)
//        pageControl.currentPage = Int(Int(page))
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        let page = round(imageSliderScrollView.contentOffset.x / imageSliderScrollView.frame.size.width)
//        pageControl.currentPage = Int(Int(page))
//    }
//}
//
//extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        }
//        else if (collectionView == gamesCollectionView2) {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == gamesCollectionView {
//             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//                   cell.gameImageView.image = gameImages[indexPath.row]
//                   cell.gameNameLabel.text = gameNames[indexPath.row]
//                   return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
//                   cell.gameImageView.image = gameImages2[indexPath.row]
//                   cell.gameNameLabel.text = gameNames2[indexPath.row]
//                   return cell
//               }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         return CGSize(width: 100, height: 150)
//     }
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//         return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//     }
//}
//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178
//    let activeImageViewHeight: CGFloat = 318
//    let inactiveAlpha: CGFloat = 0.4
//    let cornerRadius: CGFloat = 20
//    let spacing: CGFloat = 10 // Расстояние между изображениями
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настройка UI
//        setupUI()
//
//        // Настройка слайдера
//        loadImages()
//        startTimer()
//
//        // Настройка Collection View
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
//
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//    }
//
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let xPosition = CGFloat(i) * (activeImageViewWidth + spacing)
//            let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = cornerRadius
//            imageSliderScrollView.addSubview(imageView)
//            imageView.tag = i  // Assign tag to imageView
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
//        }
//
//        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        imageSliderScrollView.clipsToBounds = false
//        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//
//        updateImageSlider() // Initial setup
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }
//
//    @objc func moveToNextPage() {
//        currentIndex += 1
//        if currentIndex >= images.count {
//            currentIndex = 0
//        }
//        scrollToPage(index: currentIndex, animated: true)
//    }
//
//    func scrollToPage(index: Int, animated: Bool) {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = CGFloat(index) * (activeImageViewWidth + spacing) - inset
//        imageSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
//        pageControl.currentPage = index
//        updateImageSlider()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateImageSlider()
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        updateImageSlider()
//        let page = round(imageSliderScrollView.contentOffset.x / imageSliderScrollView.frame.size.width)
//        pageControl.currentPage = Int(page)
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        updateImageSlider()
//        let page = round(imageSliderScrollView.contentOffset.x / imageSliderScrollView.frame.size.width)
//        pageControl.currentPage = Int(page)
//    }
//
//    // Update image slider appearance
//    func updateImageSlider() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = imageSliderScrollView.contentOffset.x + inset
//        let fractionalPage = xOffset / (activeImageViewWidth + spacing)
//        let page = round(fractionalPage)
//
//        pageControl.currentPage = Int(page)
//
//        for i in 0..<images.count {
//            if let imageView = imageSliderScrollView.viewWithTag(i) as? UIImageView {
//                let distance = abs(CGFloat(i) - fractionalPage)
//                let scale = max(0.7, 1 - distance * 0.3)
//                let alpha = (distance > 1) ? inactiveAlpha : (1 - distance) * (1 - inactiveAlpha) + inactiveAlpha
//
//                imageView.alpha = alpha
//                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }
//    }
//}
//
//extension GalleryViewController {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        } else if collectionView == gamesCollectionView2 {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == gamesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//            cell.gameImageView.image = gameImages[indexPath.row]
//            cell.gameNameLabel.text = gameNames[indexPath.row]
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
//            cell.gameImageView.image = gameImages2[indexPath.row]
//            cell.gameNameLabel.text = gameNames2[indexPath.row]
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 150)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}

//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178
//    let activeImageViewHeight: CGFloat = 318
//    let inactiveAlpha: CGFloat = 0.4
//    let cornerRadius: CGFloat = 20
//    let spacing: CGFloat = 10 // Расстояние между изображениями
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настройка UI
//        setupUI()
//
//        // Настройка слайдера
//        loadImages()
//        startTimer()
//
//        // Настройка Collection View
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
//
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//    }
//    
//    @IBAction func infoButtonTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
//        self.navigationController?.pushViewController(aboutViewController, animated: true)
//    }
//
//
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let xPosition = CGFloat(i) * (activeImageViewWidth + spacing)
//            let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = cornerRadius
//            imageSliderScrollView.addSubview(imageView)
//            imageView.tag = i  // Assign tag to imageView
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
//        }
//
//        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        imageSliderScrollView.clipsToBounds = false
//        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//
//        updateImageSlider() // Initial setup
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }
//
//    @objc func moveToNextPage() {
//        let pageWidth = activeImageViewWidth + spacing
//        let maxOffset = imageSliderScrollView.contentSize.width - imageSliderScrollView.bounds.width
//        let currentOffset = imageSliderScrollView.contentOffset.x
//        var nextOffset = currentOffset + pageWidth
//
//        if nextOffset > maxOffset {
//            nextOffset = 0
//        }
//
//        imageSliderScrollView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
//
//        updateImageSlider()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == imageSliderScrollView {
//            updateImageSlider()
//        }
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == imageSliderScrollView {
//            updateImageSlider()
//        }
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        if scrollView == imageSliderScrollView {
//            updateImageSlider()
//        }
//    }
//
//    func updateImageSlider() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = imageSliderScrollView.contentOffset.x + inset
//        let fractionalPage = xOffset / (activeImageViewWidth + spacing)
//        let page = round(fractionalPage)
//
//        pageControl.currentPage = Int(page)
//
//        for i in 0..<images.count {
//            if let imageView = imageSliderScrollView.viewWithTag(i) as? UIImageView {
//                let distance = abs(CGFloat(i) - fractionalPage)
//                let scale = max(0.7, 1 - distance * 0.3)
//                let alpha = (distance > 1) ? inactiveAlpha : (1 - distance) * (1 - inactiveAlpha) + inactiveAlpha
//
//                imageView.alpha = alpha
//                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }
//    }
//}
//
//extension GalleryViewController {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        } else if collectionView == gamesCollectionView2 {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == gamesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//            cell.gameImageView.image = gameImages[indexPath.row]
//            cell.gameNameLabel.text = gameNames[indexPath.row]
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
//            cell.gameImageView.image = gameImages2[indexPath.row]
//            cell.gameNameLabel.text = gameNames2[indexPath.row]
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 90, height: 162)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}

//
//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Настройка UI
//        setupUI()
//
//        // Настройка Collection View
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
//    }
//
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    // MARK: - UICollectionView DataSource and Delegate
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        } else if collectionView == gamesCollectionView2 {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == gamesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//            cell.gameImageView.image = gameImages[indexPath.row]
//            cell.gameNameLabel.text = gameNames[indexPath.row]
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
//            cell.gameImageView.image = gameImages2[indexPath.row]
//            cell.gameNameLabel.text = gameNames2[indexPath.row]
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 90, height: 162) // Размер ячейки 90x162
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}
//
//
//import UIKit
//
//class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var infoButton: UIButton!
//    @IBOutlet weak var popularLabel: UILabel!
//    @IBOutlet weak var imageSliderScrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var gamesLabel: UILabel!
//    @IBOutlet weak var gamesCollectionView: UICollectionView!
//    @IBOutlet weak var gamesCollectionView2: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var gameImages2: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!
//    ]
//
//    var gameNames2: [String] = [
//        "Among Us",
//        "Halo",
//        "Red Dead Redemption",
//        "Kirby",
//        "Grand Theft Auto"
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178
//    let activeImageViewHeight: CGFloat = 318
//    let inactiveAlpha: CGFloat = 0.4
//    let cornerRadius: CGFloat = 20
//    let spacing: CGFloat = 10
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        loadImages()
//        startTimer()
//        
//        gamesCollectionView.delegate = self
//        gamesCollectionView.dataSource = self
//        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
//
//        gamesCollectionView2.delegate = self
//        gamesCollectionView2.dataSource = self
//        gamesCollectionView2.register(GameCell2.self, forCellWithReuseIdentifier: "GameCell2")
//
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//    }
//    
//    func setupUI() {
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let xPosition = CGFloat(i) * (activeImageViewWidth + spacing)
//            let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = cornerRadius
//            imageSliderScrollView.addSubview(imageView)
//            imageView.tag = i
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha
//        }
//
//        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        imageSliderScrollView.clipsToBounds = false
//        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//
//        updateImageSlider()
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }
//
//    @objc func moveToNextPage() {
//        let pageWidth = activeImageViewWidth + spacing
//        let maxOffset = imageSliderScrollView.contentSize.width - imageSliderScrollView.bounds.width
//        let currentOffset = imageSliderScrollView.contentOffset.x
//        var nextOffset = currentOffset + pageWidth
//
//        if nextOffset > maxOffset {
//            nextOffset = 0
//        }
//
//        imageSliderScrollView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
//
//        updateImageSlider()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == imageSliderScrollView {
//            updateImageSlider()
//        }
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == imageSliderScrollView {
//            updateImageSlider()
//        }
//    }
//
//    func updateImageSlider() {
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//        let xOffset = imageSliderScrollView.contentOffset.x + inset
//        let fractionalPage = xOffset / (activeImageViewWidth + spacing)
//        let page = round(fractionalPage)
//
//        pageControl.currentPage = Int(page)
//
//        for i in 0..<images.count {
//            if let imageView = imageSliderScrollView.viewWithTag(i) as? UIImageView {
//                let distance = abs(CGFloat(i) - fractionalPage)
//                let scale = max(0.7, 1 - distance * 0.3)
//                let alpha = (distance > 1) ? inactiveAlpha : (1 - distance) * (1 - inactiveAlpha) + inactiveAlpha
//
//                imageView.alpha = alpha
//                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == gamesCollectionView {
//            return gameImages.count
//        } else if collectionView == gamesCollectionView2 {
//            return gameImages2.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == gamesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//            cell.gameImageView.image = gameImages[indexPath.row]
//            cell.gameNameLabel.text = gameNames[indexPath.row]
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
//            cell.gameImageView.image = gameImages2[indexPath.row]
//            cell.gameNameLabel.text = gameNames2[indexPath.row]
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 90, height: 162)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}

import UIKit

class GalleryViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell2", for: indexPath) as! GameCell2
            cell.gameImageView.image = gameImages2[indexPath.row]
            cell.gameNameLabel.text = gameNames2[indexPath.row]
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
}
