//
//  EvaluationResponseData.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/6/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import Foundation

enum EvaluationResponseType {
    case Evaluation, Participation
}

class EvaluationResponseData: NSObject {

    var evaluationResponses:[Int]
    var participationResponses:[Int]

    init(evaluationResponseCount:Int, participationResponseCount: Int) {
        evaluationResponses = [Int](count: evaluationResponseCount, repeatedValue: 1)
        participationResponses = [Int](count: participationResponseCount, repeatedValue: 1)
    }
    
    func updateResponse(type:EvaluationResponseType, idx:Int, value:Int) {
        if type == .Evaluation {
            evaluationResponses[idx] = value
        } else if type == .Participation {
            participationResponses[idx] = value
        }
    }
    
    func asDictionary() -> [String:AnyObject] {
        return ["evaluation":self.evaluationResponses, "participation":self.participationResponses]
    }
    
}
