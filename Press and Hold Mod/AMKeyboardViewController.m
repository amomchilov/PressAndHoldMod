//  AMKeyboardViewController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardViewController.h"

@interface AMKeyboardViewController ()

@end

@implementation AMKeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.view becomeFirstResponder];
		self.viewAsAMKeyboardView.delegate = self;
    }
    return self;
}

- (AMKeyboardView *) viewAsAMKeyboardView {
	return (AMKeyboardView *) self.view;
}

- (IBAction)virtualKeyClicked:(NSButton *)sender {
	[self.delegate keyboard: self.view didPressKey:sender];
	//[self.delegate keyboard:self didPressKey:sender];
}


- (void)keyboard:(NSView *)keyboard keyDown:(NSEvent *)event {
	DLog(@"Chars: %@ KeyCode: %hu", [event characters], [event keyCode]);
	NSButton *button = (NSButton *) [self.viewAsAMKeyboardView viewWithTag:[event keyCode]];
	if (button) {
		[button performClick:button];
	}
}

@end
