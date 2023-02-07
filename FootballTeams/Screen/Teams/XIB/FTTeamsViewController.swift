//
//  JMTeamsViewController.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import UIKit

class FTTeamsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: FTTeamsViewModel
    private let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let refreshControl = UIRefreshControl()
    
    init(dataProvider: FTDataProviderProtocol) {
        self.viewModel = FTTeamsViewModel(dataProvider: dataProvider)
        let className = String(describing: type(of: self))
        super.init(nibName: className, bundle: Bundle.main)
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
        self.setUpNavigation()
        self.setUpSpinner()
        self.setUpCollectionView()
    }
    
    private func setUpNavigation() {
        self.title = "UEFA Champions League"
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(color: .first) ?? .clear
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationController?.navigationBar.barTintColor =  UIColor(color: .first) ?? .clear
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor(color: .navigationTint) ?? .black
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(color: .text) ?? .black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setUpCollectionView() {
        self.collectionView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        self.collectionView.registerCellNib(FTTeamCollectionViewCell.self)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
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
                    self?.collectionView.reloadData()
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

extension FTTeamsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.competition?.teams.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(FTTeamCollectionViewCell.self, cellForItemAt: indexPath),
              let teams = self.viewModel.competition?.teams else {
            return UICollectionViewCell()
        }
        let team = teams[indexPath.row]
        cell.setUpValue(team: team)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let teams = self.viewModel.competition?.teams {
            let team = teams[indexPath.row]
            let vc = FTTeamViewController(teamId: team.id, dataProvider: self.viewModel.dataProvider)
            
            let cell = collectionView.cellForItem(at: indexPath)
            
            cell?.pulse(completion: { [weak self] _ in
                self?.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }
}

extension FTTeamsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

