//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <PreferencePanes/PreferencePanes.h>
#import "AMPressAndHoldPlistModel.h"

@interface AMPressAndHoldPrefController : NSPreferencePane

@property AMPressAndHoldPlistModel *model;

@property (weak) IBOutlet NSView *keyboardView;
@property (weak) IBOutlet NSPopUpButton *popUpButton;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

- (IBAction) popUpButtonChanged: (id)sender;
- (void) readPlistFileIntoTextField;
- (IBAction) virtualKeyPressed: (id) sender;

@end
