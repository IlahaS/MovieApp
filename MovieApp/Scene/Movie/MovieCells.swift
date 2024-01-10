import UIKit
import SnapKit

//MARK: Image Cell
class MovieImageCell: UICollectionViewCell {
    
    public let reuseID = "MovieImageCell"
    
    let image: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        //image.contentMode = .scaleAspectFit
       return image
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(path : String){
        let imageURL = "\(NetworkHelper.imagePath)\(path)"
        image.loadImage(url: imageURL)
        image.contentMode = .scaleToFill
    }
}

//MARK: Title Cell
class MovieTitleCell: UICollectionViewCell {
    let reuseID = "MovieTitleCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 2
        return label
    }()
    
    private let saveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bookmark")
        image.tintColor = .black
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //titleLabel.frame = contentView.bounds
        addSubview(titleLabel)
        addSubview(saveImage)
        //print(titleLabel)
        saveImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(28)
            //make.leading.equalTo(titleLabel.snp.trailing).offset(16)
            make.height.width.equalTo(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalTo(saveImage.snp.leading).offset(-12)
        }
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (controller: UIViewController, previousTraitCollection: UITraitCollection) in
            self.updateTitleLabelColor()
            
        }
        
        updateTitleLabelColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateTitleLabelColor() {
        if #available(iOS 17.0, *) {
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            titleLabel.textColor = isDarkMode ? .white : .black
            saveImage.tintColor = isDarkMode ? .blueColor : .black
        }
    }
    
    func configure(with title: String?) {
        titleLabel.text = title ?? "no title"
    }
}

class MovieGenreCell: UICollectionViewCell {
    let reuseID = "MovieGenreCell"
    var genres: [Genre] = []
    var movieID: Int?
    var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    private lazy var genresCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .darkColor
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        return collection
    }()
    
    override init(frame: CGRect) {
        self.viewModel = MovieViewModel(id: self.movieID ?? 0)
        super.init(frame: frame)
        
        addSubview(genresCollection)
        
        viewModel.success = { [weak self] in
            self?.genresCollection.reloadData()
        }
        
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        
        viewModel.getMovieById()
        
        genresCollection.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Data Source

extension MovieGenreCell: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return genres.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
    cell.backgroundColor = .blueColor
    cell.layer.cornerRadius = 12
    cell.configureCell(text: genres[indexPath.row].name ?? "")
    return cell
}
    
}

//MARK: - Delegate

extension MovieGenreCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    collectionView.deselectItem(at: indexPath, animated: true)
//}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 85, height: 25)
    }
}

class GenreCell : UICollectionViewCell {
    static let identifier = "GenreCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor(named: "white")
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            //make.width.equalTo(100)
            //make.height.equalTo(50)
            //make.width.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(text: String) {
        label.text = text
    }
}

class MovieTypeCell: UICollectionViewCell {
    let reuseID = "MovieTypeCell"
    var movieID: Int?
    var viewModel: MovieViewModel

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "This is rating"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "rating")
        return image
    }()
    
    private let ratingStackView: UIStackView = {
           let stackView = UIStackView()
           stackView.axis = .horizontal
           stackView.spacing = 4
           return stackView
       }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Language"
        label.textColor = .gray
        return label
    }()
    
    private let languageType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let languageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Length"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let durationLength: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private let durationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let rating2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Rating"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let rating2Point: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "7.8"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let rating2StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 50
        return stackView
    }()
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    
    }
    
    override init(frame: CGRect) {
        self.viewModel = MovieViewModel(id: self.movieID ?? 0)
        super.init(frame: frame)
        
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        
        viewModel.getMovieById()
        
        ratingStackView.addArrangedSubview(ratingImage)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        languageStackView.addArrangedSubview(languageLabel)
        languageStackView.addArrangedSubview(languageType)
        
        durationStackView.addArrangedSubview(durationLabel)
        durationStackView.addArrangedSubview(durationLength)
        
        rating2StackView.addArrangedSubview(rating2Label)
        rating2StackView.addArrangedSubview(rating2Point)
        
        generalStackView.addArrangedSubview(durationStackView)
        generalStackView.addArrangedSubview(languageStackView)
        generalStackView.addArrangedSubview(rating2StackView)
        
        addSubview(generalStackView)
//        
//        ratingStackView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().inset(24)
//        }
        
        generalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    func configureCell(data: MovieInfoModel) {
        ratingLabel.text = "\(data.rating)"
        rating2Point.text = "\(data.rating)/10 IMDB"
        durationLength.text = "\(data.length) min"
        languageType.text = data.language
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MovieDescriptionCell: UICollectionViewCell {
    let reuseID = "MovieDescriptionCell"
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Description"
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descriptionTitle)
        addSubview(descriptionLabel)
        
        descriptionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(descriptionTitle.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(4)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(text: String?){
        descriptionLabel.text = text
    }
    
}

class MovieActorsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseID = "MovieActorsCell"
    var cast = [CastElement?]()
    
    
    private lazy var castCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 100, height: 150)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .darkColor
        collection.register(ImageLabelCell.self, forCellWithReuseIdentifier: ImageLabelCell.identifier)
        return collection
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Cast"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        
        contentView.addSubview(castLabel)
        contentView.addSubview(castCollection)
        
        castLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(24)
        }

        castCollection.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
//            make.top.equalTo(castLabel.snp.bottom).offset(4)
//            make.leading.equalToSuperview().inset(24)
//            make.trailing.equalToSuperview().inset(-24)
//            make.height.equalToSuperview().inset(150)
//
//            make.height.equalTo(180)
//            make.edges.equalToSuperview().inset(8)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        .init(width: 96, height: 96)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 4, bottom: 0, right: 4)
    }
//    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageLabelCell.identifier, for: indexPath) as! ImageLabelCell
        if let cast = cast[indexPath.row] {
            cell.configure(data: cast)
        }
        return cell
    }
    
}



