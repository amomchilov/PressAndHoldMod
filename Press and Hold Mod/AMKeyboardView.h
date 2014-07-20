//
//  AMKeyboardView.h
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AMKeyboardViewDelegate;

@interface AMKeyboardView : NSView

@property (weak) id <AMKeyboardViewDelegate> delegate;

@end


@protocol AMKeyboardViewDelegate <NSObject>

- (void) keyboard:(NSView *) keyboard keyDown:(NSEvent *)event;

@end