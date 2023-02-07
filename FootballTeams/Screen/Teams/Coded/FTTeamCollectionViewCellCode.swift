//
//  FTTestCollectionViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 03/02/2023.
//

import UIKit

class FTTeamCollectionViewCellCode: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(color: .fourth)
        view.roundCorners()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
        self.containerView.addSubview(self.logoImageView)
        self.containerView.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.containerView.topAnchor.constraint(equalTo: topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.logoImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8),
            self.logoImageView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5),
            self.logoImageView.heightAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            self.titleLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 8),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
        let aspectRatioConstraint = NSLayoutConstraint(item: self.logoImageView, attribute: .height, relatedBy: .equal, toItem: self.logoImageView, attribute: .width, multiplier: 1, constant: 0)
        self.logoImageView.addConstraint(aspectRatioConstraint)
    }
    
    func setUpValue(team: FTTeam) {
        self.titleLabel.text = team.name
        
        let id = self.id
        
        if let crest = team.crest,
           let url = URL(string: crest) {
            self.logoImageView.image = self.logoImageView.getMemoryCache(url: url) ?? UIImage(systemName: "photo")
            
            self.logoImageView.requestRemoteImage(url: url) { [weak self] image in
                guard id == self?.id else { return }
                DispatchQueue.main.async {
                    if let image = image {
                        self?.logoImageView.image = image
                    }
                }
            }
        } else {
            self.logoImageView.image = UIImage(systemName: "photo")
        }
    }
}
