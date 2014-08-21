//  AMKeyboardView.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

@protocol AMKeyboardViewDelegate;

/**
 A custom NSView subclass that represents an onscreen keyboard
 */
@interface AMKeyboardView : NSView

/**
 @brief A delegate to recieve call backs from the keyboard
 
 @see AMKeyboardViewDelegate
 */
@property (weak) id <AMKeyboardViewDelegate> delegate;

@end

/**
 @brief  A delegate to recieve call backs from the keyboard
 
 @see AMKeyboardView
 */
@protocol AMKeyboardViewDelegate <NSObject>

/**
 @brief Informs the receiver that the user has clicked an onscreen-key.
 
 @param keyboard The keyboard that sent this call
 @param sender   The NSButton that sent this call
 */
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender;

/**
 @brief Informs the receiver that the user has pressed a key.
 
 @param keyboard The keyboard that sent this call
 @param event    An object encapsulating information about the key-down event.
 */
- (void) keyboard:(AMKeyboardView *) keyboard keyDown:(NSEvent *)event;

/**
 @brief Informs the receiver that the user has pressed or released a modifier key (Shift, Control, and so on).
 
 @param keyboard The keyboard that sent this call
 @param event    An object encapsulating information about the modifier-key event.
 */
- (void) keyboard:(AMKeyboardView *) keyboard flagsChanged:(NSEvent *)event;

/**
 @brief Updates the key labels to have the correct labels for the given modifiers.
 
 @param keyboard  The keyboard to update
 @param modifiers The modifier keys to be accounted for
 
 @discussion This is used to delegate key label logic up.
 */
- (void) keyboard:(AMKeyboardView *) keyboard updateKeyTitlesWithModifiers:(int) modifiers;

@end