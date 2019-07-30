//  AMKeyboardViewController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMKeyboardView.h"
#import "AMKeyboardModel.h"
#import "AMModifierButton.h"

@protocol AMKeyboardVCDelegate; //forward declaration

@interface AMKeyboardVC : NSViewController <AMKeyboardViewDelegate> {
	AMKeyboardModel *_model;
	BOOL *_modifierStates;
}

@property (weak) id <AMKeyboardVCDelegate> delegate;

#pragma mark Other methods
- (AMKeyboardView *) viewAsAMKeyboardView;
- (void) rebuildKeyLayout;
- (void) updateKeyTitlesWithModifiers:(int) modifiers;

@end


@protocol AMKeyboardVCDelegate <NSObject>

@optional

- (void) keyDown:(NSEvent *) event
	  fromButton:(NSButton *) button;

- (void) keyUp:(NSEvent *) event
	fromButton:(NSButton *) button;

- (void) modDown:(NSEvent *) event
	  fromButton:(NSButton *) button;

- (void) modUp:(NSEvent *) event
	fromButton:(NSButton *) button;

@end