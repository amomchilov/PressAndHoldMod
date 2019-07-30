//
//  MojavePressAndHoldListModel.swift
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2019-07-29.
//  Copyright © 2019 Alexander Momchilov. All rights reserved.
//

import Foundation

fileprivate let mojavePath = "/System/Library/Input Methods/PressAndHold.app/Contents/PlugIns/PAH_Extension.appex/Contents/Resources/"

class MojavePressAndHoldListModel: NSObject, AMPressAndHoldPlistModelProtocol {
	let plistFiles: [String: String]
	
	override init() {
		
		
		var plistFiles = [String: String]()
		
		let fm = FileManager.default
		let plistPredicate = NSPredicate.init(format: "SELF like %@", "Keyboard*.plist")
		let plistFilenames = try! (fm.contentsOfDirectory(atPath: mojavePath) as NSArray).filtered(using: plistPredicate) as! [NSString]
		
		for plistFilename in plistFilenames {
			let plistFileLocaleCode = plistFilename.substring(with: NSRange(location: 9, length: plistFilename.length - 9 - 6))
			let localeName = AMLocaleUtilities.localeCode(to: plistFileLocaleCode)
			let plistFilePath = mojavePath + (plistFilename as String)
			if let localeName = localeName {
				plistFiles[localeName] = plistFilePath
			}
		}
		
		self.plistFiles = plistFiles
		
		super.init()
	}
	
	func sortedLanguageList() -> [Any] {
		return self.plistFiles.keys.sorted(by: { $0.caseInsensitiveCompare($1) == .orderedAscending })
	}
	
	func fileContents(forPlistKey plistKey: String) -> String {
		let activePlistFilePath = self.plistFiles[plistKey]!
		let activePlistFileURL = URL(fileURLWithPath: activePlistFilePath, isDirectory: false)
		return try! String(contentsOf: activePlistFileURL, encoding: .utf8);
	}
	
	func stringArray(forPlistKey plistName: String, characterKey: String) -> [Any] {
		let plistPath = self.plistFiles[plistName]!
		let plistContents = NSDictionary(contentsOfFile: plistPath)!
	
		guard let characterDict = plistContents["Roman-Accent-\(characterKey)"] as? NSDictionary,
			let keycapsString = characterDict["Keycaps"] as? String else {
			return []
		}
		
		let keycaps = keycapsString.components(separatedBy: " ")
		return Array(keycaps.dropFirst())
	}
}
