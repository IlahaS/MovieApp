
import Foundation

enum MovieDetailItemType {
    case poster (String?)
    case title (String?)
    case genre ([Genre]?)
    case type (MovieInfoModel?)
    case description (String?)
    case cast ([CastElement]?) 
}

struct MovieDetailModel {
    let type: MovieDetailItemType
}

struct MovieInfoModel {
    let language: String
    let length: Int
    let rating: Double
}

class MovieViewModel{
    
    var items =  [MovieDetailModel]()
    private var id : Int
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    private let castManager  = CastManager()
    private let manager = MovieDetailManager()
    
    init(id: Int) {
        self.id = id
        //print()
    }
    
    func getMovieById() {
        manager.getMovieDetail(movieID: id) { [weak self] data, errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else if let data {
                self?.items.append(.init(type: .poster(data.posterPath)))
                self?.items.append(.init(type: .title(data.originalTitle)))
                self?.items.append(.init(type: .genre(data.genres)))
                self?.items.append(.init(type: .type(MovieInfoModel(
                    language: data.originalLanguage ?? "",
                    length: data.runtime ?? 0,
                    rating: data.voteAverage ?? 0))))
                self?.items.append(.init(type: .description(data.overview)))
                self?.getCast()
                
                self?.success?()
            }
        }
    }

    
    func getCast() {
        castManager.getCastDetail(movieID: self.id) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(type: .cast(data.cast)))
                self.success?()
            }
        }
    }
    
}
