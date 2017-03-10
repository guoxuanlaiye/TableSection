//
//  ViewController.swift
//  TableSection
//
//  Created by yingcan on 17/3/9.
//  Copyright © 2017年 guoxuan. All rights reserved.
//

import UIKit

struct Section {
    
    var name:String!
    var items:[String]!
    var collapsed:Bool!
    
    init(name:String,items:[String],collapsed:Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CollapsibleTableViewHeaderDelegate {
    
    lazy var sections:[Section] = {
    
        return [Section.init(name: "Mac",    items: ["Mac Book","MacBook Air","MacBook Pro","iMac","Mac Mini"], collapsed: false),
                Section.init(name: "iPhone", items: ["iPhone 5s","iPhone 6","iPhone 6s","iPhone 7"], collapsed: false),
                Section.init(name: "iPad",   items: ["iPad Mini","iPad Pro","iPad Air"], collapsed: false)]
    }()
    
    lazy var testTableView : UITableView = {[weak self] in
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.delegate        = self as UITableViewDelegate?
        tableView.dataSource      = self as UITableViewDataSource?
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.addSubview(testTableView)
    }
    
//MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let testCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell? ?? UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        let items = sections[indexPath.section].items
        testCell.textLabel?.text = items?[indexPath.row]
        return testCell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].collapsed! ? 0: 44.0
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader.init(reuseIdentifier: "header")
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(collasped:sections[section].collapsed)
        header.section         = section
        header.delegate        = self
        return header
    }
//MARK: - CollapsibleTableViewHeaderDelegate
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        //取反
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collasped: collapsed)
        
        testTableView.beginUpdates()
        
        for i in 0 ..< sections[section].items.count {
        
            testTableView.reloadRows(at: [NSIndexPath.init(row: i, section: section) as IndexPath], with: .automatic)
        }
        testTableView.endUpdates()
    }
}

//extension ViewController:UITableViewDelegate {
//
//}

