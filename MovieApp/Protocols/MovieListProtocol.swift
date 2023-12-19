
import Foundation

protocol MovieListProtocol{
    
    func getMovieList(endpoint: Endpoints, completion: @escaping((Movie?), String?) -> Void)
}

