import UIKit
import Kingfisher
import SnapKit

protocol HomeCollectionViewDelegate: AnyObject{
    func didSelectedMovie(movieId: Int)
}

class HomeCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var delegate: HomeCollectionViewDelegate?
    static let identifier = "HomeCollectionViewCell"
    var movies = [MovieResult]()
    private var collectionView: UICollectionView!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        //.setImage(UIImage(named: "plus.square.fill"), for: .normal)
        button.setTitle("See all  >", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12 )
        //button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllButton)
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
            make.top.equalToSuperview().inset(6)
            make.centerY.equalTo(titleLabel.snp.centerY)
            
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(6)
            make.height.equalTo(40)
        }
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(title: String, movies: [MovieResult]) {
        titleLabel.text = title
        self.movies = movies
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageLabelCell.self, forCellWithReuseIdentifier: ImageLabelCell.identifier)
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).inset(8)
            make.height.equalTo(250) // Height of the collectionView
        }
        
        layout.itemSize = CGSize(width: 130, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageLabelCell.identifier, for: indexPath) as! ImageLabelCell
        let selectedMovie = movies[indexPath.item]
        cell.configure(data: selectedMovie)
        
        // cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = movies[indexPath.row].id{
            delegate?.didSelectedMovie(movieId: movieId )
            //print(movie)
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        .init(width: 167, height: 250)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        .init(top: 12, left: 12, bottom: 0, right: 12)
    //    }
}
