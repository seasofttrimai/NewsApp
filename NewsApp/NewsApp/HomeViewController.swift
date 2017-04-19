//
//  ViewController.swift
//  NewsApp
//
//  Created by Mai Nguyen Quang Tri on 4/13/17.
//  Copyright © 2017 Mai Nguyen Quang Tri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let menuItemPadding: CGFloat = 20.0
    var categoryArray = ["Tin Trong Nước", "Quốc Tế", "Thể Thao", "Du Lịch", "Giải Trí", "Công Nghệ", "Hài Hước", "Kinh Tế"]
    var selectedIndex = 0
    var menuSelectedLine: UIView!
    var cachedPageTabs:[CGFloat]  = [];
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuButton: UIButton!{
        didSet{
            menuButton.tintColor = UIColor.white
        }
    }
    @IBOutlet weak var settingsButton: UIButton!{
        didSet{
            settingsButton.tintColor = UIColor.white
        }
    }
    @IBOutlet weak var menuCV: UICollectionView!{
        didSet{
            menuCV.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.identifier)
            menuSelectedLine = UIView.init(frame: CGRect(x: 0, y: menuCV.frame.height - 2, width: 120, height: 2))
            menuSelectedLine.backgroundColor = UIColor.init(hex: "304c9d")
            menuCV.addSubview(menuSelectedLine)
            
            cachedPageTabs.removeAll()
            
            let titleLB = UILabel()
            titleLB.font = UIFont.boldSystemFont(ofSize: 15)
            
            
            
            for i in 0...categoryArray.count-1{
                titleLB.text = categoryArray[i]
                titleLB.sizeToFit()
                let widthEle = titleLB.frame.width + menuItemPadding
                cachedPageTabs.append(widthEle)
                print("widthEle = \(widthEle)")
            }
            if cachedPageTabs.count > 0 {
                self.scrollMenuSelectedLineToIndex(index: selectedIndex)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let titleLB = UILabel()
        titleLB.text = categoryArray[indexPath.row]
        titleLB.font = UIFont.boldSystemFont(ofSize: 15)
        titleLB.sizeToFit()
        return CGSize(width: titleLB.frame.width + menuItemPadding, height: menuCV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.identifier, for: indexPath) as! MenuItemCell
        menuItemCell.updateCellWithTitle(title: categoryArray[indexPath.row], isSelected: selectedIndex == indexPath.row ? true : false)
        return menuItemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        menuCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        menuCV.reloadData()
        self.scrollMenuSelectedLineToIndex(index: indexPath.row)
    }
    
    func scrollMenuSelectedLineToIndex(index: Int){
        let originX = self.headerCVOriginXOfIndex(index: index);
        let labelWidth = self.headerCVWidthOfIndex(index: index);
        UIView.animate(withDuration: 0.5, animations: {
            self.menuSelectedLine.frame = CGRect(x: originX, y: self.menuCV.frame.size.height - 2, width: labelWidth, height: 2)
        })
    }
    
    func headerCVOriginXOfIndex(index: Int) -> CGFloat{
        var originX: CGFloat = 0
        if index > 0{
            for i in 0...index-1{
                originX += cachedPageTabs[i]
            }
        }
        
        return originX + 10
    }
    
    func headerCVWidthOfIndex(index: Int) -> CGFloat{
        return cachedPageTabs[index]
    }
}
