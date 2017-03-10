//
//  CollapsibleTableViewHeader.swift
//  TableSection
//
//  Created by yingcan on 17/3/9.
//  Copyright © 2017年 guoxuan. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    //声明
    func toggleSection(header:CollapsibleTableViewHeader,section:Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

    let titleLabel = UILabel() //标题
    
    let arrowLabel = UILabel() //箭头
    
    var delegate : CollapsibleTableViewHeaderDelegate?
    var section  : Int = 0
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(tap:))))
        
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive  = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    func tapHeader(tap:UITapGestureRecognizer) {
        guard let cell = tap.view as? CollapsibleTableViewHeader else {
            return
        }
        //代理方法传出当前cell 的section
        delegate?.toggleSection(header: self, section: cell.section)
    }
    func setCollapsed(collasped:Bool) {
        //旋转方法在Extensions的扩展类中
        arrowLabel.rotate(toValue: (collasped ? 0.0 : CGFloat(M_PI_2)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let views = [
            "titleLabel" : titleLabel,
            "arrowLabel" : arrowLabel
        ]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[arrowLabel]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
