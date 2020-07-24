//
//  Reporter.swift
//  Reporting
//
//  Created by Jason Earle on 2019-11-29.
//  Copyright © 2019 Jason Earle. All rights reserved.
//

import Foundation
import MessageUI
import UIKit
import os.log

public enum Type {
  case Debug
  case Error
  case Warning
  case Success
  case Information
  case Data
  case Connection
  case Internet
  case EMail
  case Tracking
  case Password
  case Secure(Toggle)
  case Sound(Toggle)
  case Default
}

private enum msgType {
  case info
  case debug
  case error
  case fault
}

public enum Toggle {
  case On
  case Off
}

public class Reporter {
  public static let report = Reporter()
  
  // MARK: - Initialization
  private init() {
  }
  
  public func showMessage(message: String, title: String, vc: UIViewController, dismiss: Bool) {
    DispatchQueue.main.async(execute: {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      // Create the actions
      let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        alertController.dismiss(animated: true)
        if dismiss { vc.dismiss(animated: true) }
      }
      
      // Add the actions
      alertController.addAction(okAction)
      
      // Present the alert to the user
      vc.present(alertController, animated: true)
    })
    
    return
  }
  
  public func DebugLog(log: String!, type: Type = .Default, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    var finalMessageType: msgType?
    var logType: OSLog?
    var finalMessage: String
    
    switch type {
      case .Debug:
        logType = OSLog.Debug
        finalMessageType = .debug
        finalMessage = "💬 "
      case .Data:
        logType = OSLog.Data
        finalMessageType = .info
        finalMessage = "🗄️ "
      case .Warning:
        logType = OSLog.Data
        finalMessageType = .fault
        finalMessage = "⚠️ "
      case .Error:
        logType = OSLog.Data
        finalMessageType = .error
        finalMessage = "‼️ Error: "
      case .Success:
        logType = OSLog.Data
        finalMessageType = .debug
        finalMessage = "✅ "
      case .Information:
        logType = OSLog.Data
        finalMessageType = .info
        finalMessage = "💬 "
      case .Internet:
        logType = OSLog.Data
        finalMessageType = .info
        finalMessage = "🌏 "
      case .Connection:
        logType = OSLog.Data
        finalMessageType = .info
        finalMessage = "📶 "
      case .EMail:
        logType = OSLog.Data
        finalMessageType = .debug
        finalMessage = "✉️ "
      case .Tracking:
        logType = OSLog.Data
        finalMessageType = .info
        finalMessage = "📍"
      case .Password:
        logType = OSLog.Data
        finalMessageType = .debug
        finalMessage = "🔑"
      case .Secure(let toggle):
        logType = OSLog.Data
        finalMessageType = .debug
        
        switch toggle {
          case .On:
            finalMessage = "🔐 "
          case .Off:
            finalMessage = "🔓 "
      }
      case .Sound(let toggle):
        logType = OSLog.Data
        finalMessageType = .debug
        
        switch toggle {
          case .On:
            finalMessage = "🔔 "
          case .Off:
            finalMessage = "🔕 "
      }
      case .Default:
        finalMessage = "🔹 "
    }
    
    let fmtMsg = self.format(message: log, file: file, function: function, line: line)
    finalMessage += fmtMsg
    
    switch finalMessageType {
      case .info:
        os_log(.info, log: logType ?? OSLog.default, "%@", [finalMessage])
      case .debug:
        os_log(.debug, log: logType ?? OSLog.default, "%@", [finalMessage])
      case .error:
        os_log(.error, log: logType ?? OSLog.default, "%@", [finalMessage])
      case .fault:
        os_log(.fault, log: logType ?? OSLog.default, "%@", [finalMessage])
      case .none:
        os_log(.default, log: logType ?? OSLog.default, "%@", [finalMessage])
    }
    
    #else
    return
    #endif
  }
  
  private func format(message: String, file: String, function: String, line: Int) -> String {
    return "[\(sourceFileName(filePath: file))][\(function):\(line)] => \(message)"
  }
  
  private func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    let namewithext = (components.isEmpty ? "" : components.last) ?? ""
    let namenoext = namewithext.components(separatedBy: ".")
    return (namenoext.isEmpty ? "" : namenoext.first) ?? ""
  }
}

extension OSLog {
  
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  static let Debug = OSLog(subsystem: subsystem, category: "debug")
  static let Error = OSLog(subsystem: subsystem, category: "error")
  static let Warning = OSLog(subsystem: subsystem, category: "warning")
  static let Success = OSLog(subsystem: subsystem, category: "success")
  static let Information = OSLog(subsystem: subsystem, category: "information")
  static let Data = OSLog(subsystem: subsystem, category: "data")
  static let Connection = OSLog(subsystem: subsystem, category: "connection")
  static let Internet = OSLog(subsystem: subsystem, category: "internet")
  static let EMail = OSLog(subsystem: subsystem, category: "email")
  static let Tracking = OSLog(subsystem: subsystem, category: "tracking")
  static let Password = OSLog(subsystem: subsystem, category: "password")
  static let Secure = OSLog(subsystem: subsystem, category: "secure")
  static let Sound = OSLog(subsystem: subsystem, category: "sound")
  
}



