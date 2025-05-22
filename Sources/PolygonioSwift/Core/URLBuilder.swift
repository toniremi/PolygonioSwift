//
//  URLBuilder.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

struct URLBuilder {
    let components: URLComponents
    let secret: String
    
    func buildURL<Rq>(_ rq: Rq) -> URL where Rq: ApiRequest {
        var components = self.components
        // configure query string
        var query = rq.queryItems
        query.append(URLQueryItem(name: "apikey", value: secret))
        // add the path and the parameters to the url
        components.path = rq.path
        components.queryItems = query
        
        return components.url!
    }
}
