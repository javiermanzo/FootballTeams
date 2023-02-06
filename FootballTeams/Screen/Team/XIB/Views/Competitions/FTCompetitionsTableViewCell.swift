//
//  FTCompetitionsTableViewCell.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit

class FTCompetitionsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let viewModel = FTCompetitionsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpViews()
    }
    
    func setUpValue(competitions: [FTTeamCompetition]) {
        self.viewModel.competitions = competitions
    }
    
    private func setUpViews() {
        self.setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        self.collectionView.registerCellNib(FTCompetitionCollectionViewCell.self)
        
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
}

extension FTCompetitionsTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.competitions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(FTCompetitionCollectionViewCell.self, cellForItemAt: indexPath) else {
            return UICollectionViewCell()
        }
        let competition = self.viewModel.competitions[indexPath.row]
        cell.setUpValue(competition: competition)
        
        return cell
    }
}

extension FTCompetitionsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
