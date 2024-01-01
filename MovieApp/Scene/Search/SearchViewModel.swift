class SearchViewModel {
    var items = [MovieResult]()
    
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func searchMovie(searchText: String, endpoint: SearchEndpoints) {
        let path = SearchEndpoints.searchMovies.rawValue + "?query=\(searchText)"
        NetworkManager.request(model: Movie.self, endpoint: path) { [weak self] data, errorMessage in
            guard let self = self else { return }
            
            if let errorMessage = errorMessage {
                self.onFailure?(errorMessage)
            } else if let data = data {
                self.items = data.results ?? []
                self.onSuccess?()
            }
        }
    }
    
    func getAllMovies() {
        let path = HomeEndpoints.popularMovies.rawValue
        NetworkManager.request(model: Movie.self, endpoint: path) { [weak self] data, errorMessage in
            guard let self = self else { return }
            
            if let errorMessage = errorMessage {
                self.onFailure?(errorMessage)
            } else if let data = data {
                self.items = data.results ?? []
                self.onSuccess?()
            }
        }
    }
}
