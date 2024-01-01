
import Foundation

protocol MovieListProtocol {
    func getMovieList(endpoint: HomeEndpoints, completion: @escaping((Movie?), String?) -> Void)
}

class HomeManager: MovieListProtocol {
    func getMovieList(endpoint: HomeEndpoints, completion: @escaping ((Movie?), String?) -> Void) {
        NetworkManager.request(model: Movie.self, endpoint: endpoint.rawValue , completion: completion)
    }
}
