//
//  ViewController.swift
//  SwiftChainingDemo
//
//  Created by Carl Chen on 9/13/16.
//  Copyright © 2016 nswebfrog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let commonLabelConfig: (String?) -> ((UILabel) -> Void) = { text in
            return { label in
                label.backgroundColor = .clear
                label.font = UIFont.systemFont(ofSize: 20)
                label.textColor = .red
                label.text = text
            }
        }
        let firstLabel = UILabel
            .ccf_create(withSuperView: view)
            .ccf_layout { (make) in
                make.top.equalTo(self.view).offset(80)
                make.centerX.equalTo(self.view)
            }
            .ccf_config(commonLabelConfig("firstLabel"))
        let secondLabel = UILabel
            .ccf_create(withSuperView: view)
            .ccf_layout { (make) in
                make.top.equalTo(firstLabel.snp.bottom).offset(20)
                make.centerX.equalTo(self.view)
            }
            .ccf_config(commonLabelConfig("secondLabel"))

        let thirdLabel = UILabel.ccf
            .create(withSuperView: view)
            .layout { (make) in
                make.top.equalTo(secondLabel.snp.bottom).offset(20)
                make.centerX.equalTo(self.view)
            }
            .config(commonLabelConfig("thirdLabel"))
            .view


        
        let mockNetworkData: Any = [
            "key1": 1,
            "key2": "value2",
            "key3": true
        ]
        let demoResult = APIResult.success(mockNetworkData)

        demoResult
            .flatMap(responseDataToDic)
            .successHandler({ (dic) in
                print(dic)
            })
            .flatMap(responseDicToAPIModel)
            .successHandler { (model: DemoResponseModel) in
                print(model)
            }
            .failureHandler { (error) in
                print(error)
            }


        let str = "test".ccf.selfValue
        print(str)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

enum APIResultError: Error {
    case dataFormatError
}

func responseDataToDic(data: Any) -> APIResult<[String: Any]> {

    guard let dic = data as? [String: Any] else {
        return APIResult.failure(APIResultError.dataFormatError)
    }

    return APIResult.success(dic)
}

protocol APIModelConvertible {
    static func toModel(dic: [String: Any]) -> Self?
}

func responseDicToAPIModel<T: APIModelConvertible>(dic: [String: Any]) -> APIResult<T> {
    guard let model = T.toModel(dic: dic) else {
        return APIResult.failure(APIResultError.dataFormatError)
    }

    return APIResult.success(model)
}

struct DemoResponseModel {
    let key1: Int
    let key2: String
    let key3: Bool

    init?(jsonDic: [String : Any]) {
        guard let value1 = jsonDic["key1"] as? Int,
            let value2 = jsonDic["key2"] as? String,
            let value3 = jsonDic["key3"] as? Bool
            else {
                return nil
        }
        self.key1 = value1
        self.key2 = value2
        self.key3 = value3
    }
}

extension DemoResponseModel: APIModelConvertible {
    static func toModel(dic: [String : Any]) -> DemoResponseModel? {
        return DemoResponseModel(jsonDic: dic)
    }
}




