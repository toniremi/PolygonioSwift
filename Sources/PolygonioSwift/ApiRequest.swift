//
//  ApiRequest.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

protocol ApiRequest {
    associatedtype Response
    
    // the path to make the api call
    var path: String { get }
    // the parameters to add including api key
    var queryItems: [URLQueryItem] { get }
}
