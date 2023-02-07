//
//  FTCompetitionCollectionViewCellCode.swift
//  FootballTeams
//
//  Created by Javier Manzo on 04/02/2023.
//

import UIKit

class FTCompetitionCollectionViewCellCode: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(color: .fourth)
        view.roundCorners()
        return view
    }()
    
    private let competitionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let competitionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private var id: UUID
    
    override init(frame: CGRect) {
        self.id = UUID()
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
    }
    
    private func setUpView() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.competitionImageView)
        self.containerView.addSubview(self.competitionName)
        
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.containerView.topAnchor.constraint(equalTo: topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.competitionImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.competitionImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8),
            self.competitionImageView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5),
            self.competitionImageView.heightAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5),
            
            self.competitionName.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            self.competitionName.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            self.competitionName.topAnchor.constraint(equalTo: self.competitionImageView.bottomAnchor, constant: 8),
            self.competitionName.heightAnchor.constraint(greaterThanOrEqualToConstant: 14)
        ])
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self.competitionImageView, attribute: .height, relatedBy: .equal, toItem: self.competitionImageView, attribute: .width, multiplier: 1, constant: 0)
        self.competitionImageView.addConstraint(aspectRatioConstraint)
    }
    
    func setUpValue(competition: FTTeamCompetition) {
        self.competitionName.text = competition.name
        
        let id = self.id
        if let emblem = competition.emblem,
           let url = URL(string: emblem) {
            self.competitionImageView.image = self.competitionImageView.getMemoryCache(url: url) ?? UIImage(systemName: "photo")
            
            self.competitionImageView.requestRemoteImage(url: url) { [weak self] image in
                guard id == self?.id else { return }
                DispatchQueue.main.async {
                    if let image = image {
                        self?.competitionImageView.image = image
                    }
                }
            }
        } else {
            self.competitionImageView.image = UIImage(systemName: "photo")
        }
    }
}
