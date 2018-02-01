//
//  TabBarItem.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/9/18.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit





class TabBarItem: UIView {
    var selectedImage:UIImage?
    var image:UIImage?
    var title:String = ""
   public var selected:Bool = false
  public  var unReadMeassageCount:Int = 0
   public var controller:UIViewController?
    
    private var imageView:UIImageView?
    private var lbTitle:UILabel?
    private var lbMessage:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: WindowWidth/5, height: 48))
        initView()
    }
    func initView() {
        imageView = UIImageView()
        self.addSubview(imageView!)
        lbTitle = UILabel(frame: CGRect(x: 0, y: self.bounds.size.height/2.0-5, width: self.bounds.size.width, height: self.bounds.size.height/2.0-5))
        self.addSubview(lbTitle!)
        lbTitle?.center = CGPoint(x: self.bounds.size.width/2.0, y: self.bounds.size.height/3*2+5)
        lbTitle?.font = UIFont.systemFont(ofSize: 10)
        lbTitle?.textAlignment = NSTextAlignment.center
        lbTitle?.textColor = UIColor.white
        lbMessage = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.addSubview(lbMessage!)
        lbMessage?.backgroundColor = UIColor.red
        lbMessage?.layer.cornerRadius = (lbMessage?.bounds.size.width)!/2.0
        lbMessage?.layer.masksToBounds = true
        lbMessage?.isHidden = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setImage(image:UIImage) {
        self.image = image
        imageView?.image = image
        imageView?.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageView?.center = CGPoint(x: self.bounds.size.width/2.0, y: self.frame.size.height/3)
    }
    func setTitle(title:String) {
        self.lbTitle?.text = title
    }
    func setSelected(selected:Bool) {
        self.selected = selected
        if selected {
            imageView?.image = self.selectedImage
            imageView?.frame = CGRect(x: 0, y: 0, width: (self.selectedImage?.size.width)!, height: (self.selectedImage?.size.height)!)
            imageView?.center = CGPoint(x: self.bounds.size.width/2.0, y: self.frame.size.height/3)
            controller?.view.isHidden = false
            
        }
        else{
            controller?.view.isHidden = true
            setImage(image: self.image!)
        }
    }
    func setUnReadMeassageCount(count:Int) {
        self.unReadMeassageCount = count
        lbMessage?.text = String(count)
        
        if (count > 0 ){
            lbMessage?.isHidden = false
            lbMessage?.center = CGPoint(x: (self.imageView?.frame.origin.x)!+(imageView?.bounds.size.width)!-(lbMessage?.bounds.size.width)!/2.0, y: (imageView?.frame.origin.y)!+(lbMessage?.bounds.size.height)!/2)
            
        }
        else{
            lbMessage?.isHidden = true
        }
    }
    
    static func initWithTabBarItem(item:UITabBarItem) -> TabBarItem {
        let tab = TabBarItem()
        tab.setImage(image: item.image!)
        tab.selectedImage = item.selectedImage!
        tab.setTitle(title: item.title!)
        return tab
    }
    
   static func initWith(title:String,image:UIImage,selectedImage:UIImage,controller:UIViewController) -> TabBarItem {
        let tab = TabBarItem()
        tab.setImage(image: image)
        tab.selectedImage = selectedImage
        tab.setTitle(title: title)
        tab.controller = controller
        return tab
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
