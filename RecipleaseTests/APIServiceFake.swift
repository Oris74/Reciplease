//
//  APIServices.swift
//  RecipleaseTests
//
//  Created by Laurent Debeaujon on 10/12/2020.
//

import Foundation
@testable import Reciplease

class APIServiceFake: APIProtocol {

    static let shared = APIServiceFake()
    private var json =  Data()

    private init() {}

    init(json: Data) {
        self.json = json
    }

    func getAPIData<T: Decodable>(
        _ endpointApi: URL,
        _ parameters: [String:String?],
        _ apiStruct: T?.Type,
        completionHandler: @escaping (T?, Utilities.ManageError?) -> Void) {

        JSON.shared.decodeData(type: apiStruct.self,
                               data: json,
                               completion: {(recipe, error) in
            switch error {
            case nil:
                completionHandler(recipe , nil)
            default:
                completionHandler(nil, error )
            }
        })
    }
}
