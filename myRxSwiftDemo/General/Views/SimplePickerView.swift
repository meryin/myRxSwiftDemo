//
//  SimplePickerView.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/2.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias funcBlockAction = (String) -> Void

class SimplePickerView: UIView {
    let picker = UIPickerView()
    var listArray:Array<String>=[]
    private let topView = UIView()
    private let bag : DisposeBag = DisposeBag()
    private var block:funcBlockAction?
    var resultString = ""
    class func show(_ arr:Array<String>,result:@escaping funcBlockAction)
    {
        
        let SimpleView = SimplePickerView(arr)
        
        SimpleView.block = result
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        window.addSubview(SimpleView)
    }
    private init(_ arr:Array<String>) {
       super.init(frame:  CGRect(x: 0, y: 0, width: WindowWidth, height: WindowHeight))
        self.listArray = arr
        initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initUI()
    {
        self.backgroundColor = Tools.colorWithHexString(stringValue: "0x333333", alpha: 0.5)
        topView.frame = CGRect(x: 0, y: WindowHeight/3.0 * 2, width: WindowWidth, height: 50)
        topView.backgroundColor = Color("0xeeefff")
        self.addSubview(topView)
        let cancelBu = UIButton.init(title: "取消", titleColor: Color("0x333333"), fontSize: 15)
        topView.addSubview(cancelBu)
        cancelBu.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        cancelBu.rx.tap.bind {
           self.removeFromSuperview()
        }.disposed(by: bag)
        let comfirBu = UIButton.init(title: "确定", titleColor: Color("0x333333"), fontSize: 15)
        topView.addSubview(comfirBu)
        comfirBu.frame = CGRect(x: WindowWidth-50, y: 0, width: 50, height: 50)
        comfirBu.rx.tap.bind {
            self.block!(self.resultString)
            self.removeFromSuperview()
            }.disposed(by: bag)
        picker.frame = CGRect(x: 0, y:topView.frame.maxY , width: WindowWidth, height: WindowHeight-(topView.frame.maxY))
        self.addSubview(picker)
        picker.selectedRow(inComponent: 0)
        picker.backgroundColor = Color("0xffffff")
       
        Observable.just([self.listArray])
            .bind(to: picker.rx.items(adapter: PickerViewViewAdapter()))
            .disposed(by: bag)
        picker.rx.modelSelected(String.self)
            .subscribe(onNext: { models in
                print("picker models selected 1: \(models)")
                self.resultString = models.first!
            })
            .disposed(by: bag)
    }
    
}


final class PickerViewViewAdapter
    : NSObject
    , UIPickerViewDataSource
    , UIPickerViewDelegate
    , RxPickerViewDataSourceType
, SectionedViewDataSourceType {
    
    var selectedSection:Int = 0
    var selectedrow:Int = 0
    typealias Element = [[CustomStringConvertible]]
    private var items: [[CustomStringConvertible]] = []
    
    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.section][indexPath.row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = items[component][row].description
        if( component == selectedSection && row == selectedrow)
        {
             label.textColor = UIColor.orange
            label.backgroundColor = UIColor.lightGray
        }else
        {
             label.textColor = Color("0x333333")
            label.backgroundColor = UIColor.white
        }
       
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        
        if pickerView.subviews.count > 1 //去掉中间的线
        {
            let view:UIView = pickerView.subviews[1]
            view.alpha = 0
            view.backgroundColor = UIColor.white
        }
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = component
        selectedrow = row
        pickerView.reloadComponent(selectedSection)
    }
    func pickerView(_ pickerView: UIPickerView, observedEvent: Event<[[CustomStringConvertible]]>) {
        UIBindingObserver(UIElement: self) { (adapter, items) in
            adapter.items = items
            pickerView.reloadAllComponents()
            }.asObserver().on(observedEvent)
    }
    
}
