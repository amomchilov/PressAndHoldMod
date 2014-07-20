//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <PreferencePanes/PreferencePanes.h>
#import "AMPressAndHoldPlistModel.h"
#import "AMKeyboardViewController.h"
#import "AMKeyboardView.h"
#import "AMPopoverController.h"

@interface AMPressAndHoldPrefController : NSPreferencePane <AMKeyboardViewControllerDelegate>

@property AMKeyboardViewController *keyboardController;
@property AMPressAndHoldPlistModel *model;

@property (weak) IBOutlet NSPopUpButton *popUpButton;
@property (weak) IBOutlet NSView *keyboardPlaceHolder;
@property (strong) NSView *keyboardView;
@property (weak) IBOutlet NSPopover *popover;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property AMPopoverController *popoverController;

- (IBAction) popUpButtonChanged: (id)sender;
- (void) readPlistFileIntoTextField;

@end
