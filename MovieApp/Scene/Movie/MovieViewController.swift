import UIKit
import SnapKit

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!
    var viewModel : MovieViewModel
    let cellIdentifiers = ["MovieImageCell", "MovieTitleCell", "MovieRatingCell", "MovieTypeCell", "MovieDescriptionCell", "MovieActorsCell"]
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
//    var movieName: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.success = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        
        viewModel.getMovieById()
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
    
}

func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: cellIdentifiers[0])
        collectionView.register(MovieTitleCell.self, forCellWithReuseIdentifier: cellIdentifiers[1])
        collectionView.register(MovieRatingCell.self, forCellWithReuseIdentifier: cellIdentifiers[2])
        collectionView.register(MovieTypeCell.self, forCellWithReuseIdentifier: cellIdentifiers[3])
        collectionView.register(MovieDescriptionCell.self, forCellWithReuseIdentifier: cellIdentifiers[4])
        collectionView.register(MovieActorsCell.self, forCellWithReuseIdentifier: cellIdentifiers[5])
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //    func configureCollectionCells(){
    //        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: cellIdentifiers[0])
    //    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellIdentifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.section < cellIdentifiers.count else {
            fatalError("Invalid section index")
        }
        
        let cellIdentifier = cellIdentifiers[indexPath.section]
        let cell: UICollectionViewCell
        
        if indexPath.row < viewModel.items.count {
            switch indexPath.section {
            case 0:
                let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImageCell", for: indexPath) as! MovieImageCell
                
                let posterPath = viewModel.items[indexPath.row].posterPath ?? ""
                imageCell.configure(path: posterPath)
                
                cell = imageCell
                
            case 1:
                let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTitleCell", for: indexPath) as! MovieTitleCell
                titleCell.configure(with: viewModel.items[indexPath.row].title)
                //print("\(viewModel.items[indexPath.row].title ?? "no value")")
                cell = titleCell
                
            default:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            }
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.section < cellIdentifiers.count else {
            return CGSize.zero
        }
        
        let cellIdentifier = cellIdentifiers[indexPath.section]
        
        switch cellIdentifier {
        case "MovieImageCell":
            return CGSize(width: 250, height: 320)
        case "MovieTitleCell":
            return CGSize(width: collectionView.frame.width, height: 70)
        default:
            return CGSize.zero
        }
    }

}
//extension String {
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(
//            with: constraintRect,
//            options: .usesLineFragmentOrigin,
//            attributes: [NSAttributedString.Key.font: font],
//            context: nil
//        )
//        return ceil(boundingBox.height)
//    }
//}
