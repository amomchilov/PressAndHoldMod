//
//  AMKeyboardView.h
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSView+ViewDebugging.h"
#import "AMLocaleUtilities.h"

@protocol AMKeyboardViewDelegate;

@interface AMKeyboardView : NSView

@property (weak) id <AMKeyboardViewDelegate> delegate;
- (void) updateKeyTitles;
- (BOOL) isCharacterForKeycode: (int) keycode;

@end

@protocol AMKeyboardViewDelegate <NSObject>

- (void) keyboard:(NSView *) keyboard keyDown:(NSEvent *)event;
- (void) keyboard:(NSView *) keyboard flagsChanged:(NSEvent *)event;

@end