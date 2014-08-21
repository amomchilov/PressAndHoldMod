//  AMKeyboardViewController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMKeyboardView.h"
#import "AMKeyboardModel.h"
#import "AMModifierButton.h"

@protocol AMKeyboardViewControllerDelegate;

/**
 A NSViewController subclass that manages an AMKeyboardView and AMKeyboardModel
 */
@interface AMKeyboardViewController : NSViewController <AMKeyboardViewDelegate> {
	AMKeyboardModel *_model;
	BOOL lastShiftState;
	BOOL lastFnState;
	BOOL lastControlState;
	BOOL lastOptionState;
	BOOL lastCommandState;
}

/**
 @brief A delegate to recieve call backs from the keyboard
 @see AMKeyboardViewControllerDelegate
 */
@property (weak) id <AMKeyboardViewControllerDelegate> delegate;

/**
 @return this NSViewController's view as an AMKeyboardView
 */
- (AMKeyboardView *) viewAsAMKeyboardView;

/**
 @brief Rebuilds this keyboard's key labels with the current language's character set
 */
- (void) rebuildKeyLayout;

/**
 @brief  Updates this keyboard's key labels to respond to the given modifier code
 
 @param modifiers the modifiers encoded in the same way as NSEvent's modifierFlags
 */
- (void) updateKeyTitlesWithModifiers:(int) modifiers;

/**
 @brief  Sets the state of an AMModifierButton with the given keycode to state
 
 @param state   the state to put the AMModifierButton in
 @param keycode the keycode of the AMModifierButton whose state is to be changed
 */
- (void) setModifierState:(BOOL) state ForKeyCode:(int) keycode;

/**
 @brief  Updates this keyboard's key labels to the default state, and releases all AMModifierButtons
 */
- (void) resetModifierKeyStates;

@end

/**
 @brief A protocol that must be conformed to by the delegate to recieve AMKeyboardView events
 */
@protocol AMKeyboardViewControllerDelegate <NSObject>

@optional

/**
 @brief Called when a virtual key is pressed
 
 @param keyboard the AMKeyboardView that sent the call
 @param sender   the virtual key that sent the call
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender ForEvent:(NSEvent *) event;

/**
 @brief Called when ⇧ (shift) is pressed
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyShiftDown: (NSEvent *) event;

/**
 @brief Called when ⇧ (shift) is released
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyShiftUp: (NSEvent *) event;

/**
 @brief  Called when Fn (function) is pressed
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyFnDown: (NSEvent *) event;

/**
 @brief  Called when Fn (function) is released
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyFnUp: (NSEvent *) event;

/**
 @brief  Called when ⌃ (control) is pressed
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyControlDown: (NSEvent *) event;

/**
 @brief  Called when ⌃ (control) is released
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyControlUp: (NSEvent *) event;

/**
 @brief  Called when ⌥ (option) is pressed
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyOptionDown: (NSEvent *) event;

/**
 @brief  Called when ⌥ (option) is released
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyOptionUp: (NSEvent *) event;

/**
 @brief  Called when ⌘ (command) is pressed
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyCommandDown: (NSEvent *) event;

/**
 @brief  Called when ⌘ (command) is released
 
 @param keyboard the AMKeyboardView that sent the call 
 @param event    the generated NSEvent for this key call
 */
- (void) keyboard:(AMKeyboardView *) keyboard KeyCommandUp: (NSEvent *) event;

@end
