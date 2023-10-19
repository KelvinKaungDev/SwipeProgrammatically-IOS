import UIKit

class ViewController: UIViewController {

    let profile : UIImageView = {
        let profileImage = UIImageView(image: UIImage(named: "profile"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        
        return profileImage
    }()
    
    let descriptionTextView : UITextView = {
        let description = UITextView()
        let descriptionAttribute = NSMutableAttributedString(string: "My name is Kelvin Gao", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        descriptionAttribute.append(NSAttributedString(string: "\n\n\nNow we’re asking for the same text to be rendered in a 72-point font, so your preview should be much larger.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        description.attributedText = descriptionAttribute
        description.font = UIFont.boldSystemFont(ofSize: 18)
        description.translatesAutoresizingMaskIntoConstraints = false
        description.isEditable = false
        description.isScrollEnabled = false
        description.textAlignment = .center
        
        return description
    }()
    
    private let prevButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        
        return button
    }()
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.pinkColor, for: .normal)
        
        return button
    }()
    
    private let pageControl : UIPageControl = {
        let controls = UIPageControl()
        controls.currentPage = 0
        controls.numberOfPages = 4
        controls.currentPageIndicatorTintColor = .pinkColor
        controls.pageIndicatorTintColor = .tintColor
        
        return controls
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(profile)
        view.addSubview(descriptionTextView)
        
        setUpButtonConstraints()
        setUpProfileConstraints()
    }
    
    fileprivate func setUpButtonConstraints() {
        let bottonControl = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        bottonControl.translatesAutoresizingMaskIntoConstraints = false
        bottonControl.distribution = .fillEqually
        view.addSubview(bottonControl)
        
        NSLayoutConstraint.activate([
            bottonControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottonControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottonControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottonControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpProfileConstraints() {
        
        let topImageView = UIView()
        view.addSubview(topImageView)
        
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageView.addSubview(profile)
        
        NSLayoutConstraint.activate([
            
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            profile.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor),
            profile.centerYAnchor.constraint(equalTo: topImageView.centerYAnchor),
            profile.widthAnchor.constraint(equalToConstant: 300),
            profile.heightAnchor.constraint(equalTo: topImageView.heightAnchor, multiplier: 0.5),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageView.bottomAnchor),
            descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension UIColor {
    static var pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static var tintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
}



