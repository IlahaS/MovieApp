

import UIKit
import Kingfisher

extension UIImage {
    static var logoImage: UIImage { UIImage(named: "logo")! }
}

extension UIImageView {
    func loadImage(url: String) {
        let path = "\(NetworkHelper.imagePath)\(url)"
        if let finalUrl = URL(string: path) {
            self.kf.setImage(with: finalUrl)
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int = UInt64()
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3:
               (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6:
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8:
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (255, 0, 0, 0)
           }
           self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
       }
    
    static var blueColor: UIColor { UIColor(hexString: "0099FF") }
}
