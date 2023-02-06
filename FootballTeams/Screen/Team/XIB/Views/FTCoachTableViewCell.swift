//
//  FTCoachTableViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

class FTCoachTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpValue(coach: FTTeamCoach) {
        var text = ""
        
        if let name = coach.name {
            text = name
            
            if let nationality = coach.nationality {
                text = "\(text) (\(nationality))"
            }
        }
        
        self.titleLabel.text = text
    }
}
