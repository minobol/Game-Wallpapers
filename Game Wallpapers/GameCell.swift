//
//  GameCell.swift
//  Game Wallpapers
//
//  Created by MacBook on 12.02.2025.
//

//import UIKit
//
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
//    let gameNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(gameImageView)
//        contentView.addSubview(gameNameLabel)
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            gameImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
//
//            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
//            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}
//
//import UIKit
//
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
//    let gameNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(gameImageView)
//        contentView.addSubview(gameNameLabel)
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            gameImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
//
//            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
//            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}
//class GameCell2: UICollectionViewCell {
//
//       let gameImageView: UIImageView = {
//           let imageView = UIImageView()
//           imageView.contentMode = .scaleAspectFill
//           imageView.clipsToBounds = true
//           imageView.translatesAutoresizingMaskIntoConstraints = false
//           return imageView
//       }()
//
//       let gameNameLabel: UILabel = {
//           let label = UILabel()
//           label.textAlignment = .center
//           label.textColor = .white
//           label.font = UIFont.systemFont(ofSize: 12)
//           label.translatesAutoresizingMaskIntoConstraints = false
//           return label
//       }()
//
//       override init(frame: CGRect) {
//           super.init(frame: frame)
//           contentView.addSubview(gameImageView)
//           contentView.addSubview(gameNameLabel)
//           setupConstraints()
//       }
//
//       required init?(coder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
//
//       func setupConstraints() {
//           NSLayoutConstraint.activate([
//               gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//               gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//               gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//               gameImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
//
//               gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
//               gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//               gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//               gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//           ])
//       }
//   }

import UIKit

class GameCell: UICollectionViewCell {

    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12 // Скругление углов 12 пикселей
        imageView.layer.masksToBounds = true // Обязательно для применения скругления
        return imageView
    }()

    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   private func setupConstraints() {
       NSLayoutConstraint.activate([
           gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
           gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           gameImageView.heightAnchor.constraint(equalToConstant: 120), // Высота изображения (70% от ячейки)

           gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
           gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
       ])
   }
}

class GameCell2: UICollectionViewCell {

    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12 // Скругление углов 12 пикселей
        imageView.layer.masksToBounds = true // Обязательно для применения скругления
        return imageView
    }()

    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   private func setupConstraints() {
       NSLayoutConstraint.activate([
           gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
           gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           gameImageView.heightAnchor.constraint(equalToConstant: 120), // Высота изображения (70% от ячейки)

           gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
           gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
       ])
   }
}
