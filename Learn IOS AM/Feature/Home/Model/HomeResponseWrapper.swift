//
//  HomeResponseWrapper.swift
//  Learn IOS AM
//
//  Created by IT-Mobile-Dev on 02/03/21.
//

import Foundation

public struct HomeResponseWrapper: Decodable{
    let results: [ResponseDetail]?
}
public struct ResponseDetail: Decodable{
    let question: String?
    let wrongChoice: [String]?
    let correctChoice: String?
    
    internal enum CodingKeys: String, CodingKey{
        case question = "question"
        case wrongChoice = "incorrect_answers"
        case correctChoice = "correct_answer"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.question = try values.decodeIfPresent(String.self, forKey: .question)
        self.wrongChoice = try values.decodeIfPresent([String].self, forKey: .wrongChoice)
        self.correctChoice = try values.decodeIfPresent(String.self, forKey: .correctChoice)
    }
    public init(){
        self.question = ""
        self.wrongChoice = ["","",""]
        self.correctChoice = "correct"
    }
}
