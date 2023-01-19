//
//  FTTeamSectionHeaderView.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

class FTTeamSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    private func setUpView() {
        self.tintColor = UIColor(color: .first) ?? .clear
    }
    
    func setValue(tile: String) {
        self.titleLabel.text = tile
    }
}
