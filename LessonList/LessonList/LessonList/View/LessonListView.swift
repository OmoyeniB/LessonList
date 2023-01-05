//
//  ViewController.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class LessonListView: BaseView {

    var didTapCell: (() -> Void)?
    let color = UIColor.black
    
    lazy var font: UIFont = {
       let font = UIFont.boldSystemFont(ofSize: 20)
        return font
    }()
    
    lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 150
        tableView.register(LessonTableViewCell.self, forCellReuseIdentifier: LessonTableViewCell.identifier)
        return tableView
    }()
    
    
    
    override func setup() {
        super.setup()
       
        addSubview(tableView)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
    }

   
}


extension LessonListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didTapCell?()
    }
}

extension LessonListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: LessonTableViewCell.identifier, for: indexPath) as? LessonTableViewCell {
           
           return cell
       }
        return UITableViewCell()
    }
    
    
}
