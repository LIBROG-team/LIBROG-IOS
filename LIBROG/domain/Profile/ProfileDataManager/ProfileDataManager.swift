//
//  StatisticDataManager.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/26.
//

import Foundation
import Alamofire
import Kingfisher

class ProfileDataManager {
    let url = UserDefaults.standard.string(forKey: "url")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    // MARK: 유저 정보 조회
    func introDataManager(_ viewcontroller: ProfileViewController) {
        AF.request(url! + "users/profile/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: IntroModel.self) { response in
                
            switch response.result {
            case .success(let result):
                print("DEBUG: ", result)
                viewcontroller.introSuccessAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 유저의 독서 통계 조회
    func statisticDataManager(_ viewcontroller: ProfileViewController) {
        AF.request(url! + "records/statistics/\(userId)",
                   method: .get,
                   parameters: nil)
            .validate()
            .responseDecodable(of: APIModel<StatisticModel>.self) { response in
                
            switch response.result {
            case .success(let result):
//                print("DEBUG: ", result)
                viewcontroller.statisticSuccessAPI(result.result!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: 유저의 프로필 수정
    //multipart 업로드
    //HTTP 헤더
    let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data"
                ]
    func modifyProfileDataManager(_ nickname: String, _ photo: UIImage, _ introduction: String, _ viewcontroller: ModifyProfileViewController) {
        let modifyUrl = url! + "users/introduce/edit"
        let body : Parameters = [
                        "idx" : userId,
                        "name" : nickname,
                        "introduction" : introduction,
                    ]    //POST 함수로 전달할 String 데이터, 이미지 데이터는 제외하고 구성

        AF.upload(multipartFormData: { (multipart) in
            if let imageData = photo.jpegData(compressionQuality: 0.2) {
                multipart.append(imageData, withName: "profileImg", fileName: "photo.jpg", mimeType: "image/jpeg")
                //이미지 데이터를 POST할 데이터에 덧붙임
            }
            for (key, value) in body {
                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: key)
                //이미지 데이터 외에 같이 전달할 데이터 (여기서는 idx, name, introduction 등)
            }
        }
        ,to: URL(string: modifyUrl)!    //전달할 url
        ,method: .post        //전달 방식
        ,headers: headers) //헤더
        .responseData { response in
            switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(APIModel<ResultModel>.self, from: data)
//                        viewcontroller.RegisterSuccessAPI(result)
                        print(result)
                    } catch {
                        print("error")
                    }
                case let .failure(error): // 요청 x
                    print(error)
            }
        }
    }
}
