//
//  MojavePressAndHoldListModel.swift
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2019-07-29.
//  Copyright © 2019 Alexander Momchilov. All rights reserved.
//

import Foundation

fileprivate let mojaveURL = URL(fileURLWithPath:
	"/System/Library/Input Methods/PressAndHold.app/Contents/PlugIns/PAH_Extension.appex/Contents/Resources/", isDirectory: false)

class MojavePressAndHoldListModel: NSObject, AMPressAndHoldPlistModelProtocol {
	let plistFilesByLocaleName: [String: URL]
	
	override init() {
		let plistURLs = try! FileManager.default.contentsOfDirectory(
				at: mojaveURL,
				includingPropertiesForKeys: [.nameKey],
				options: .skipsHiddenFiles
			).filter { $0.lastPathComponent.starts(with: "Keyboard") && $0.pathExtension == "plist" }
		
		func extractLocaleName(fromPlistURL plistURL: URL) -> String? {
			let filename = plistURL.lastPathComponent
			let localeCode = String(filename.dropFirst("Keyboard-".count).dropLast(".plist".count))
			return AMLocaleUtilities.localeCode(to: localeCode)
		}
		
		
		self.plistFilesByLocaleName = Dictionary(uniqueKeysWithValues:
			plistURLs.lazy.compactMap { url -> (key: String, value: URL)? in
				guard let localeName = extractLocaleName(fromPlistURL: url) else { return nil }
				return (key: localeName, value: url)
			}
		)
		
		super.init()
	}
	
	func sortedLanguageList() -> [Any] {
		return self.plistFilesByLocaleName
			.keys
			.sorted(by: { $0.caseInsensitiveCompare($1) == .orderedAscending })
	}
	
	func fileContents(forPlistKey plistKey: String) -> String {
		let activePlistFileURL = self.plistFilesByLocaleName[plistKey]!
		return try! String(contentsOf: activePlistFileURL, encoding: .utf8);
	}
	
	func stringArray(forPlistKey plistName: String, characterKey: String) -> [Any] {
		let plistPath = self.plistFilesByLocaleName[plistName]!
		let plistContents = NSDictionary(contentsOf: plistPath)!
	
		guard let characterDict = plistContents["Roman-Accent-\(characterKey)"] as? NSDictionary,
			let keycapsString = characterDict["Keycaps"] as? String else {
			return []
		}
		
		let keycaps = keycapsString.components(separatedBy: " ")
		return Array(keycaps.dropFirst())
	}
}
