
import Foundation

class HomeManager: MovieListProtocol{
    
    func getMovieList(endpoint: Endpoints, completion: @escaping ((Movie?), String?) -> Void) {
        NetworkManager.request(model: Movie.self, endpoint: endpoint.rawValue , completion: completion)
    }
}
