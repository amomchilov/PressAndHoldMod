//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <PreferencePanes/PreferencePanes.h>
#import "AMPressAndHoldPlistModel.h"
#import "AMKeyboardView.h"

@interface AMPressAndHoldPrefController : NSPreferencePane <AMKeyboardViewDelegate>

@property AMPressAndHoldPlistModel *model;

@property (weak) IBOutlet NSView *keyboardPlaceHolder;
@property (strong) AMKeyboardView *keyboardView;
@property (weak) IBOutlet NSPopUpButton *popUpButton;
@property (weak) IBOutlet NSPopover *popOver;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

- (IBAction) popUpButtonChanged: (id)sender;
- (void) readPlistFileIntoTextField;

- (IBAction)showPopOver:(id)sender;

@end
