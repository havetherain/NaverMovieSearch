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

//        $0.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
    }

    private let movieItemTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(MovieItemCell.self, forCellReuseIdentifier: "MovieItemCell")
    }

    let vm: MovieListVM = MovieListVM()
    var searchTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        makeConstraints()
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
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movieItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as! MovieItemCell

        return cell
    }
}

extension MovieListVC: UITextFieldDelegate {
    @objc func textFieldDidEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }

        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchForKeyword(_:)), userInfo: text, repeats: false)
    }

    @objc func searchForKeyword(_ timer: Timer) {
//        if isSearch {
//            isSearch = false
//            return
//        }
//
        guard let searchWord = timer.userInfo as? String else { return }

        if searchWord.count == 0 {
//            recommendContainerView.isHidden = false
//            recommendCompanyNameTableView.isHidden = true
//            searchResultRecruitPagerVC.view.isHidden = true
        } else {
//            setScreenSpinner()

//            vm.getCompanyGroupName(searchWord: searchWord) {
//                if self.vm.companyGroups.count == 0 {
//                    self.recommendContainerView.isHidden = false
//                    self.recommendCompanyNameTableView.isHidden = true
//                    self.searchResultRecruitPagerVC.view.isHidden = true
//                } else {
//                    self.recommendContainerView.isHidden = true
//                    self.recommendCompanyNameTableView.isHidden = false
//                    self.searchResultRecruitPagerVC.view.isHidden = true
//                }
//
//                self.recommendCompanyNameTableView.reloadData()
//                self.removeScreenSpinner()
//            }
        }
    }

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
//        isSearch = true
//
//        setScreenSpinner()
//        searchAction(searchWord: searchWord)
//        vm.storeRecentSearchKeyword(keyword: searchWord)
//        sendEvent(keyword: searchWord, method: .directly)
//
//        NotificationCenter.default.post(name: RecentSearchKeywordView.notiName, object: nil)

        return true
    }
}
