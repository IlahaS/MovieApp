import UIKit
import SnapKit

protocol TopImageBottomLabelCellProtocol{
    
    var titleLabel: String { get }
    var imagePath: String { get }
}

class ImageLabelCell: UICollectionViewCell {
    static let identifier = "ImageLabelCell"
    var containerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.height.equalTo(40)
            make.leading.trailing.bottom.equalToSuperview().inset(4)
        }
    }
    
    func configure(data: TopImageBottomLabelCellProtocol){
        titleLabel.text =  data.titleLabel
        imageView.loadImage(url: data.imagePath)
    }
}
