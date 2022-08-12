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
    let url = "https://dev.librog.shop/users"
    //multipart 업로드
    //HTTP 헤더
    let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data"
                ]
    func registerMultipartDataManager(_ email: String, _ password: String, _ nickname: String, _ photo: UIImage, _ introduction: String, _ viewcontroller: RegisterProfileViewController) {
        let body : Parameters = [
                        "email" : email,
                        "password" : password,
                        "name" : nickname,
                        "introduction" : introduction
                    ]    //POST 함수로 전달할 String 데이터, 이미지 데이터는 제외하고 구성

        AF.upload(multipartFormData: { (multipart) in
            if let imageData = photo.jpegData(compressionQuality: 0.2) {
                multipart.append(imageData, withName: "profileImg", fileName: "photo.jpg", mimeType: "image/jpeg")
                //이미지 데이터를 POST할 데이터에 덧붙임
            }
            for (key, value) in body {
                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: key)
                //이미지 데이터 외에 같이 전달할 데이터 (여기서는 email, password, name, introduction 등)
            }
        }
        ,to: URL(string: url)!    //전달할 url
        ,method: .post        //전달 방식
        ,headers: headers) //헤더
        .responseData { response in
            switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(APIModel<RegisterModel>.self, from: data)
                        print(result)
                        viewcontroller.RegisterSuccessAPI(result.result!)
                    } catch {
                        print("error")
                    }
                case let .failure(error): // 요청 x
                    print(error)
            }
        }
    }
}
