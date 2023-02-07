//
//  JMTeamCollectionViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import UIKit

class FTTeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var teamImageView: UIImageView!
    @IBOutlet private weak var teamNameLabel: UILabel!
    
    private var id: UUID
    
    override init(frame: CGRect) {
        self.id = UUID()
        super.init(frame: frame)
        self.containerView.roundCorners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.id = UUID()
    }
    
    func setUpValue(team: FTTeam) {
        self.teamNameLabel.text = team.name
        
        let id = self.id
        
        if let crest = team.crest,
           let url = URL(string: crest) {
            self.teamImageView.image = self.teamImageView.getMemoryCache(url: url) ?? UIImage(systemName: "photo")
            
            self.teamImageView.requestRemoteImage(url: url) { [weak self] image in
                guard id == self?.id else { return }
                DispatchQueue.main.async {
                    if let image = image {
                        self?.teamImageView.image = image
                    }
                }
            }
        } else {
            self.teamImageView.image = UIImage(systemName: "photo")
        }
    }
}
