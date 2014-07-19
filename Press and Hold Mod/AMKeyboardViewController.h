//  AMKeyboardViewController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMKeyboardView.h"

@protocol AMKeyboardViewDelegate;

@interface AMKeyboardViewController : NSViewController

@property (weak) id <AMKeyboardViewDelegate> delegate;

- (IBAction)virtualKeyPressed:(NSButton *)sender;

@end


@protocol AMKeyboardViewDelegate <NSObject>

- (void) keyboard:(NSView *) keyboard didPressKey:(NSButton *) sender;

@end
