//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import <PreferencePanes/PreferencePanes.h>
#import "AMPressAndHoldPlistModel.h"
#import "AMKeyboardViewController.h"
#import "AMKeyboardView.h"
#import "AMPopoverController.h"

@interface AMPressAndHoldPrefController : NSPreferencePane <AMKeyboardViewControllerDelegate> {
	AMKeyboardViewController *_keyboardController;
	AMPressAndHoldPlistModel *_model;
	__weak NSButton *_b1;
	__weak NSButton *_b2;
	
	NSString *_currentPlist;
}

@property (weak) IBOutlet NSPopUpButton *popUpButton;
@property (weak) IBOutlet NSView *keyboardPlaceHolder;
@property (strong) AMKeyboardView *keyboardView;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property AMPopoverController *popoverController;

- (IBAction) popUpButtonChanged: (NSPopUpButton *)sender;
- (void) updateInputSource;

@property (weak) IBOutlet NSButton *b1;
@property (weak) IBOutlet NSButton *b2;
@end
