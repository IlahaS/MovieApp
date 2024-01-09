

import Foundation
import Alamofire

class NetworkHelper {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let header: HTTPHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsInN1YiI6IjYyNDNmMjAyYzUwYWQyMDA1Y2RlOTVmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0dUMhxX4qBZrY_NXSEf9cWjAnzB-Xl1Qu5rj9CzET7k"]
    static let imagePath = "https://image.tmdb.org/t/p/original"
}
