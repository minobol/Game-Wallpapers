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
//
//    // Объявите переменные, массивы с данными
//    var images: [UIImage] = [
//        UIImage(named: "image1")!, // Замените на ваши реальные изображения
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!
//    ]
//
//    var gameImages: [UIImage] = [
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image1")!
//    ]
//
//    var timer: Timer?
//    var currentIndex = 0
//    let activeImageViewWidth: CGFloat = 178 // Новая ширина активного изображения
//    let activeImageViewHeight: CGFloat = 318 // Новая высота активного изображения
//    let inactiveAlpha: CGFloat = 0.4 // Прозрачность для неактивных изображений
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
//        imageSliderScrollView.delegate = self
//        imageSliderScrollView.showsHorizontalScrollIndicator = false
//    }
//
//    func setupUI() {
//       // Здесь дополнительные настройки UI, например, цвет фона и текста
//        view.backgroundColor = .black
//        titleLabel.textColor = .white
//        popularLabel.textColor = .white
//        gamesLabel.textColor = .white
//    }
//
//    func loadImages() {
//        let spacing: CGFloat = 10 // Расстояние между изображениями
//        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
//
//        for i in 0..<images.count {
//            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (activeImageViewWidth + spacing), y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
//            imageView.image = images[i]
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true // Обрезаем изображение по границам
//            imageView.layer.cornerRadius = cornerRadius // Добавляем радиус скругления
//            imageSliderScrollView.addSubview(imageView)
//            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha // Первое изображение активное
//
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
//        return gameImages.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
//        cell.gameImageView.image = gameImages[indexPath.row]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 150) // Пример: размер ячейки
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // Отступы
//    }
//}
//
//// MARK: - GameCell Class
//class GameCell: UICollectionViewCell {
//
//    let gameImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(gameImageView)
//        gameImageView.frame = contentView.bounds // Заполнение всей ячейки
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
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

    // Объявите переменные, массивы с данными
    var images: [UIImage] = [
        UIImage(named: "image1")!, // Замените на ваши реальные изображения
        UIImage(named: "image2")!,
        UIImage(named: "image3")!
    ]

    var gameImages: [UIImage] = [
        UIImage(named: "image1")!, // Замените на ваши реальные изображения
        UIImage(named: "image2")!,
        UIImage(named: "image1")!, // Замените на ваши реальные изображения
        UIImage(named: "image2")!,
        UIImage(named: "image3")!
    ]

    var gameNames: [String] = [
        "Among Us",
        "Halo",
        "Red Dead Redemption",
        "Kirby",
        "Grand Theft Auto"
    ]

    var timer: Timer?
    var currentIndex = 0
    let activeImageViewWidth: CGFloat = 178 // Новая ширина активного изображения
    let activeImageViewHeight: CGFloat = 318 // Новая высота активного изображения
    let inactiveAlpha: CGFloat = 0.4 // Прозрачность для неактивных изображений
    let cornerRadius: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка UI
        setupUI()

        // Настройка слайдера
        loadImages()
        startTimer()

        // Настройка Collection View
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")

        imageSliderScrollView.delegate = self
        imageSliderScrollView.showsHorizontalScrollIndicator = false
    }

    func setupUI() {
       // Здесь дополнительные настройки UI, например, цвет фона и текста
        view.backgroundColor = .black
        titleLabel.textColor = .white
        popularLabel.textColor = .white
        gamesLabel.textColor = .white
    }

    func loadImages() {
        let spacing: CGFloat = 10 // Расстояние между изображениями
        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2

        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * (activeImageViewWidth + spacing), y: 0, width: activeImageViewWidth, height: activeImageViewHeight))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true // Обрезаем изображение по границам
            imageView.layer.cornerRadius = cornerRadius // Добавляем радиус скругления
            imageSliderScrollView.addSubview(imageView)
            imageView.alpha = (i == 0) ? 1.0 : inactiveAlpha // Первое изображение активное

        }

        imageSliderScrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        imageSliderScrollView.clipsToBounds = false
        imageSliderScrollView.contentSize = CGSize(width: CGFloat(images.count) * (activeImageViewWidth + spacing), height: activeImageViewHeight)
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage() {
        currentIndex += 1
        if currentIndex >= images.count {
            currentIndex = 0
        }
        scrollToPage(index: currentIndex, animated: true)
    }

    func scrollToPage(index: Int, animated: Bool) {
        let spacing: CGFloat = 10
        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
        let xOffset = CGFloat(index) * (activeImageViewWidth + spacing) - inset
        imageSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
        pageControl.currentPage = index
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let spacing: CGFloat = 10
        let inset = (imageSliderScrollView.frame.width - activeImageViewWidth) / 2
        let pageWidth = activeImageViewWidth + spacing

        let fractionalPage = (scrollView.contentOffset.x + inset) / pageWidth

        let page = round(fractionalPage)
        pageControl.currentPage = Int(page)
        currentIndex = Int(page)

        for subview in scrollView.subviews {
            guard let imageView = subview as? UIImageView else { continue }
            let xPosition = imageView.frame.origin.x - scrollView.contentOffset.x
            let distance = abs(xPosition - (scrollView.frame.width / 2 - activeImageViewWidth / 2))
            let scale = 1 - distance / scrollView.frame.width * 0.5

            imageView.alpha = max(1 - distance / (scrollView.frame.width / 2) * (1 - inactiveAlpha), inactiveAlpha)
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    deinit {
        timer?.invalidate()
    }
}

// MARK: - Collection View Delegate & DataSource
extension GalleryViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.gameImageView.image = gameImages[indexPath.row]
        cell.gameNameLabel.text = gameNames[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150) // Пример: размер ячейки
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // Отступы
    }
}
