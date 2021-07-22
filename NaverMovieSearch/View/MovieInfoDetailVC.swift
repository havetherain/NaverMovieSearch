//
//  MovieInfoDetailVC.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/22.
//

import WebKit
import SnapKit
import Then

class MovieInfoDetailVC: UIViewController {
    private let popRecognizer: InteractivePopRecognizer = InteractivePopRecognizer()

    private let navigationView: UIView = UIView().then {
        $0.backgroundColor = .white
    }

    private let backBtn: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_arrow_prev_default"), for: .normal)
        $0.setImage(UIImage(named: "ic_arrow_prev_highlighted"), for: .highlighted)

        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0)
        $0.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
    }

    private let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        $0.textAlignment = .center
        $0.text = "Label"
    }

    private let topSummaryView: TopSummaryView = TopSummaryView()

    private let wkWebView: WKWebView = WKWebView().then {
        $0.backgroundColor = .clear
        $0.isOpaque = false
        $0.scrollView.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
    }

    private let favoriteBtn: UIButton = UIButton().then {
        if let image = UIImage(named: "ic_favorite_star") {
            $0.setImage(image, for: .normal)
        }
        $0.setTitle("즐겨찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor("#F0F0F0").cgColor
        $0.layer.borderWidth = 1.0
    }

    var movieItem: MovieItemVO
    var originTopSummaryViewHeight: CGFloat?

    init(movieItem: MovieItemVO) {
        self.movieItem = movieItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let nav = navigationController else { return }
        popRecognizer.setInteractiveRecognizer(controller: nav)

        view.backgroundColor = .white

        makeConstraints()
        configure()
    }

    @objc private func didTapBackBtn() {
        navigationController?.popViewController(animated: true)
    }

    private func makeConstraints() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }

        navigationView.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(48.0)
        }

        navigationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(56.0)
        }

        view.addSubview(topSummaryView)
        topSummaryView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(102.5)
        }

        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints {
            $0.top.equalTo(topSummaryView.snp.bottom).offset(3.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func configure() {
        var title: String = movieItem.title.safelyUnwrapped
        title = title.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")

        titleLabel.text = title

        topSummaryView.configue(data: movieItem)
        if let link = movieItem.link, let url = URL(string: link) {
            wkWebView.load(URLRequest(url: url))
        }
    }
}
