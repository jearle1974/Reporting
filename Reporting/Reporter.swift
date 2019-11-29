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

public enum Type {
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
    var finalMessage: String
    
    switch type {
      case .Data:
        finalMessage = "🗄️ "
      case .Warning:
        finalMessage = "⚠️ "
      case .Error:
        finalMessage = "‼️ "
      case .Success:
        finalMessage = "✅ "
      case .Information:
        finalMessage = "💬 "
      case .Internet:
        finalMessage = "🌏 "
      case .Connection:
        finalMessage = "📶 "
      case .EMail:
        finalMessage = "✉️ "
      case .Tracking:
        finalMessage = "📍"
      case .Password:
        finalMessage = "🔑"
      case .Secure(let toggle):
        switch toggle {
          case .On:
            finalMessage = "🔐 "
          case .Off:
            finalMessage = "🔓 "
      }
      case .Sound(let toggle):
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
    print(finalMessage)
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
