//  AMKeyboardModel.h
//  Created by Alexander Momchilov on 2014-07-27.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import "AMLocaleUtilities.h"

extern const int characterKeyCodes[47];
extern const int modifierKeyCodes[8];

@interface AMKeyboardModel : NSObject

@property NSDictionary *keyLayouts;

- (void) rebuildKeyLayout;
- (NSString *) stringForKeyCode: (int) keycode WithNSEventModifiers: (int) modifiers;

@end
