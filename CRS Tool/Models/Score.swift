//
//  Score.swift
//  SwiftUI-CRS Tool
//
//  Created by Phat Luong on 2021-01-20.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var name = K.NEW_PROFILE
    @objc dynamic var selectedMaritalStatus = 0
    @objc dynamic var isPartnerCanadian = false
    @objc dynamic var isWithPartner = false
    @objc dynamic var havePartner = false
    
    @objc dynamic var age = 0
    
    @objc dynamic var education = 0
    @objc dynamic var haveCanadianDegree = false
    @objc dynamic var studyInCanada = 0
    
    @objc dynamic var haveSecondLanguage = false
    
    @objc dynamic var canadianEx = 0
    @objc dynamic var foriegnEx = 0
    
    @objc dynamic var haveCertificate = false
    @objc dynamic var haveJobOffer = false
    @objc dynamic var noc = 0
    
    @objc dynamic var haveNomination = false
    @objc dynamic var haveCanadianFamily = false
    
    @objc dynamic var partnerEducation = 0
    @objc dynamic var partnerEx = 0
    @objc dynamic var partnerHaveTest = false
    
    let tests = List<TestResult>()
    
    var firstTest: TestResult { tests[0] }
    var secondTest:TestResult { tests[1] }
    var partnerTest: TestResult { tests[2] }
    
    @objc dynamic  var condition: Int { firstTest.checkCondition() }
    @objc dynamic  var finalScore = 0
    
    func partnerExperienceToScore() -> Int {
        if (havePartner) {
            switch partnerEx {
            case 0:
                return 0
            case 1:
                return 5
            case 2:
                return 7
            case 3:
                return 8
            case 4:
                return 9
            default:
                return 10
            }
        } else {
            return 0
        }
    }
    
    func partnerCLBToScore() -> Int {
        if partnerHaveTest {
            return partnerTest.partnerTestToScore()
        } else {
            return 0
        }
    }
    
    func partnerEducationToScore() -> Int {
        if havePartner {
            switch partnerEducation {
            case 0:
                return 0
            case 1:
                return 2
            case 2:
                return 6
            case 3:
                return 7
            case 4:
                return 8
            case 5:
                return 9
            default:
                return 10
            }
        } else {
            return 0
        }
    }
    
    func frenchSkillToScore() -> Int {
        var s = 0
        if firstTest.selectedTest == 2 || firstTest.selectedTest == 3 {
            if firstTest.checkCondition() > 1 {
                if haveSecondLanguage {
                    if secondTest.checkCondition() > 0 {
                        s = 50
                    }
                } else {
                    s = 25
                }
            }
        } else {
            if haveSecondLanguage {
                if secondTest.checkCondition() > 1 {
                    if firstTest.checkCondition() > 0 {
                        s = 50
                    } else {
                        s = 25
                    }
                }
            }
        }
        return s
    }
    
    func studyCanadaToScore() -> Int {
        if (haveCanadianDegree) {
            switch studyInCanada {
            case 0:
                return 0
            case 1:
                return 15
            case 2:
                return 30
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func jobOfferToScore() -> Int {
        if (haveJobOffer){
            switch noc {
            case 0:
                return 200
            case 1:
                return 50
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func certificateAndCLBToScore() -> Int {
        if haveCertificate {
            switch condition {
            case 0, 1:
                return 25
            default:
                return 50
            }
        } else {
            return 0
        }
    }
    
    func experienceToScore() -> Int {
        if foriegnEx == 0 {
            return 0
        } else if foriegnEx == 1 || foriegnEx == 2 {
            switch canadianEx {
            case 0:
                return 0
            case 1:
                return 13
            default:
                return 25
            }
        } else {
            switch canadianEx {
            case 0:
                return 0
            case 1:
                return 25
            default:
                return 50
            }
        }
    }
    
    func foreignWorkAndCLBToScore() -> Int {
        if foriegnEx == 0 {
            return 0
        } else if foriegnEx == 1 || foriegnEx == 2{
            switch condition {
            case 2:
                return 13
            case 3:
                return 25
            default:
                return 0
            }
        } else {
            switch condition {
            case 2:
                return 25
            case 3:
                return 50
            default:
                return 0
            }
        }
    }
    
    func workAndEducationToScore() -> Int {
        switch education {
        case 0, 1:
            return 0
        case 2...4:
            if canadianEx == 1 {
                return 13
            } else if canadianEx >= 2 {
                return 25
            } else {
                return 0
            }
        default:
            if canadianEx == 1 {
                return 25
            }else if canadianEx >= 2 {
                return 50
            } else {
                return 0
            }
        }
    }
    
    func clbAndEducationToScore() -> Int {
        if condition <= 1 {
            return 0
        } else {
            switch education {
            case 0, 1:
                return 0
            case 2...4:
                if condition == 2 {
                    return 13
                } else { return 25}
            default:
                if condition == 3 {
                    return 25
                } else { return 50}
            }
        }
    }
    
    func canadianExperienceToScore() -> Int {
        if havePartner {
            switch canadianEx {
            case 0:
                return 0
            case 1:
                return 35
            case 2:
                return 46
            case 3:
                return 56
            case 4:
                return 63
            default:
                return 70
            }
        } else {
            switch canadianEx {
            case 0:
                return 0
            case 1:
                return 40
            case 2:
                return 53
            case 3:
                return 64
            case 4:
                return 72
            default:
                return 80
            }
        }
    }
    
    func firstTestToScore() -> Int {
        return firstTest.firstTestToScore(havePartner: havePartner)
    }
    
    func secondTestToScore() -> Int {
        if haveSecondLanguage {
            return secondTest.secondTestToScore(havePartner: havePartner)
        } else {
            return 0
        }
    }
    
    func educationToScore() -> Int {
        if !havePartner {
            switch education {
            case 0:
                return 0
            case 1:
                return 30
            case 2:
                return 90
            case 3:
                return 98
            case 4:
                return 120
            case 5:
                return 128
            case 6:
                return 135
            case 7:
                return 150
            default:
                return 0
            }
        } else {
            switch education {
            case 0:
                return 0
            case 1:
                return 28
            case 2:
                return 84
            case 3:
                return 91
            case 4:
                return 112
            case 5:
                return 119
            case 6:
                return 126
            case 7:
                return 140
            default:
                return 0
            }
        }
    }
    
    func ageToScore() -> Int {
        if havePartner {
            switch age {
            case 17:
                return 0
            case 18:
                return 90
            case 19:
                return 95
            case 20...29:
                return 100
            case 30:
                return 95
            case 31:
                return 90
            case 32:
                return 85
            case 33:
                return 80
            case 34:
                return 75
            case 35:
                return 70
            case 36:
                return 65
            case 37:
                return 60
            case 38:
                return 55
            case 39:
                return 50
            case 40:
                return 45
            case 41:
                return 35
            case 42:
                return 25
            case 43:
                return 15
            case 44:
                return 5
            default:
                return 0
            }
        } else {
            switch age {
            case 17:
                return 0
            case 18:
                return 99
            case 19:
                return 105
            case 20...29:
                return 110
            case 30:
                return 105
            case 31:
                return 99
            case 32:
                return 94
            case 33:
                return 88
            case 34:
                return 83
            case 35:
                return 77
            case 36:
                return 72
            case 37:
                return 66
            case 38:
                return 61
            case 39:
                return 55
            case 40:
                return 50
            case 41:
                return 39
            case 42:
                return 28
            case 43:
                return 17
            case 44:
                return 6
            default:
                return 0
            }
        }
    }
}
