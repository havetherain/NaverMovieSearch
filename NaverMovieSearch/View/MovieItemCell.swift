//
//  MovieItemCell.swift
//  NaverMovieSearch
//
//  Created by 김지우 on 2021/07/21.
//

import SnapKit
import Then

final class MovieItemCell: UITableViewCell {
    private let posterImageView: UIImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }

    private let titleLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        $0.textAlignment = .left
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
    
    private let favoriteBtn: GradientButton = GradientButton().then {
        $0.setImage(UIImage(named: "ic_favorite_star"), for: .normal)
        $0.setImage(UIImage(named: "ic_favorite_star_select"), for: .selected)
        $0.contentHorizontalAlignment = .right
        $0.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
    }
    
    var data: MovieItemVO?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setAttributes()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        favoriteBtn.addTarget(self, action: #selector(didTapFavoritButton(_:)), for: .touchUpInside)
    }

    private func setAttributes() {
        selectionStyle = .none
        contentView.backgroundColor = .white
    }

    private func makeConstraints() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.width.equalTo(60.0)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(8.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(40.0)
        }
        
        contentView.addSubview(favoriteBtn)
        favoriteBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.height.equalTo(40.0)
        }

        contentView.addSubview(directorTitleLabel)
        directorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(28.5)
        }

        contentView.addSubview(directorLabel)
        directorLabel.snp.makeConstraints {
            $0.centerY.equalTo(directorTitleLabel)
            $0.leading.equalTo(directorTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(16.0)
        }

        contentView.addSubview(actorTitleLabel)
        actorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(28.5)
        }

        contentView.addSubview(actorLabel)
        actorLabel.snp.makeConstraints {
            $0.centerY.equalTo(actorTitleLabel)
            $0.leading.equalTo(actorTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(16.0)
        }

        contentView.addSubview(ratingTitleLabel)
        ratingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(actorTitleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(4.0)
            $0.width.equalTo(28.5)
        }

        contentView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingTitleLabel)
            $0.leading.equalTo(ratingTitleLabel.snp.trailing).offset(6.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(16.0)
        }
    }
    
    @objc func didTapFavoritButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if let data = self.data {
            data.favorite = sender.isSelected
            if let index = MovieListVM.favoriteMovieItems.firstIndex(where: { $0.link == data.link }) {
                MovieListVM.favoriteMovieItems.remove(at: index)
            } else {
                MovieListVM.favoriteMovieItems.append(data)
            }
        }
    }

    func configue(data: MovieItemVO) {
        self.data = data
        posterImageView.setImageFromUrl(data.image.safelyUnwrapped)

        var title: String = data.title.safelyUnwrapped
        title = data.title.safelyUnwrapped.replacingOccurrences(of: "<b>", with: "")
        title = title.replacingOccurrences(of: "</b>", with: "")

        titleLabel.text = title

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
        
        if MovieListVM.favoriteMovieItems.contains(where: { $0.link == data.link }) {
            favoriteBtn.isSelected = true
        } else {
            favoriteBtn.isSelected = false
        }
    }
}
