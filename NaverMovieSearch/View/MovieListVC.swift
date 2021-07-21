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
    }

    private let movieItemTableView: UITableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(MovieItemCell.self, forCellReuseIdentifier: "MovieItemCell")
    }

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
