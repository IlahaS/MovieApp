import Foundation

struct HomeModel {
    let title: String
    let movies: [MovieResult]
}

class HomeViewModel {
    var items = [HomeModel]()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    var filteredResults: (([HomeModel]) -> Void)?
    let manager = HomeManager()
    
    func getItems() {
        getMovies(title: "Popular", endpoint: Endpoints.popularMovies)
        getMovies(title: "Top Rated", endpoint: Endpoints.topRatedMovies)
        getMovies(title: "Upcoming", endpoint: Endpoints.upcomingMovies)
        getMovies(title: "Now Playing", endpoint: Endpoints.nowPlayingMovies)
    }
    
    func getMovies(title: String, endpoint: Endpoints) {
        manager.getMovieList(endpoint: endpoint) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: title, movies: data.results ?? []))
                self.success?()
            }
        }
    }
    
    func filterContentForSearch(text: String){
        let filteredItems: [HomeModel]
        if text.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter {
                $0.title.lowercased().contains(text.lowercased())
            }
        }
        filteredResults?(filteredItems)
    }
}
