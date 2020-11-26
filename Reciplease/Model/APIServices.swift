//
//  APIServices.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 12/11/2020.
//

import Foundation
import Alamofire

class APIServices {
    //static let shared = APIServices()

    static func getAPIData<T:  Decodable>(
        _ endpointApi: URL,
        _ parameters: [String:String?],
        _ apiStruct: T?.Type,
        completionHandler : @escaping ( Utilities.ManageError?, T?) -> Void) {
        AF.request(endpointApi, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: apiStruct.self) {(response) in
                switch response.result {
                case .success:
                    guard let apiData = response.value else {
                        completionHandler(Utilities.ManageError.incorrectDataStruct,nil )
                        return
                    }
                    completionHandler(nil, apiData)
                case .failure(let error):
                    print(error)
                    completionHandler(Utilities.ManageError.httpResponseError, nil)
                    return
                }
            }
    }
}
