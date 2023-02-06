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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.roundCorners()
    }
    
    func setUpValue(competition: FTTeamCompetition) {
        if let emblem = competition.emblem,
           let url = URL(string: emblem)  {
            self.competitionImageView.setRemoteImage(url: url, placeHolder: UIImage(systemName: "photo"))
        } else {
            self.competitionImageView.image = UIImage(systemName: "photo")
        }
       
        self.competitionName.text = competition.name
    }
}
