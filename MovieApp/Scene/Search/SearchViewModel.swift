
import Foundation

class SearchViewModel{
    
    var items =  [MovieResult]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func searchMovie(searchText: String, endpoint: Endpoints) {

        let path = Endpoints.searchMovies.rawValue + "?query=\(searchText)"
        NetworkManager.request(model: Movie.self,
                               endpoint: path) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items = data.results ?? []
                self.success?()
            }
        }
    }
}
