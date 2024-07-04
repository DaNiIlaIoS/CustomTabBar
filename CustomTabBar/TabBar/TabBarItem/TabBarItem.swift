//
//  TabBarItem.swift
//  CustomTabBar
//
//  Created by Даниил Сивожелезов on 04.07.2024.
//

import UIKit

final class TabBarItem: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = isActive ? .systemGray6 : .clear
        view.layer.cornerRadius = 20
        view.addSubview(tabImage)
        view.addSubview(tabText)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        return view
    }()
    
    private lazy var tabImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: tabItem.tabImage)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var tabText: UILabel = {
        let label = UILabel()
        label.text = tabItem.tabText
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tabItem: TabItem
    var imageRightConstraint: NSLayoutConstraint?
    
    var isActive: Bool {
        willSet {
            self.imageRightConstraint?.isActive = !newValue
            self.contentView.backgroundColor = newValue ? .systemGray6 : .clear
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    var isSelected: (TabBarItem) -> Void
    
    init(tabItem: TabItem, imageRightConstraint: NSLayoutConstraint? = nil, isActive: Bool, isSelected: @escaping (TabBarItem) -> Void) {
        self.tabItem = tabItem
        self.imageRightConstraint = imageRightConstraint
        self.isActive = isActive
        self.isSelected = isSelected
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapToTab() {
        self.isSelected(self)
    }
    
    private func setupConstraints() {
        imageRightConstraint = tabImage.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        imageRightConstraint?.isActive = !isActive
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tabImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tabImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tabImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            tabImage.widthAnchor.constraint(equalToConstant: 25),
            tabImage.heightAnchor.constraint(equalToConstant: 25),
            
            tabText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tabText.leadingAnchor.constraint(equalTo: tabImage.trailingAnchor, constant: 5),
            tabText.centerYAnchor.constraint(equalTo: tabImage.centerYAnchor)
        ])
        
    }
}
