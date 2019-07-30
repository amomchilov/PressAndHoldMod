//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import <PreferencePanes/PreferencePanes.h>
#import "AMPressAndHoldPlistModel.h"
#import "AMKeyboardVC.h"
#import "AMKeyboardView.h"
#import "AMPopoverController.h"

/**
 Main class that controls a AMKeyboardViewController, AMKeyboardViewController and AMPressAndHoldPlistModelProtocol.
 */
@interface AMPressAndHoldPrefController : NSPreferencePane <AMKeyboardVCDelegate> {
	AMPopoverController *_popoverController;
	AMKeyboardVC *_keyboardController;
	__strong id<AMPressAndHoldPlistModelProtocol> _model;
	
	__weak IBOutlet AMKeyboardView *_keyboardPlaceHolder;
	
	NSString *_currentPlist;
}

/**
 @brief An NSPopUpButton that allows users to select their language.
 */
@property (weak) IBOutlet NSPopUpButton *languagesPopUpButton;

/**
 @brief An instance of AMKeyboardView, made programmatically.
 */
@property (strong) AMKeyboardView *keyboardView;

/**
 @brief Calls updateInputSource
 
 @param sender the NSPopUpButton that called this IBAction
 */
- (IBAction) popUpButtonChanged: (NSPopUpButton *)sender;

/**
 @brief Closes the popover (if any) and sets the state of all modifier keys to unpressed.
 
 @see AMPopoverController
 @see [AMKeyboardViewController resetModifierKeyStates]
 */
- (void) resignKeyWindow;

/**
 @brief Refreshes the keyboard's labels with new language's characters, and loads the new language's plist file.
 
 @see [AMPressAndHoldPlistModelProtocol fileContentsForPlistKey:]
 @see [AMKeyboardViewController rebuildKeyLayout]
 */
- (void) updateInputSource;

@end
