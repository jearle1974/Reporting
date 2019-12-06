# Reporting
Xcode debug log helper framework

Installation

Add the following line to your Cocoapods pod file

  # jearle pods
  pod 'Reporting', :git => 'https://github.com/jearle1974/Reporting.git'
  
-------------------------------------

In your AppDelegate class and the following before the start of the class

  /// Add debug log report helper
  
  import Reporting
  
  let reporter = Reporter.report

-------------------------------------

In any Viewcontroller you may then add the reporter as follows

  reporter.DebugLog(log: "Memory Warning!", type: .Warning)
  
  reporter.DebugLog(log: "Error: \(error.localizedDescription)", type: .Error)
  
  reporter.showMessage(message: "FORM_SENT".localized(), title: "TITLE_UPDATE".localized(), vc: self, dismiss: true)
