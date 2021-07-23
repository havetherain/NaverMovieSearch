//
//  FavoriteMovieListVC.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/23.
//

import SnapKit
import Then

class FavoriteMovieListVC: UIViewController {
    private let navigationView: UIView = UIView().then {
        $0.backgroundColor = .white
    }

    private let backBtn: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_close_btn_default"), for: .normal)
        $0.setImage(UIImage(named: "ic_close_btn_highlighted"), for: .highlighted)

        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0)
        $0.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
    }

    private let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        $0.textAlignment = .center
        $0.text = "즐겨찾기 목록"
    }
    
    private let movieItemTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white

        $0.register(MovieItemCell.self, forCellReuseIdentifier: "MovieItemCell")
        $0.rowHeight = 94.5
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "movieListReload"), object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes()
        makeConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewReloadData), name: Notification.Name(rawValue: "movieListReload"), object: nil)
    }

    @objc private func didTapBackBtn() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setAttributes() {
        view.backgroundColor = .white

        movieItemTableView.delegate = self
        movieItemTableView.dataSource = self
        movieItemTableView.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

        let footerView: UIView = UIView()
        movieItemTableView.tableFooterView = footerView
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

        view.addSubview(movieItemTableView)
        movieItemTableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func tableViewReloadData() {
        movieItemTableView.reloadData()
    }
}

extension FavoriteMovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieListVM.favoriteMovieItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as! MovieItemCell
        cell.configue(data: MovieListVM.favoriteMovieItems[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoDetailVC = MovieInfoDetailVC(movieItem: MovieListVM.favoriteMovieItems[indexPath.item])
        navigationController?.pushViewController(movieInfoDetailVC, animated: true)
    }
}
