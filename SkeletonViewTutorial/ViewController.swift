//
//  ViewController.swift
//  SkeletonViewTutorial
//
//  Created by Brais Moure on 09/09/2020.
//  Copyright © 2020 MoureDev. All rights reserved.
//

import UIKit
import SkeletonView

// MARK: - ViewController
final class ViewController: UIViewController {

    // MARK: - Outlets
    
    // Header
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    
    // Table
    @IBOutlet weak var tableView: UITableView!
    
    // Footer
    
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - Properties
    
    private var textData: [String] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI
        setupUI()
        
        // Skeleton
        setupSkeleton()
    }
    
    // MARK: - Private methods

    private func setupUI() {
        
        // Header

        avatarImageView.layer.borderColor = UIColor.systemBlue.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.clipsToBounds = true
        
        nameLabel.text = "..."
        emailLabel.text = ""
        webLabel.text = ""
        
        // Table

        tableView.rowHeight = 96
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        
        // Footer
        
        loadButton.layer.cornerRadius = loadButton.bounds.height / 2
        loadButton.clipsToBounds = true
    }

    private func setupSkeleton() {
        
        // Header
        
        nameLabel.isSkeletonable = true
        nameLabel.linesCornerRadius = 8
        emailLabel.isSkeletonable = true
        emailLabel.linesCornerRadius = 8
        webLabel.isSkeletonable = true
        webLabel.linesCornerRadius = 8
        avatarImageView.isSkeletonable = true
        
        // Table
        
        tableView.isSkeletonable = true
    }
    
    private func loadData() {
        
        // Header
        
        nameLabel.showAnimatedGradientSkeleton()
        emailLabel.showAnimatedGradientSkeleton()
        webLabel.showAnimatedGradientSkeleton()
        avatarImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemBlue), animation: nil, transition: .crossDissolve(0.5))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  
            self.nameLabel.hideSkeleton()
            self.emailLabel.hideSkeleton()
            self.webLabel.hideSkeleton()
            self.avatarImageView.hideSkeleton()
            
            self.nameLabel.text = "Brais Moure"
            self.emailLabel.text = "braismoure@mouredev.com"
            self.webLabel.text = "https://mouredev.com"
            self.avatarImageView.image = UIImage(named: "mouredev_avatar")
        }
        
        // Table
        
        for index in 1...20 {
            textData.append("Element number \(index)")
        }
        
        tableView.reloadData()
        
        tableView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.tableView.hideSkeleton()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loadButtonAction(_ sender: Any) {
        
        loadButton.isHidden = true
        
        loadData()
    }

}

// MARK: - SkeletonTableViewDataSource
extension ViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return DataTableViewCell.kCellId
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.kCellId) as? DataTableViewCell {
            
            cell.fill(index: indexPath.row + 1, text: textData[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
  
}

// MARK: - DataTableViewCell
final class DataTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Properties
    
    static let kCellId = "DataTableViewCell"
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // UI
        setupUI()
        
        // Skeleton
        setupSkeleton()
    }
    
    // MARK: - Public methods
    
    func fill(index: Int, text: String) {

        self.iconImageView.image = UIImage(systemName: "\(index).circle.fill")
        self.titleLabel.text = "Title: \(text)"
        self.bodyLabel.text = "Description: \(text)"
    }
    
    // MARK: - Private methods

    private func setupUI() {
        
        titleLabel.text = ""
        bodyLabel.text = ""
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        iconImageView.clipsToBounds = true
    }
    
    private func setupSkeleton() {
        
        isSkeletonable = true
        
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 8
        bodyLabel.isSkeletonable = true
        bodyLabel.linesCornerRadius = 8
        iconImageView.isSkeletonable = true
    }

}

