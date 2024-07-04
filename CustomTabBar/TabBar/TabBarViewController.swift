//
//  TabBarViewController.swift
//  CustomTabBar
//
//  Created by Даниил Сивожелезов on 04.07.2024.
//

import UIKit

struct TabItem {
    let index: Int
    let tabText: String
    let tabImage: String
}

class TabBarViewController: UITabBarController {
    
    private lazy var tabView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        view.addSubview(tabStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tabStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tabBarModel = TabBarViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar(pages: tabBarModel.createTabItem())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        tabBar.isHidden = true
        setViewControllers(tabBarModel.setupViewControllers(), animated: true)
        view.addSubview(tabView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tabView.heightAnchor.constraint(equalToConstant: 70),
            
            tabStackView.topAnchor.constraint(equalTo: tabView.topAnchor),
            tabStackView.leadingAnchor.constraint(equalTo: tabView.leadingAnchor, constant: 20),
            tabStackView.bottomAnchor.constraint(equalTo: tabView.bottomAnchor),
            tabStackView.trailingAnchor.constraint(equalTo: tabView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupTabBar(pages: [TabItem]) {
        pages.enumerated().forEach { item in
            if item.offset == 0 {
                tabStackView.addArrangedSubview(createOneTabItem(item: item.element, isFirst: true))
            } else {
                tabStackView.addArrangedSubview(createOneTabItem(item: item.element))
            }
        }
    }
    
    private func createOneTabItem(item: TabItem, isFirst: Bool = false) -> UIView {
        TabBarItem(tabItem: item, isActive: isFirst) { [weak self] selectedItem in
            self?.tabStackView.arrangedSubviews.forEach{
                guard let tabItem = $0 as? TabBarItem else { return }
                tabItem.isActive = false
            }
            selectedItem.isActive.toggle()
            self?.selectedIndex = item.index
        }
    }
}
