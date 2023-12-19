
import UIKit
import Kingfisher
import SnapKit


class SearchCollectionCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(imdbLabel)
        contentView.addSubview(overviewLabel)
     
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(4)
            make.height.equalTo(20)
            make.top.equalToSuperview().inset(8)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing ).offset(10)
            make.width.height.equalTo(20)
        }
        
        imdbLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom)
            make.trailing.bottom.equalToSuperview().inset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
        }
    }
    
    func configure(with movie: MovieResult) {
        nameLabel.text = movie.title
        imdbLabel.text = "IMDB: \(movie.voteAverage ?? 0)"
        overviewLabel.text = movie.overview
        
        let imageUrl = "\(NetworkHelper.imagePath)\(movie.posterPath ?? "")"
                posterImageView.loadImage(url: imageUrl)
    }
}
