

import Foundation


class MovieDetailManager: MovieDetailProtocol {
    func getMovieDetail(movieID: Int, completion: @escaping ((MovieDetail?, String?) -> Void)) {
        NetworkManager.request(
            model: MovieDetail.self,
            endpoint: MovieDetailEndpoint.movieDetailEndpoint.rawValue+"\(movieID)",
            completion: completion)
    }
}
