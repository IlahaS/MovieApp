
import Foundation

class ActorViewModel {
    
    var items =  [PeopleResult]()
    var peopleData: People?
    var success: (() -> Void)?
    var error: ((String) -> Void)?

    let manager = ActorManager()
    func getActors() {
        manager.getActorList(pageNumber: (peopleData?.page ?? 0) + 1 ) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.peopleData = data
                self.items.append(contentsOf: data.results ?? [])
                self.success?()
            }
        }
    }
    
    func pagination(index: Int){
        if index == items.count-2 && (peopleData?.page ?? 0 <= peopleData?.totalPages ?? 0) {
            getActors()
        }
    }
    
    func refreshPagination(){
        peopleData = nil
    }
}
