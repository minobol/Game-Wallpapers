import UIKit

// MARK: - GameCell
class GameCell: UICollectionViewCell {
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.7)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    var indexPath: IndexPath?
    weak var delegate: GameCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(downloadButton)

        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalToConstant: 162),

            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            downloadButton.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: -5),
            downloadButton.widthAnchor.constraint(equalToConstant: 30),
            downloadButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }

    @objc func downloadButtonTapped() {
        delegate?.downloadButtonTapped(at: indexPath!)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameNameLabel.text = nil
    }
}

// MARK: - GameCell2
class GameCell2: UICollectionViewCell {
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 0.7)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    var indexPath: IndexPath?
    weak var delegate: GameCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(downloadButton)

        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalToConstant: 162),

            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            downloadButton.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: -5),
            downloadButton.widthAnchor.constraint(equalToConstant: 30),
            downloadButton.heightAnchor.constraint(equalToConstant: 30)
        ])

        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }

    @objc func downloadButtonTapped() {
        delegate?.downloadButtonTapped(at: indexPath!)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameNameLabel.text = nil
    }
}

// MARK: - GameCellDelegate
protocol GameCellDelegate: AnyObject {
    func downloadButtonTapped(at indexPath: IndexPath)
}
