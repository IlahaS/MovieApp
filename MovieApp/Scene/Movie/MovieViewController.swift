import UIKit
import SnapKit

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var viewModel : MovieViewModel
    
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
        
        //view.backgroundColor = .darkColor
        
        viewModel.getMovieById()
        
        viewModel.success = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.error = { errorMessage in
            print("Error: \(errorMessage)")
        }
        
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let traitChangeHandler: ((HomeViewController, UITraitCollection) -> Void) = { [weak self] (controller, previousTraitCollection) in
            self?.updateAppearanceForCurrentTraitCollection()
        }
        self.registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: traitChangeHandler)
        updateAppearanceForCurrentTraitCollection()
        
    }
    
    func updateAppearanceForCurrentTraitCollection() {
        if traitCollection.userInterfaceStyle == .dark {
            //navigationItem.largeTitleDisplayMode = .never
            
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
            ]
            
            collectionView.backgroundColor = .darkColor
        } else {
            
            //navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
            ]
            collectionView.backgroundColor = .white
        }
    }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
            //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: "MovieImageCell")
            collectionView.register(MovieTitleCell.self, forCellWithReuseIdentifier: "MovieTitleCell")
            collectionView.register(MovieGenreCell.self, forCellWithReuseIdentifier: "MovieGenreCell")
            collectionView.register(MovieTypeCell.self, forCellWithReuseIdentifier: "MovieTypeCell")
            collectionView.register(MovieDescriptionCell.self, forCellWithReuseIdentifier: "MovieDescriptionCell")
            collectionView.register(MovieActorsCell.self, forCellWithReuseIdentifier: "MovieActorsCell")
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(4)
        }
    }
    
    //    func configureCollectionCells(){
    //        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: cellIdentifiers[0])
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        .init(top: 0, left: 0, bottom: 0, right: 0)
    //    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell
        
        //if indexPath.row < viewModel.items.count {
            let movieDetail = viewModel.items[indexPath.row]
            
            switch movieDetail.type {
                
            case .poster(let posterPath):
                let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImageCell", for: indexPath) as! MovieImageCell
                imageCell.configure(path: posterPath ?? "")
                cell = imageCell
                return cell
                
            case .title(let title):
                let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTitleCell", for: indexPath) as! MovieTitleCell
                if let title{
                    titleCell.configure(with: title)
                }
                cell = titleCell
                return cell
                
            case .genre(let genre):
                let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGenreCell", for: indexPath) as! MovieGenreCell
                genreCell.genres = genre ?? []
                //print(genreCell.genres)
                cell = genreCell
                return cell
                
            case .type(let info):
                let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTypeCell", for: indexPath) as! MovieTypeCell
                typeCell.viewModel = self.viewModel
                if let info {
                    typeCell.configureCell(data: info)
                }
                cell = typeCell
                return cell
                
            case .description( let description):
                let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
                if let description {
                    descriptionCell.configureCell(text: description)
                }
                cell = descriptionCell
                return cell
                
            case .cast( let cast):
                let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieActorsCell", for: indexPath) as! MovieActorsCell
                castCell.cast = cast ?? []
                cell = castCell
                return cell
                
            }
        }
    //}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.row < viewModel.items.count else {
            return .zero
        }
        
        let movieDetail = viewModel.items[indexPath.row]
        
        switch movieDetail.type {
        case .poster(_):
            let width: CGFloat = 330
            let height: CGFloat = 420
            return CGSize(width: width, height: height)
            
        case .title(_):
            let width: CGFloat = collectionView.bounds.width
            let height: CGFloat = 60
            return CGSize(width: width, height: height)
            
        case .genre(_):
           
            let width: CGFloat = collectionView.bounds.width
            let height: CGFloat = 23
            return CGSize(width: width, height: height)
            
        case .type(_):
            
            let width: CGFloat = collectionView.bounds.width
            let height: CGFloat = 60
            return CGSize(width: width, height: height)
            
        case .description(_):
            
            let width: CGFloat = collectionView.bounds.width
            let height: CGFloat = 100
            return CGSize(width: width, height: height)
            
        case .cast(_):
            
            let width: CGFloat = collectionView.bounds.width
            let height: CGFloat = 200
            return CGSize(width: width, height: height)
            
//        default:
//            return .zero
        }
    }
}

