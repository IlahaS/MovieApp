
import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house")!, and: HomeViewController())
        let favorite = self.createNav(with: "Favorite", and: UIImage(systemName: "heart")!, and: FavoriteViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person")!, and: ProfileViewController())
        let actor = self.createNav(with: "Actors", and: UIImage(systemName: "person.3")!, and: ActorViewController())
        let search = self.createNav(with: "Search", and: UIImage(systemName: "magnifyingglass")!, and: SearchViewController())
        self.setViewControllers([home, search ,actor ,favorite, profile], animated: true)
        
        tabBar.tintColor = .blueColor
        
    }
    
    
    private func createNav(with name: String, and image: UIImage, and vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = name
        nav.tabBarItem.image = image
        return nav
    }
    
}
