
import Foundation

class MovieViewModel{
    
    var items =  [MovieResult]()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func searchMovie(selectedText: String) {

        let path = Endpoints.searchMovies.rawValue + "?query=\(selectedText)"
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
