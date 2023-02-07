//
//  FTCompetitionCollectionViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit
class FTCompetitionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var competitionImageView: UIImageView!
    @IBOutlet private weak var competitionName: UILabel!
    
    private var id: UUID
    
    override init(frame: CGRect) {
        self.id = UUID()
        super.init(frame: frame)
        self.containerView.roundCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
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
