import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pages : [PageModel] = [
        PageModel(profile: "profile_one", title: "My name is Kelvin Gao", description: "Learning a little each day adds up. Research shows that students who make learning "),
        PageModel(profile: "profile_two", title: "My name is Kelvin Gao", description: "Learning a little each day adds up. Research shows that students who make learning "),
        PageModel(profile: "profile_three", title: "My name is Kelvin Gao", description: "Learning a little each day adds up. Research shows that students who make learning ")
    ]
    
    private let prevButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func prevPage() {
        let prev = max(pageControl.currentPage - 1, 0)
        let index = IndexPath(item: prev, section: 0)
        pageControl.currentPage = prev
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.pinkColor, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func nextPage() {
        let next = min(pageControl.currentPage + 1, pages.count - 1)
        let index = IndexPath(item: next, section: 0)
        pageControl.currentPage = next
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl : UIPageControl = {
        let controls = UIPageControl()
        controls.currentPage = 0
        controls.numberOfPages = pages.count
        controls.currentPageIndicatorTintColor = .pinkColor
        controls.pageIndicatorTintColor = .tintColor
        
        return controls
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonConstraints()
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.row]
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()
            let index = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    
}
