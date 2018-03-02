//
//  ChangHeadImageViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/19.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import Photos



class ChangHeadImageViewController: UIViewController {
    let imgv = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "头像"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .done, target: self, action: #selector(edit))
        initUI()
    }
    
    func initUI()
    {
        imgv.frame = self.view.bounds
        self.view.addSubview(imgv)
        let user = UserInfoModel.getUserInforModel()
        imgv.contentMode = .top
        imgv.mb_setImage(withUrlString: user?.img, placeholderImgName: "Ico_MCustomerCenter")
    }

    func edit()
    {
        
        let alertSheet = UIAlertController(title: "头像编辑", message: nil, preferredStyle: .actionSheet)
        let phoneAction = UIAlertAction(title: "相册", style: .default, handler: {action in
            self.fromAlbum(type:.photoLibrary)
        })
        let camerAction = UIAlertAction(title: "相机", style: .default, handler: { action in
            self.fromAlbum(type:.camera)
        })
        let archiveAction = UIAlertAction(title: "完成", style: .destructive, handler: {
            action in
            print(action)
        })
        alertSheet.addAction(phoneAction)
        alertSheet.addAction(camerAction)
        alertSheet.addAction(archiveAction)
        self.present(alertSheet, animated: true, completion: nil)

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

extension  ChangHeadImageViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
   @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion:nil)
    }
   @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage
          picker.dismiss(animated: true, completion:nil)
        if  imageSelected != nil {
            let data = UIImageJPEGRepresentation(imageSelected!, 0.3)
            uploadImage(imageData: data!, filename:getUserHeadImageName(name:"head_image"), url: "/haveFun/upload_head_image",blcok: { ( dict) in
                if dict == nil
                {
                    return
                }
                guard let image = dict!["image"] as? String else{return}
                let user = UserInfoModel.getUserInforModel()
                user?.img = image
                UserInfoModel.saveUserInforModel(user!)
                self.imgv.mb_setImage(withUrlString:user?.img, placeholderImgName: "Ico_MCustomerCenter")
                
                } )
        }
    }

}
