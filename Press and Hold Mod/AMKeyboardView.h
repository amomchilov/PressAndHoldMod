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
- (void) updateKeyTitlesWithModifiers:(int) modifiers;

@end

@protocol AMKeyboardViewDelegate <NSObject>

- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender;
- (void) keyboard:(AMKeyboardView *) keyboard keyDown:(NSEvent *)event;
- (void) keyboard:(AMKeyboardView *) keyboard flagsChanged:(NSEvent *)event;

@end