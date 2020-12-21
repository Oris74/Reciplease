//
//  APIService+Protocol.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 21/12/2020.
//

import Foundation

protocol APIProtocol {
  func getAPIData<T:  Decodable>(
        _ endpointApi: URL,
        _ parameters: [String:String?],
        _ apiStruct: T?.Type,
        completionHandler : @escaping (T?, Utilities.ManageError?) -> Void)
}
