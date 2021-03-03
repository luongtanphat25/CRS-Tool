//
//  Data.swift
//  SwiftUI-CRS Tool
//
//  Created by Phat Luong on 2021-01-21.
//

import Foundation
import SwiftUI
struct K {
    static let LANGUAGE_TESTS = [Tests.CELPIP, Tests.IELTS, Tests.TEF, Tests.TCF]
    static let ENGLISH_TESTS = [Tests.CELPIP, Tests.IELTS]
    static let FRENCH_TESTS = [Tests.TEF, Tests.TCF]
    
    static let MARITAL_STATUS = [NSLocalizedString("Annulled Marriage", comment: ""),
                                 NSLocalizedString("Common-Law", comment: ""),
                                 NSLocalizedString("Divorced/ Separated", comment: ""),
                                 NSLocalizedString("Legally Separated", comment: ""),
                                 NSLocalizedString("Married", comment: ""),
                                 NSLocalizedString("Never Married/ Single", comment: ""),
                                 NSLocalizedString("Widowed", comment: "")]
    
    static let EDUCATION_LEVELS = [NSLocalizedString("None, or less than secondary (high school)", comment: ""),
                                   NSLocalizedString("Secondary diploma (high school graduation)", comment: ""),
                                   NSLocalizedString("One-year program at a university, college, trade or technical school, or other institute", comment: ""),
                                   NSLocalizedString("Two-year program at a university, college, trade or technical school, or other institute", comment: ""),
                                   NSLocalizedString("Bachelor's degree (three or more year program at a university, college, trade or technical school, or other institute)", comment: ""),
                                   NSLocalizedString("Two or more certificates, diplomas or degrees. One must be for a program of three or more years", comment: ""),
                                   NSLocalizedString("Master's degree, or professional degree needed to practice in a licensed profession", comment: ""),
                                   NSLocalizedString("Doctoral level university degree (PhD)", comment: "")]
    
    static let STUDY_IN_CANADA_LEVELS = [NSLocalizedString("Secondary (high school) or less", comment: ""),
                                         NSLocalizedString("One- or two-year diploma or certificate", comment: ""),
                                         NSLocalizedString("Degree, diploma or certificate of three years or longer OR a Master’s, professional or doctoral degree of at least one academic year", comment: "")]
    
    static let WORK_EXPERIENCES =  [0, 1, 2, 3, 4, 5]
    static let FOREIGN_EXPERIENCE = [0, 1, 2, 3]
    
    static let FAMILY_TO_PARTNER = "familyToPartner"
    static let FAMILY_TO_RESULT = "familyToResult"
    
    static let PSW = "q1!w2@e3#r4$t5%y6^"
    
    static let SPEAKING = NSLocalizedString("Speaking", comment: "")
    static let LISTENING = NSLocalizedString("Listening", comment: "")
    static let READING = NSLocalizedString("Reading", comment: "")
    static let WRITING = NSLocalizedString("Writing", comment: "")
    
    static let YEAR = NSLocalizedString("year", comment: "")
    static let YEARS = NSLocalizedString("years", comment: "")
    static let NONE = NSLocalizedString("None or < 1 year", comment: "")
    
    static let SUCCESSFULL_TITLE = NSLocalizedString("Sign up successfully", comment: "")
    
    static let SUCCESSFULL_MESSAGE = NSLocalizedString("Thank you for sign up with us. We will contact you soon.", comment: "")
    
    static let ERROR = NSLocalizedString("Error", comment: "")
    static let ALREADY_USES = NSLocalizedString("The email address is already in use by another account.", comment: "")
    static let BADLY_FORMATTED = NSLocalizedString("The email address is badly formatted.", comment: "")
    
    static let OK_LABEL_BUTTON = "OK"
    
    
    static let CELL = "cell"
    static let FROM_CELL = "fromCell"
    static let FROM_ADD = "fromAdd"
    
    static let PROFILE_PLACEHOLDER = NSLocalizedString("Enter profile's name", comment: "")
    static let ADD_PROFILE = NSLocalizedString("Add profile", comment: "")
    static let ADD_MESSAGE = NSLocalizedString("Create a new profile with all default CRS score is 0", comment: "")
    static let ADD = NSLocalizedString("Add", comment: "")
    static let CANCEL = NSLocalizedString("Cancel", comment: "")
    
    static let NEW_PROFILE = NSLocalizedString("New profile", comment: "")
    
    static let AGE = NSLocalizedString("Age", comment: "")
    static let EDUCATION = NSLocalizedString("Education", comment: "")
    static let LANGUAGE = NSLocalizedString("Language", comment: "")
    
    static let CHANGE_NAME = NSLocalizedString("Change name", comment: "")
    static let CHANGE_MESSAGE = NSLocalizedString("Please enter a new name", comment: "")
    static let SAVE = NSLocalizedString("Save", comment: "")
    
    static let WELCOME = NSLocalizedString("Welcome", comment: "")
    static let WELCOME_MESSAGE = NSLocalizedString("Thank you for your download. To add a new profile, press the red button on the right corner. Press the profile to edit. Swipe to the right to change the profile's name or delete.", comment: "")
    
    static let CHANGE_LANGUAGE = NSLocalizedString("Change to Vietnamese", comment: "")
    static let CHANGE_LANGUAGE_MESSAGE = NSLocalizedString("Set preferred language to Vietnamese in Settings.", comment: "")
    
    // Color
    static let RED = "Red"
    static let GREY = "Grey"
    static let BLUE_DARK = "Blue_Dark"
    static let BLUE_LIGHT = "Blue_Light"
    static let GREEN_LIGHT = "Green_Light"
    static let YELLOW = "Yellow"
    static let ORANGE = "Orange"
    static let BACKGROUND = "Background"
    static let TEXT = "Text"
    
    struct FStore {
        static let collectionName = "draws"
        static let score = "score"
        static let date = "date"
        static let invitations = "invitations"
    }
    
    static let INVITATIONS = NSLocalizedString("Invitations:", comment: "")
}
