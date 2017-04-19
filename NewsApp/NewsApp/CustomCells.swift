//
//  CustomCells.swift
//  NewsApp
//
//  Created by Mai Nguyen Quang Tri on 4/18/17.
//  Copyright © 2017 Mai Nguyen Quang Tri. All rights reserved.
//

import Foundation
open class MenuItemCell : UICollectionViewCell {
    class var identifier: String { return String.className(self) }
    var titleLabel: UILabel!
   
    var selectedTitleLabel: UILabel!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(){
        if titleLabel == nil {
            titleLabel = UILabel.init(frame: CGRect.zero)
            titleLabel.textColor = UIColor.init(hex: "304c9d")
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(titleLabel)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
            
            self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))

        }
        
        if selectedTitleLabel == nil {
            selectedTitleLabel = UILabel.init(frame: CGRect.zero)
            selectedTitleLabel.textColor = UIColor.init(hex: "304c9d")
            selectedTitleLabel.textAlignment = .center
            selectedTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            self.addSubview(selectedTitleLabel)
            
            selectedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(NSLayoutConstraint(item: selectedTitleLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: selectedTitleLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
            
            self.addConstraint(NSLayoutConstraint(item: selectedTitleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: selectedTitleLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
            
        }
        

        //self.needsUpdateConstraints()
        self.layoutIfNeeded()
    }
    
    func updateCellWithTitle(title: String, isSelected: Bool) {
        titleLabel.text = title
        selectedTitleLabel.text = title
        if (isSelected) {
            selectedTitleLabel.alpha = 1.0;
            titleLabel.alpha = 0.0
        }else{
            selectedTitleLabel.alpha = 0.0;
            titleLabel.alpha = 1.0
        }
    }
    
    
}
