

import Foundation

class CastManager: CastProtocol {
    func getCastDetail(movieID: Int, completion: @escaping ((Cast?, String?) -> Void)) {
        NetworkManager.request(
            model: Cast.self,
            endpoint: "movie/\(movieID)/credits",
            completion: completion)
    }
}
