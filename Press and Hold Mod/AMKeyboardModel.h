//  AMKeyboardModel.h
//  Created by Alexander Momchilov on 2014-07-27.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import "AMLocaleUtilities.h"

extern const int characterKeyCodes[47];
extern const int modifierKeyCodes[8];

/**
 A class for storing the key labels of a keyboard, including key labels for when modifier keys are pressed.
 */
@interface AMKeyboardModel : NSObject

/**
 @brief A nested dictionary which represents a set of keyboard key labels. Access this via stringForKeyCode:WithNSEventModifiers:
 
 @discussion This dictionary contains 4 nested dictionaries:
 
 - 0 : Dictionary for no modifier keys
 
 - NSShiftKeyMask : Dictionary for ⇧ (shift) pressed
 
 - NSAlternateKeyMask : Dictionary for ⌥ (option) pressed
 
 - NSShiftKeyMask & NSAlternateKeyMask : Dictionary for both ⇧ (shift) and ⌥ (option) pressed
 
 Each of these nested dictionaries maps int (keycodes) to NSString  (key label)

 */
@property NSDictionary *keyLayouts;

/**
 Rebuilds the current keyLayouts dictionary, updating it with new keylabels
 
 Uses [AMLocaleUtilities stringForKeyCode:WithNSEventModifiers:] to get new key labels for each keycode/modifier combination
 */
- (void) rebuildKeyLayout;

/**
 @brief Accesses the keyLayouts dictionary and returns the key label for the given parameters
 
 @param keycode   The keycode of the desired key label
 @param modifiers The modifier state of the desired key label
 
 @return The key label for the given parameters
 @warning This method can return nil for invalid keycode/modifiers
 */
- (NSString *) stringForKeyCode: (int) keycode WithNSEventModifiers: (int) modifiers;

@end
