//
//  FTTeamViewControllerCode.swift
//  FootballTeams
//
//  Created by Javier Manzo on 04/02/2023.
//

import UIKit

class FTTeamViewControllerCode: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let viewModel: FTTeamViewModel
    
    init(teamId: Int) {
        self.viewModel = FTTeamViewModel(teamId: teamId)
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.requestData()
    }
    
    private func setUpViews() {
        self.view.backgroundColor = UIColor(color: .first)
        
        self.setUpTableView()
        self.setUpSpinner()
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCellClass(FTCoachTableViewCellCode.self)
        self.tableView.registerCellClass(FTCompetitionsTableViewCellCode.self)
        self.tableView.registerCellClass(FTPlayerTableViewCellCode.self)
        
        self.tableView.register(FTTeamSectionHeaderViewCode.self, forHeaderFooterViewReuseIdentifier: FTTeamSectionHeaderViewCode.className)
        
        self.tableView.clearExtraSeparators()
        
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpSpinner() {
        self.view.addSubview(self.spinner)
        NSLayoutConstraint.activate([
            self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc private func requestData() {
        self.spinner.startAnimating()
        self.viewModel.request { response in
            DispatchQueue.main.async { [weak self] in
                self?.spinner.stopAnimating()
                self?.refreshControl.endRefreshing()
            }
            
            switch response {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.title = self?.viewModel.team?.name ?? ""
                    self?.viewModel.setUpSections()
                    self?.tableView.reloadData()
                }
            case .error(let error):
                if let error = error {
                    self.presentServiceError(error: error) { [weak self] in
                        self?.requestData()
                    }
                }
            }
        }
    }
    
}

extension FTTeamViewControllerCode: UITableViewDelegate, UITableViewDataSource {
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
            return self.viewModel.team?.squad.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FTTeamSectionHeaderViewCode.className) as? FTTeamSectionHeaderViewCode else { return nil}
        
        let section = self.viewModel.tableSecionts[section]
        headerView.setValue(tile: section.title())
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let team = self.viewModel.team else { return UITableViewCell() }
        let section = self.viewModel.tableSecionts[indexPath.section]
        
        switch section {
        case .competitions:
            guard let cell = tableView.dequeueReusableCell(FTCompetitionsTableViewCellCode.self) else { break }
            let competitions = team.runningCompetitions
            cell.setUpValue(competitions: competitions)
            return cell
        case .coach:
            guard let cell = tableView.dequeueReusableCell(FTCoachTableViewCellCode.self) else { break }
            let coach = team.coach
            cell.setUpValue(coach: coach)
            return cell
        case .squad:
            guard let cell = tableView.dequeueReusableCell(FTPlayerTableViewCellCode.self) else { break }
            let player = team.squad[indexPath.row]
            cell.setUpValue(player: player)
            return cell
        }
        
        return UITableViewCell()
    }
}


