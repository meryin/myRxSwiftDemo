//
//  WriteViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Photos

class WriteViewController: UIViewController {

    let tag_nameLabel = UILabel.init(font: 15, textColor: Color("0x333333"))
    lazy var tag_button = UIButton()
    let titleFiled = UITextField()
    let contentText = UITextView()
    var tag:ArticalTagModel?
    let disposeBag = DisposeBag()
    var imgArr:Array<Data> = []
    var imgResultArr:Array<String> = []
    var content = ""
    var imageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }

    func initUI()
    {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "图片", style: .done, target: self, action: #selector(addPhoto))
        tag_button = UIButton.init(title: "请选择文集", titleColor: UIColor.orange, fontSize: 14)
        let button = UIButton.init(backGroundColor: UIColor.clear, title: "发布", titleColor: UIColor.orange, target: self, action: #selector(uploading))
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        self.view.addSubview(tag_button)
        self.view.addSubview(tag_nameLabel)
        self.view.addSubview(titleFiled)
        self.view.addSubview(contentText)
        let line = UIView()
        line.backgroundColor = Color("0x999999")
        self.view.addSubview(line)
        tag_button.layer.borderWidth = 0.8
        tag_button.layer.cornerRadius = 2
        tag_button.layer.borderColor = UIColor.orange.cgColor
        
        tag_button.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.height.equalTo(25)
            make.width.equalTo(80)
        }
        tag_nameLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(10)
            make.height.equalTo(25)
            make.left.equalTo(tag_button.snp.right).offset(10)
        }
        titleFiled.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(tag_button.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.left.equalTo(15)
        }
        line.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.top.equalTo(titleFiled.snp.bottom).offset(10)
            make.height.equalTo(0.6)
            make.left.equalTo(15)
        }
        contentText.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.bottom.equalTo(-15)
            make.top.equalTo(titleFiled.snp.bottom).offset(10)
            make.left.equalTo(15)
        }
        titleFiled.placeholder = "请输入标题"
        tag_button.rx.tap
            .bind {
                let vc = TagSelectViewController()
                vc.blcok = { item in
                    guard let model = item as? ArticalTagModel else {return}
                    self.tag = model
                    self.tag_nameLabel.text = "文集: " + (self.tag?.tag_name)!
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
        
        
        
    }
    
    func addPhoto()
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
    func addImage(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let data = UIImageJPEGRepresentation(image, 0.3)
        imgArr.append(data!)
        
        let scale = (contentText.frame.width - 2 * 5 ) / image.size.width
        attachment.bounds = CGRect(x: 0, y: 0, width: scale * image.size.width, height: scale * image.size.height)
        
        let attribute = NSMutableAttributedString(attributedString: contentText.attributedText)
        attribute.append(NSAttributedString(attachment: attachment))
        contentText.attributedText = attribute
        //获得目前光标的位置
        let selectedRange = contentText.selectedRange
        let newSelectedRange = NSMakeRange(selectedRange.location+1, 0)
        contentText.selectedRange = newSelectedRange
        contentText.scrollRangeToVisible(newSelectedRange)
        contentText.attributedText = attribute
        
    }
    
    func upload(title:String,imageName:String,content:String,user_id:Int,tag_id:Int)
    {
        gitHubProvider.request(.uploadArtical(title: title, imageName: imageName, content: content, user_id: user_id, tag_id: tag_id)) { result in
            if case let .success(response) = result {
                print(response)
                guard ((try? response.mapObjectResult()) == true) else{return}
                MBProgressHUD.showSuccess("文章发布成功")
                self.clean()
                
            }
            else {
                MBProgressHUD.showError((result.error?.errorDescription)! )
            }
        }
        
    }
    func uploading()
    {
        guard let my = UserInfoModel.getUserInforModel() ,let user_id = my.user_id else {
            MBProgressHUD.showError("请先登录")
            return
        }
        let title = titleFiled.text
        let tag_id = self.tag?.tag_id
        if title?.count == 0
        {
            MBProgressHUD.showError("请填写标题")
            return
        }
        if self.tag == nil
        {
            MBProgressHUD.showError("请选择文集")
            return
        }
        
        groupUpload(datas: imgArr, url: "/haveFun/upload_artical_image") { (dict) in
            guard (dict) != nil else{return}
            if (dict?.count)! < self.imgArr.count
            {
                MBProgressHUD.showError("上传失败")
                return
            }
            let numbersSorted = dict?.sorted(by: {
                return $1 > $0
            })
            self.imgResultArr = numbersSorted!
            self.imageName = self.imgResultArr.first!
            
            self.imageName = self.imageName.subStringFrom( "--image:--")
            var arr:Array<NSRange> = []
            var string = self.contentText.attributedText!.string
        
            self.contentText.attributedText!.enumerateAttributes(in: NSMakeRange(0,self.contentText.attributedText!.length), options: []) { (data, range, _) -> Void in
                    if let attachment = data["NSAttachment"] as? NSTextAttachment {
                      let img = attachment.image
                        if (img != nil)
                        {
                            arr.append(range)
                        }
                    }
            }
            var range1 = arr[0]
            var distance = 0
            for index in 0..<arr.count
            {
                if ( index-1 >= 0 )
                {
                    distance = arr[index].location-arr[index-1].location-arr[index-1].length
                }
                if (index > 0)
                {
                    range1 = NSMakeRange(range1.location+self.imgResultArr[index-1].count+distance,range1.length)
                    
                }
                
            string = string.replacingCharacters(in: string.range(from: range1)!, with:  self.imgResultArr[index])
            }
            self.content = string
        self.upload(title:title!,imageName:self.imageName,content:self.content,user_id:user_id,tag_id:tag_id!)
            
        }
        
    }
    func clean()
    {
        titleFiled.text = ""
        content = ""
        imageName = ""
        contentText.attributedText = nil
        contentText.text = nil
        imgResultArr = []
        imgArr = []
    }
}
extension  WriteViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
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
