//
//  TestResult.swift
//  SwiftUI-CRS Tool
//
//  Created by Phat Luong on 2021-01-26.
//

import Foundation
import RealmSwift

class TestResult: Object {
    @objc dynamic var selectedTest = 0
    @objc dynamic var speaking = 0
    @objc dynamic var listening = 0
    @objc dynamic var reading = 0
    @objc dynamic var writing = 0
    var score = LinkingObjects(fromType: Score.self, property: "tests")
    
    func clbToScore(score: Int, havePartner: Bool) -> Int {
        if havePartner {
            switch score {
            case 0:
                return 0
            case 1, 2:
                return 6
            case 3:
                return 8
            case 4:
                return 16
            case 5:
                return 22
            case 6:
                return 29
            default:
                return 32
            }
        } else {
            switch score {
            case 0:
                return 0
            case 1, 2:
                return 6
            case 3:
                return 9
            case 4:
                return 17
            case 5:
                return 23
            case 6:
                return 31
            default:
                return 34
            }
        }
    }
    
    func firstTestToScore(havePartner: Bool) -> Int {
        return clbToScore(score: listening, havePartner: havePartner)
            + clbToScore(score: reading, havePartner: havePartner)
            + clbToScore(score: writing, havePartner: havePartner)
            + clbToScore(score: speaking, havePartner: havePartner)
    }
    
    func secondCLBToScore(score: Int) -> Int {
        switch score {
        case 0, 1:
            return 0
        case 2, 3:
            return 1
        case 4, 5:
            return 3
        default:
            return 6
        }
    }
    
    func secondTestToScore(havePartner: Bool) -> Int {
        let total = secondCLBToScore(score: listening)
            + secondCLBToScore(score: reading)
            + secondCLBToScore(score: writing)
            + secondCLBToScore(score: speaking)
        return havePartner && total >= 22 ? 22 : total
    }
    
    func spouseCLBToScore(score: Int) -> Int{
        switch score {
        case 0, 1:
            return 0
        case 2, 3:
            return 1
        case 4, 5:
            return 3
        default:
            return 5
        }
    }
    
    func partnerTestToScore() -> Int {
        return spouseCLBToScore(score: speaking)
            + spouseCLBToScore(score: listening)
            + spouseCLBToScore(score: writing)
            + spouseCLBToScore(score: reading)
    }
    
    func checkCondition() -> Int {
        if (listening >= 6) && (speaking >= 6) && (writing >= 6) && (reading >= 6) {
            return 3
        } else if (listening >= 4) && (speaking >= 4) && (writing >= 4) && (reading >= 4){
            return 2
        } else if (listening >= 2) && (speaking >= 2) && (writing >= 2) && (reading >= 2){
            return 1
        } else {
            return 0
        }
    }
}
