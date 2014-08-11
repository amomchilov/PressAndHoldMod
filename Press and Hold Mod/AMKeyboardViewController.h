//  AMKeyboardViewController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMKeyboardView.h"
#import "AMKeyboardModel.h"
#import "AMModifierButton.h"

@protocol AMKeyboardViewControllerDelegate;

@interface AMKeyboardViewController : NSViewController <AMKeyboardViewDelegate> {
	AMKeyboardModel *_model;
	BOOL lastShiftState;
	BOOL lastFnState;
	BOOL lastControlState;
	BOOL lastOptionState;
	BOOL lastCommandState;
}

@property (weak) id <AMKeyboardViewControllerDelegate> delegate;

- (AMKeyboardView *) viewAsAMKeyboardView;
- (void) rebuildKeyLayout;
- (void) updateKeyTitlesWithModifiers:(int) modifiers;
- (void) setModifierState:(BOOL) state ForKeyCode:(int) keycode;
- (void) resetModifierKeyStates;

@end


@protocol AMKeyboardViewControllerDelegate <NSObject>

@optional
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender ForEvent:(NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyShiftDown: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyShiftUp: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyFnDown: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyFnUp: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyControlDown: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyControlUp: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyOptionDown: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyOptionUp: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyCommandDown: (NSEvent *) event;
- (void) keyboard:(AMKeyboardView *) keyboard KeyCommandUp: (NSEvent *) event;

@end
