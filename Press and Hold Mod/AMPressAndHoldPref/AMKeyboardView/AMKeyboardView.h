//  AMKeyboardView.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

@protocol AMKeyboardViewDelegate; //forward declaration

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

@optional

/**
 @brief Informs the receiver that the user has pressed or released a key.

 @param keyAction	An enumeration that's either AMKeyUp or AMKeyDown
 @param event    An object encapsulating information about the key-down event.
 */
- (void) physicalKeyEvent:(NSEvent *) event;

/**
 @brief Informs the receiver that the user has pressed or released a modifier key (Shift, Control, and so on).

 @param event    An object encapsulating information about the modifier-key event.
 */
- (void) flagsChanged:(NSEvent *) event;

/**
 @brief  Informs the receiver that the user has clicked or released an on-screen button.

 @param sender	The button that was clicked or released
 */
- (void) buttonAction:(NSButton *) sender;

@end