//
//  RegisterDataManager.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/28.
//

import Foundation
import Alamofire
import Kingfisher

class RegisterDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    
    func registerDataManager(_ parameter: RegisterInput, _ viewcontroller: RegisterProfileViewController) {
        AF.request(url! + "users/",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil)
            .validate()
            .responseDecodable(of: APIModel<ResultModel>.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
//                viewcontroller.RegisterSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //multipart 업로드
    func registerMultipartDataManager(_ email: String, _ password: String, _ nickname: String, _ photo: UIImage, _ introduction: String, _ viewcontroller: RegisterProfileViewController) {
        let body : Parameters = [
                        "email" : email,
                        "password" : password,
                        "nickname" : nickname,
                        "introduction" : introduction
                    ]    //POST 함수로 전달할 String 데이터, 이미지 데이터는 제외하고 구성
        
        AF.upload(multipartFormData: { (multipart) in
            if let imageData = photo.jpegData(compressionQuality: 1) {
                multipart.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
                //이미지 데이터를 POST할 데이터에 덧붙임
            }
            for (key, value) in body {
                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                //이미지 데이터 외에 같이 전달할 데이터 (여기서는 email, password, nickname, introduction 등)
            }
        }
        ,to: URL(string: url!)!    //전달할 url
        ,method: .post        //전달 방식
        ,headers: nil) //임시로 헤더 nil 처리
        .responseJSON(completionHandler: { (response) in    //헤더와 응답 처리
    
            print(response)
            if let err = response.error{    //응답 에러
                print(err)
                return
            }
            print("multipart success")        //응답 성공
            viewcontroller.RegisterSuccessAPI()
            
            let json = response.data
            if (json != nil){
                print(json)
            }
        })
    }
}
