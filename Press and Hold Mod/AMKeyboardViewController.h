//  AMKeyboardViewController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMKeyboardView.h"

@protocol AMKeyboardViewControllerDelegate;

@interface AMKeyboardViewController : NSViewController <AMKeyboardViewDelegate>

@property (weak) id <AMKeyboardViewControllerDelegate> delegate;

- (IBAction)virtualKeyClicked:(NSButton *)sender;

@end


@protocol AMKeyboardViewControllerDelegate <NSObject>

- (void) keyboard:(NSView *) keyboard didPressKey:(NSButton *) sender;

@end
