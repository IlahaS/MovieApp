

import Foundation

protocol MovieDetailProtocol {
    func getMovieDetail(movieID: Int, completion: @escaping((MovieDetail?, String?)->Void))
}
