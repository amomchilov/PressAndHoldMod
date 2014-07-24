//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import "AMLocaleUtilities.h"

static NSString *const BASEPATH = @"/System/Library/Input Methods/PressAndHold.app/Contents/Resources/";

@interface AMPressAndHoldPlistModel : NSObject

@property NSMutableDictionary *plistFiles;
@property NSString *activePlistFilePath;

- (NSArray *) sortedLanguageList;
- (NSString *) fileContentsForPlistKey: (NSString *) plistKey;
- (NSArray *) stringArrayForPlistKey: (NSString *) plistKey
						CharacterKey: (NSString *) characterKey;

@end
