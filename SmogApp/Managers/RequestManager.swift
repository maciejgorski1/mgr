//
//  RequestManager.swift
//  SmogApp
//
//  Created by Myrenkar on 27.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

typealias ResponseHandler = (response: Response<AnyObject, NSError>) -> Void

enum BaseURL {
    case SmartMeasurement
    case Measurement
    case NewAPI
    var address: String {
        switch self {
        case .SmartMeasurement:
            return "http://powietrze.malopolska.pl/data/data.php?type=smartmeasurement"
        case .Measurement:
            return "http://powietrze.malopolska.pl/data/data.php?type=measurement"
            case.NewAPI:
            return "powietrze.malopolska.pl/_powietrzeapi/api/dane?act=danemiasta&ci_id="
        }
    }
}

struct RequestManager {

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

    // MARK: - all cities
    static func allCitiesWithHandler(completionHandler: ResponseHandler)
    {
        let url = "\(BaseURL.SmartMeasurement.address)"
//        debugPrint(url)
        manager.request(.GET, url, headers: headers).responseJSON(completionHandler: completionHandler)
    }

    static func citiesWithHandler(cityID: Int, completionHandler: ResponseHandler)
    {
        let url = "\(BaseURL.NewAPI.address)\(cityID)"
        // debugPrint(url)
        manager.request(.GET, url, headers: headers).responseJSON(completionHandler: completionHandler)
    }
}
