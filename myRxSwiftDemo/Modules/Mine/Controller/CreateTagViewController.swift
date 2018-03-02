//
//  CreateTagViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/27.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

class CreateTagViewController: UIViewController {
    let disposeBag = DisposeBag()
    let titleFiled = UITextField()
    let contentFiled = UITextField()
    let imgView = UIImageView()
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建会馆"
        initUI()
        
    }
    
    func initUI()
    {
        imgView.backgroundColor = UIColor.gray
        let button = UIButton.init(backGroundColor: UIColor.clear, title: "建立", titleColor: UIColor.orange, target: self, action: #selector(creating))
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        self.view.addSubview(contentFiled)
        self.view.addSubview(imgView)
        self.view.addSubview(titleFiled)
        let line = UIView()
        line.backgroundColor = Color("0x999999")
        self.view.addSubview(line)
       
        titleFiled.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(30)
            make.height.equalTo(40)
            make.left.equalTo(15)
        }
        line.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(titleFiled.snp.bottom).offset(10)
            make.height.equalTo(0.6)
            make.left.equalTo(15)
        }
        contentFiled.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.height.equalTo(40)
            make.top.equalTo(titleFiled.snp.bottom).offset(10)
            make.left.equalTo(15)
        }
        let w = WindowWidth-30
        imgView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(contentFiled.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.height.equalTo(w)
        }
        titleFiled.placeholder = "请输入标题"
        contentFiled.placeholder = "请输入会馆简介"
        imgView.isUserInteractionEnabled = true
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                let alertSheet = UIAlertController(title: "头像编辑", message: nil, preferredStyle: .actionSheet)
                let phoneAction = UIAlertAction(title: "相册", style: .default, handler: {action in
                    self?.fromAlbum(type:.photoLibrary)
                })
                let camerAction = UIAlertAction(title: "相机", style: .default, handler: { action in
                    self?.fromAlbum(type:.camera)
                })
                let archiveAction = UIAlertAction(title: "完成", style: .destructive, handler: {
                    action in
                    print(action)
                })
                alertSheet.addAction(phoneAction)
                alertSheet.addAction(camerAction)
                alertSheet.addAction(archiveAction)
                self?.present(alertSheet, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
        
        imgView.addGestureRecognizer(tapBackground)
        
        
    }
    func creating()
    {
        
        guard let my = UserInfoModel.getUserInforModel() , (my.user_id != nil) else {
            MBProgressHUD.showError("请先登录")
            return
        }
        let title = titleFiled.text
        let content = self.contentFiled.text
        if title?.count == 0
        {
            MBProgressHUD.showError("请填写标题")
            return
        }
        if content?.count == 0
        {
            MBProgressHUD.showError("请填写简介")
            return
        }
        if self.imgView.image == nil{
            MBProgressHUD.showError("请选择照片")
            return
        }
        if imageName.count > 0
        {
            uploading()
            return
        }
         let data = UIImageJPEGRepresentation(imgView.image!, 0.3)
        let name = getUserHeadImageName(name:"tag_image" )
        uploadImage(imageData: data!, filename: name, url: "/haveFun/upload_artical_tag_image") { (dict ) in
            if dict == nil
            {
                return
            }
            guard let image = dict!["image"] as? String else{return}
            
            self.imageName = image
            self.uploading()
            
        }
        
    }
    func uploading()
    {
   
        guard let my = UserInfoModel.getUserInforModel() ,let user_id = my.user_id else {
            MBProgressHUD.showError("请先登录")
            return
        }
        let title = titleFiled.text
        let content = self.contentFiled.text
         gitHubProvider.request(.uploadTag(tag_name:title!,tag_img:self.imageName,tag_abstract:content!,user_id:user_id)) { result in
            if case let .success(response) = result {
                guard ((try? response.mapObjectResult()) == true) else{return}
                MBProgressHUD.showSuccess("文集创建成功")
                self.navigationController?.popViewController(animated: true)
                
            }
            else {
                MBProgressHUD.showError((result.error?.errorDescription)! )
            }
        }
    }
     func addImage(image: UIImage) {
        imgView.image = image
        
    }
    //选取相册
    func fromAlbum(type:UIImagePickerControllerSourceType) {
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status != .authorized{
                        MBProgressHUD.showError("请在设置里设置权限")
                        return
                    }
                })
            }
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.modalPresentationStyle = .overFullScreen
            if type == .photoLibrary
            {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    
                    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    
                    self.present(picker, animated: true, completion: {
                        () -> Void in
                    })
                }else{
                    MBProgressHUD.showError("没有相册权限")
                }
            }
            else
            {
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    
                    picker.sourceType = UIImagePickerControllerSourceType.camera
                    self.present(picker, animated: true, completion: {
                        () -> Void in
                    })
                }else
                {
                    MBProgressHUD.showError("没有相机权限")
                }
        }
    }
        
}
extension  CreateTagViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
    {
        @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion:nil)
        }
        @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage
            picker.dismiss(animated: true, completion:nil)
            if  imageSelected != nil {
                addImage(image: imageSelected!)
                
            }
        }
        
}
