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
    var pageList: [UIViewController] = []
    var slider : TTScrollSlidingPagesController?
    
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
            menuSelectedLine = UIView.init(frame: CGRect(x: 0, y: menuCV.frame.height - 2, width: 0, height: 2))
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
        self.initSlidingPages()

    }
    
    func initSlidingPages(){
        for i in 0...categoryArray.count - 1{
            let tintucVC = storyboard?.instantiateViewController(withIdentifier: "TinTucViewController") as! TinTucViewController
            tintucVC.title = categoryArray[i]
            if i % 2 == 0 {
                tintucVC.view.backgroundColor = UIColor.lightGray
            }
            pageList.append(tintucVC)
        }
        
        
        
        
        self.slider = TTScrollSlidingPagesController()
        
        //self.slider?.titleScrollerHidden = true
        

        self.slider?.titleScrollerTextColour = UIColor(red: 35/255.0, green: 175/255.0, blue: 211/255.0, alpha: 1)
        self.slider?.disableUIPageControl = false
        self.slider?.titleScrollerBackgroundColour = UIColor.white
        self.slider?.titleScrollerBottomEdgeColour = UIColor.gray
        self.slider?.titleScrollerBottomEdgeHeight = 3
        self.slider?.bottomScrollerSize.width = ScreenSize.SCREEN_WIDTH
        self.slider?.bottomScrollerSize.height = ScreenSize.SCREEN_HEIGHT
        self.slider?.titleScrollerItemWidth = Int32(ScreenSize.SCREEN_WIDTH/4)
        if DeviceType.IS_IPHONE_6P || DeviceType.IS_IPHONE_6
        {
            self.slider?.titleScrollerTextFont = UIFont.boldSystemFont(ofSize: 14)//kFontSystem
            self.slider?.titleScrollerHeight = 40
        }
        else if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS
        {
            self.slider?.titleScrollerTextFont = UIFont.boldSystemFont(ofSize: 13)//kFontSystem_iphone4
            self.slider?.titleScrollerHeight = 40
        }
        self.slider?.delegate = self
        self.slider?.dataSource = self
        self.slider?.initialPageNumber = Int32(0)
        self.slider?.zoomOutAnimationDisabled = true
        
        self.containerView.addSubview((self.slider?.view)!)
        //slider?.view.backgroundColor = UIColor.redColor()
        self.slider?.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addConstraint(NSLayoutConstraint(item: (self.slider?.view)!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.containerView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint(item: (self.slider?.view)!, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.containerView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint(item: (self.slider?.view)!, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.containerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        self.containerView.addConstraint(NSLayoutConstraint(item: (self.slider?.view)!, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.containerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        self.containerView.needsUpdateConstraints()
        
        slider?.block = { (currentPage : Int32) in
        }
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController : TTSlidingPagesDataSource
{
    func numberOfPages(forSlidingPagesViewController source: TTScrollSlidingPagesController!) -> Int32 {
        return Int32(pageList.count)
        
    }
    
    func page(forSlidingPagesViewController source: TTScrollSlidingPagesController!, at index: Int32) -> TTSlidingPage! {
        return TTSlidingPage(contentViewController: pageList[Int(index)])
    }
    func title(forSlidingPagesViewController source: TTScrollSlidingPagesController!, at index: Int32) -> TTSlidingPageTitle! {
        var titleHeader : TTSlidingPageTitle!
        titleHeader = TTSlidingPageTitle(headerText: categoryArray[Int(index)])
        
        return titleHeader
    }
}

extension HomeViewController : TTSlidingPageDelegate{
    func didScrollToView(at index: UInt) {
        print("didScrollToView at Index = \(index)")
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
