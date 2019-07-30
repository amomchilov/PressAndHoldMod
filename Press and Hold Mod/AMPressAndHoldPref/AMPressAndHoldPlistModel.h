//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import "AMLocaleUtilities.h"

// For older versions of OS X:
//static NSString *const BASEPATH = @"/System/Library/Input Methods/PressAndHold.app/Contents/Resources/";
NS_ASSUME_NONNULL_BEGIN

static NSString *const BASEPATH = @"/System/Library/Input Methods/PressAndHold.app/Contents/PlugIns/PAH_Extension.appex/Contents/Resources/";

@protocol AMPressAndHoldPlistModelProtocol	
	/**
	 @return A sorted array of all languages for which plists exist (sorted by caseInsensitiveCompare:)
	 */
	- (NSArray *) sortedLanguageList;
	
	/**
	 @brief Loads the approriate plist for the key
	 
	 @param plistKey the locale code of the desired language (NSLocaleIdentifier)
	 
	 @return the contents of the plist file's contents for the given plistKey
	 */
	- (NSString *) fileContentsForPlistKey: (NSString *) plistKey;
	- (NSArray *) stringArrayForPlistKey: (NSString *) plistName
CharacterKey: (NSString *) characterKey;
@end

/**
 A class that manages read/write access of .plist files of "Press and Hold.app" 
 */
@interface AMPressAndHoldPlistModel : NSObject <AMPressAndHoldPlistModelProtocol> {
	NSMutableDictionary *_plistFiles;
}

/**
 @return A sorted array of all languages for which plists exist (sorted by caseInsensitiveCompare:)
 */
- (NSArray *) sortedLanguageList;

/**
 @brief Loads the approriate plist for the key
 
 @param plistKey the locale code of the desired language (NSLocaleIdentifier)
 
 @return the contents of the plist file's contents for the given plistKey
 */
- (NSString *) fileContentsForPlistKey: (NSString *) plistKey;
- (NSArray *) stringArrayForPlistKey: (NSString *) plistName
						CharacterKey: (NSString *) characterKey;

@end

NS_ASSUME_NONNULL_END
