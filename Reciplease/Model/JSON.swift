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

        #if DEBUG
        if let data = data {
            do {
                let decodedData =  try JSONDecoder().decode(type.self, from: data)
                return completion(decodedData, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("\nKey '\(key)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("\nValue '\(value)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("\nType '\(type)' mismatch:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
            } catch {
                print("\nerror: ", error)
            }
        }
        #else
        if let data = data {
            do {
                let decodedData =  try JSONDecoder().decode(type.self, from: data)
                return completion(decodedData, nil)
            } catch {
                return completion(nil, Utilities.ManageError.decodableIssue)
            }
        }
        #endif
        return completion(nil, Utilities.ManageError.incorrectDataStruct)
    }
}
