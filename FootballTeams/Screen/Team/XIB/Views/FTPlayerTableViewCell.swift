//
//  FTPlayerTableViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

class FTPlayerTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpValue(player: FTTeamPlayer) {
        var text = player.name
        
        if let nationality = player.nationality {
            text = "\(text) (\(nationality))"
        }
        
        if let position = player.position {
            text = "\(text) - \(position)"
        }
        
        self.titleLabel.text = text
    }
}
