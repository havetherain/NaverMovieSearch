//
//  TopSummaryView.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/22.
//

import SnapKit
import Then

final class TopSummaryView: UIView {
    private let divideView: UIView = UIView().then {
        $0.backgroundColor = UIColor("#EEEEEE")
    }

    private let posterImageView: UIImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }

    private let directorTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        $0.textAlignment = .left
        $0.text = "감독:"

        $0.numberOfLines = 1
    }

    private let actorTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        $0.textAlignment = .left
        $0.text = "출연:"

        $0.numberOfLines = 1
    }

    private let ratingTitleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        $0.textAlignment = .left
        $0.text = "평ﾠﾠㅤᅟᅟᅠᅠᅠ­­­ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ점:"

        $0.numberOfLines = 1
    }

    private let directorLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        $0.textAlignment = .left

        $0.numberOfLines = 1
    }

    private let actorLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        $0.textAlignment = .left

        $0.numberOfLines = 1
    }

    private let ratingLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        $0.textAlignment = .left

        $0.numberOfLines = 1
    }

    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        addSubview(divideView)
        divideView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(8.0)
        }

        addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.width.equalTo(60.0)
        }

        addSubview(directorTitleLabel)
        directorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom).offset(12.0)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(8.0)
        }

        addSubview(directorLabel)
        directorLabel.snp.makeConstraints {
            $0.centerY.equalTo(directorTitleLabel)
            $0.leading.equalTo(directorTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(6.0)
        }

        addSubview(actorTitleLabel)
        actorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(8.0)
        }

        addSubview(actorLabel)
        actorLabel.snp.makeConstraints {
            $0.centerY.equalTo(actorTitleLabel)
            $0.leading.equalTo(actorTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(6.0)
        }

        addSubview(ratingTitleLabel)
        ratingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(actorTitleLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(8.0)
            $0.bottom.equalToSuperview().inset(12.0)
        }

        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingTitleLabel)
            $0.leading.equalTo(ratingTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(6.0)
        }
    }

    func configue(data: MovieItemVO) {
        posterImageView.setImageFromUrl(data.image.safelyUnwrapped)

        var directors = data.director.safelyUnwrapped.components(separatedBy: "|")
        directors.removeLast()
        if directors.count > 1 {
            directorLabel.text = directors.joined(separator: ", ")
        } else {
            directorLabel.text = directors.joined()
        }

        var actors = data.actor.safelyUnwrapped.components(separatedBy: "|")
        actors.removeLast()
        if actors.count > 1 {
            actorLabel.text = actors.joined(separator: ", ")
        } else {
            actorLabel.text = actors.joined()
        }
        ratingLabel.text = data.userRating.safelyUnwrapped
    }
}
