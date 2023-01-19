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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.roundCorners()
    }
    
    func setUpValue(team: FTTeam) {
        if let crest = team.crest,
           let url = URL(string: crest) {
            self.teamImageView.setRemoteImage(url: url, placeHolder: UIImage(systemName: "photo"))
        } else {
            self.teamImageView.image = UIImage(systemName: "photo")
        }
        
        self.teamNameLabel.text = team.name
    }
}
