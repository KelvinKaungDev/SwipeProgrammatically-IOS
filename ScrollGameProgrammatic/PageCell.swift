import UIKit

class PageCell : UICollectionViewCell {
    
    var page : PageModel? {
        didSet {
            guard let safePage = page else { return }
            profile.image = UIImage(named: safePage.profile)
            let descriptionAttribute = NSMutableAttributedString(string: safePage.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            descriptionAttribute.append(NSAttributedString(string: "\n\n\n\(safePage.description)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = descriptionAttribute
            descriptionTextView.textAlignment = .center
        }
    }
    
    let profile : UIImageView = {
        let profileImage = UIImageView()
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        
        return profileImage
    }()
    
    let descriptionTextView : UITextView = {
        let description = UITextView()
        
        description.font = UIFont.boldSystemFont(ofSize: 18)
        description.translatesAutoresizingMaskIntoConstraints = false
        description.isEditable = false
        description.isScrollEnabled = false
        description.textAlignment = .center
        
        return description
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpProfileConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpProfileConstraints() {
        
        let topImageView = UIView()
        addSubview(topImageView)
        addSubview(descriptionTextView)

        
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageView.addSubview(profile)
        
        NSLayoutConstraint.activate([
            
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),

            profile.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor),
            profile.centerYAnchor.constraint(equalTo: topImageView.centerYAnchor),
            profile.widthAnchor.constraint(equalToConstant: 300),
            profile.heightAnchor.constraint(equalTo: topImageView.heightAnchor, multiplier: 0.5),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageView.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
