//
//  JSON.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 15/12/2020.
//

import Foundation
import Alamofire

class JSON {
    static let shared = JSON()

    ///generic data decodable function  with error management
    func decodeData<T: Decodable>(
        type: T?.Type,
        data: Data?,
        completion: @escaping (T?, Utilities.ManageError?) -> Void) {

        guard let decodedData = try? JSONDecoder().decode(type.self, from: data!)
            else {
                completion(nil, .incorrectDataStruct)
                return
        }
        return completion(decodedData, nil)
    }
}
