
import Foundation

class ActorManager: ActorListProtocol {
    func getActorList(pageNumber: Int, completion: @escaping ((People?, String?) -> Void)) {
        
        let url = Endpoints.popularPeople.rawValue + "?page=\(pageNumber)"
        NetworkManager.request(model: People.self, endpoint: url) { data, errorMassage in
            if let errorMassage{
                completion(nil, errorMassage)
            } else if let data{
                completion(data, nil)
            }
        }
    }
    
}
