//
//  FTTeamViewController.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

class FTTeamViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: FTTeamViewModel
    
    init(team: FTTeam) {
        self.viewModel = FTTeamViewModel(team: team)
        let className = String(describing: type(of: self))
        super.init(nibName: className, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        
        self.viewModel.setUpSections()
    }
    
    private func setUpViews() {
        self.setUpNavigation()
        self.setUpTableView()
    }
    
    private func setUpNavigation() {
        self.title = self.viewModel.team.name
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCellNib(FTCoachTableViewCell.self)
        self.tableView.registerCellNib(FTCompetitionsTableViewCell.self)
        self.tableView.registerCellNib(FTPlayerTableViewCell.self)
        
        self.tableView.register(FTTeamSectionHeaderView.nib, forHeaderFooterViewReuseIdentifier: FTTeamSectionHeaderView.className)
        
        self.tableView.clearExtraSeparators()
    }
}

extension FTTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.tableSecionts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.viewModel.tableSecionts[section]
        
        switch section {
        case .competitions:
            return  1
        case .coach:
            return 1
        case .squad:
            return self.viewModel.team.squad.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FTTeamSectionHeaderView.className) as? FTTeamSectionHeaderView else { return nil}
        
        let section = self.viewModel.tableSecionts[section]
        view.setValue(tile: section.title())
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.viewModel.tableSecionts[indexPath.section]
        
        switch section {
        case .competitions:
            guard let cell = tableView.dequeueReusableCell(FTCompetitionsTableViewCell.self) else { break }
            let competitions = self.viewModel.team.runningCompetitions
            cell.setUpValue(competitions: competitions)
            return cell
        case .coach:
            guard let cell = tableView.dequeueReusableCell(FTCoachTableViewCell.self) else { break }
            let coach = self.viewModel.team.coach
            cell.setUpValue(coach: coach)
            return cell
        case .squad:
            guard let cell = tableView.dequeueReusableCell(FTPlayerTableViewCell.self) else { break }
            let player = self.viewModel.team.squad[indexPath.row]
            cell.setUpValue(player: player)
            return cell
        }
        
        return UITableViewCell()
    }
}

