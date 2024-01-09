

import Foundation

protocol CastProtocol {
    func getCastDetail (movieID: Int, completion: @escaping((Cast?, String?)->Void))
}
