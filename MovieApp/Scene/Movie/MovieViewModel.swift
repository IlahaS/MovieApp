
import Foundation

enum MovieDetailItemType {
    case poster (String?)
    case title (String?)
    case info (MovieInfoModel?)
    case description (String?)
    case cast ([CastElement]?) 
}

struct MovieDetailModel {
    let type: MovieDetailItemType
}

struct MovieInfoModel {
    let genres: [Genre]
    let language: String
    let length: Int
    let rating: Double
}

class MovieViewModel{
    
    var items =  [MovieResult]()
    private var id : Int
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(id: Int) {
        self.id = id
    }
    
    func getMovieById() {
        let path = MovieDetailEndpoint.movieDetailEndpoint.rawValue + "\(id)"
        NetworkManager.request(model: MovieResult.self, endpoint: path) { [weak self] data, errorMessage in
            guard let self = self else { return }
            
            if let errorMessage {
                self.error?(errorMessage)
            } else if let movieDetail = data {
                self.items = [movieDetail]
                self.success?()
            }
        }
    }
    
}
