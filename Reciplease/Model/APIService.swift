//
//  APIServices.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 12/11/2020.
//

import Foundation
import Alamofire

class APIService: APIProtocol {
    static let shared = APIService()

    func getAPIData<T:  Decodable>(
        _ endpointApi: URL,
        _ parameters: [String:String?],
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void) {
        AF.request(endpointApi, method: .get, parameters: parameters)
            .validate()
            .responseJSON(completionHandler: { response in
                #if DEBUG
                    let body = String(data:response.data!, encoding: .utf8)
                    print(body as Any)
                #endif
                switch response.result {
                case .success:
                    JSON.shared.decodeData(type: apiStruct.self , data: response.data! , completion: {(result, error ) in
                        completionHandler(result, error)
                        return
                    })

                case .failure(let error):
                    switch error {
                    case .responseValidationFailed:
                        completionHandler(nil, Utilities.ManageError.apiRestriction)
                    default:
                        completionHandler( nil, Utilities.ManageError.httpResponseError)
                    }
                }
            })
    }
}
