//
//  TabBarViewModel.swift
//  CustomTabBar
//
//  Created by Даниил Сивожелезов on 04.07.2024.
//

import UIKit

class TabBarViewModel {
    
    func setupViewControllers() -> [UIViewController] {
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        
        return [firstVC, secondVC, thirdVC]
    }
    
    func createTabItem() -> [TabItem] {
        [TabItem(index: 0, tabText: "Home", tabImage: "home"),
         TabItem(index: 1, tabText: "Chat", tabImage: "chat"),
         TabItem(index: 2, tabText: "Profile", tabImage: "profile")]
    }
}
