//
//  HomeTarget.swift
//  Learn IOS AM
//
//  Created by IT-Mobile-Dev on 02/03/21.
//

import Foundation
import Moya

internal enum HomeTarget{
    case getQuestion
}

extension HomeTarget: TargetType{
    var baseURL: URL {
        return URL(string: "https://opentdb.com/api.php")!
    }
    
    var path: String {
        switch self{
        case .getQuestion:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getQuestion:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{\"data\": 123}".data(using: .utf8)!
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: [String : Any]? {
        switch self {
            case .getQuestion:
                return ["type":"multiple","amount":1]
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
        
    }
    
    var headers: [String : String]? {
        switch self{
        default:
            return nil
        }
    }
    
}
