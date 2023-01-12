//
//  Logger.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 06/01/2023.
//

import Foundation

typealias ParameterHandler = (() -> Void)

enum LogType {
    case success
    case error
    case info
}

class Logger {
    
    static func printIfDebug(data: String, logType: LogType) {
#if DEBUG
        switch logType {
        case .success:
            print("🟢🟢🟢", data)
        case .error:
            print("🛑🛑🛑", data)
        case .info:
            print("🟡🟡🟡", data)
        }
#endif
    }
    
}
