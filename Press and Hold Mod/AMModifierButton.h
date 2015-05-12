//  AMModifierButton.h
//  Created by Alexander Momchilov on 2014-08-03.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

/**
 A subclass of NSButton that can have its response to mouse clicks disabled, while remaining visually unchanged
 */
@interface AMModifierButton : NSButton {
	BOOL _mouseEnabled;
}

@property long representedKeyMask;

/**
 @brief Sets the visual and mouseEnabaled state of the button
 
 @param state The new visual and mouseEnabled state
 */
- (void) setMouseEnabledAndState:(BOOL) state;

- (BOOL) isPressed;

@end
