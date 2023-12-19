

import Foundation

protocol ActorListProtocol {
    func getActorList(pageNumber: Int, completion: @escaping ((People?, String?) -> Void))
}
