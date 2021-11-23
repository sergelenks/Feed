//
//  CustomCell.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    // MARK: - override
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private properties
    lazy private var cellImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var commentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - internal func
    func configureCell(title: String?, numComments: String?, data: Data?) {
        titleLabel.text = title
        commentsLabel.text = numComments
        cellImageView.image = nil
        
        if let data = data {
            cellImageView.image = UIImage(data: data)
        }
    }
    
    // MARK: - private func
    private func setUpUI() {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(commentsLabel)
        stackView.addArrangedSubview(cellImageView)
        
        contentView.addSubview(stackView)
        
        // setup constraint
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0).isActive = true
    }
}
