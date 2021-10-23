//
//  MovieListVC.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import SnapKit
import Then

class MovieListVC: UIViewController {
    private let navigationView: UIView = UIView().then {
        $0.backgroundColor = .white
    }

    private let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        $0.textAlignment = .left

        $0.text = "네이버 영화 검색"
    }
    
    private let moveFavoriteListBtn: UIButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_favorite_star_select"), for: .normal)
        $0.setTitle("즐겨찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor("#F0F0F0").cgColor
        $0.layer.borderWidth = 1.0
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
    }

    private let divideLineView: UIView = UIView().then {
        $0.backgroundColor = UIColor("#EEEEEE")
    }

    private let searchTextField: UITextField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        $0.placeholder = "영화 제목을 입력하세요"

        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.returnKeyType = .search
        $0.autocapitalizationType = .none
    }

    private let movieItemTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white

        $0.register(MovieItemCell.self, forCellReuseIdentifier: "MovieItemCell")
        $0.rowHeight = 94.5
    }

    let vm: MovieListVM = MovieListVM()
    var searchTimer: Timer?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "movieListReload"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes()
        makeConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewReloadData), name: Notification.Name(rawValue: "movieListReload"), object: nil)
    }

    private func setAttributes() {
        view.backgroundColor = .white

        navigationController?.setEnableSwipeBack()

        movieItemTableView.delegate = self
        movieItemTableView.dataSource = self
        movieItemTableView.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)

        let footerView: UIView = UIView()
        movieItemTableView.tableFooterView = footerView

        searchTextField.delegate = self
    }

    private func makeConstraints() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48.0)
        }

        navigationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        navigationView.addSubview(moveFavoriteListBtn)
        moveFavoriteListBtn.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.width.equalTo(80.0)
        }
        moveFavoriteListBtn.addTarget(self, action: #selector(didTapMoveFavoriteMovieListBtn), for: .touchUpInside)

        navigationView.addSubview(divideLineView)
        divideLineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(32.0)
        }

        view.addSubview(movieItemTableView)
        movieItemTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
   }
    
    @objc func tableViewReloadData() {
        movieItemTableView.reloadData()
    }
    
    @objc func didTapMoveFavoriteMovieListBtn() {
        let favoriteMovieListVC = FavoriteMovieListVC()
        let navAboutFavoriteMovieListVC = UINavigationController(rootViewController: favoriteMovieListVC)

        navAboutFavoriteMovieListVC.setEnableSwipeBack()
        navAboutFavoriteMovieListVC.view.backgroundColor = .white
        navAboutFavoriteMovieListVC.setNavigationBarHidden(true, animated: false)
        navAboutFavoriteMovieListVC.modalPresentationStyle = .fullScreen
        
        present(navAboutFavoriteMovieListVC, animated: true, completion: nil)
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movieItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as! MovieItemCell
        cell.configue(data: vm.movieItems[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoDetailVC = MovieInfoDetailVC(movieItem: vm.movieItems[indexPath.item])
        navigationController?.pushViewController(movieInfoDetailVC, animated: true)
        searchTextField.endEditing(true)
    }
}

extension MovieListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchWord = textField.text else { return false }
        if searchWord.count < 2 {
            makeSimpleAlert(title: "알림", content: "2자 이상 입력하세요")
            return false
        }

        vm.getMovieInfos(word: searchWord) { errorTitle, errorMsg, result in
            if result {
                self.movieItemTableView.reloadData()
            } else {
                guard let title = errorTitle, let msg = errorMsg else { return }
                self.makeSimpleAlert(title: title, content: msg)
            }
        }
        return true
    }
}
