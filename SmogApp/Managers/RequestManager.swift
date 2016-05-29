//
//  RequestManager.swift
//  SmogApp
//
//  Created by Myrenkar on 27.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseHandler = (response: Response<AnyObject, NSError>) -> Void

struct RequestManager {
    private static var BaseURL = {

        return "http://powietrze.malopolska.pl/_powietrzeapi/api/dane?act=danemiasta&ci_id="

    }
    private static let manager: Alamofire.Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders

        return Alamofire.Manager(
            configuration: configuration
    ) }()

    private static var headers: [String: String] {
        var headers = [String: String]()

        headers["Content-Type"] = "application/json"
        headers["Accept-Language"] = "en"

        return headers
    }

    static func citiesWithHandler(cityID: Int, completionHandler: ResponseHandler)
    {
        let url = "\(BaseURL)\(cityID)"
        // debugPrint(url)
        manager.request(.GET, url, headers: headers).responseJSON(completionHandler: completionHandler)
    }
}
