//  AMKeyboardViewController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardViewController.h"

@implementation AMKeyboardViewController

#pragma mark NSViewController methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.viewAsAMKeyboardView.delegate = self;
    }
    return self;
}

#pragma mark AMKeyboardViewDelegate methods
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender {
	NSEvent *event = [NSEvent keyEventWithType: NSKeyDown
									  location: NSZeroPoint //
								 modifierFlags: 0 //
									 timestamp: [[NSProcessInfo processInfo] systemUptime]
								  windowNumber: sender.window.windowNumber
									   context: sender.window.graphicsContext
									characters: sender.title
				   charactersIgnoringModifiers: @""
									 isARepeat: NO
									   keyCode: sender.tag];
	if ([self.delegate respondsToSelector:@selector(keyboard:virtualKeyDownFromButton:ForEvent:)])
		[self.delegate keyboard: self.viewAsAMKeyboardView virtualKeyDownFromButton: sender ForEvent: event];
}

- (void)keyboard:(AMKeyboardView *)keyboard keyDown:(NSEvent *)event {
	//NSLog(@"%@", event);
	[self performClickForKeyCode: event.keyCode];
}

- (void)keyboard:(AMKeyboardView *)keyboard flagsChanged:(NSEvent *)event {
	//DLog("%lu", (unsigned long)event.modifierFlags);
    if ((event.modifierFlags & NSShiftKeyMask) == NSShiftKeyMask && !lastShiftState) { //shift down
		lastShiftState = true;
		[self.viewAsAMKeyboardView updateKeyTitleWithCaptitalization: YES];
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyShiftDown:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyShiftDown: event];
    }
	else if ((event.modifierFlags & NSShiftKeyMask) != NSShiftKeyMask && lastShiftState) { //shift raised
		lastShiftState = false;
		[self.viewAsAMKeyboardView updateKeyTitleWithCaptitalization: NO];
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyShiftUp:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyShiftUp: event];
	}
	
	else if ((event.modifierFlags & NSFunctionKeyMask) == NSFunctionKeyMask && !lastFnState) {
		lastFnState = true;
	    DLog(@"Fn down: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyFnDown:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyFnDown: event];
	}
	else if ((event.modifierFlags & NSFunctionKeyMask) != NSFunctionKeyMask && lastFnState) {
		lastFnState = false;
	    DLog(@"Fn up: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyFnUp:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyFnUp: event];
	}
	
	else if ((event.modifierFlags & NSControlKeyMask) == NSControlKeyMask && !lastControlState) {
		lastControlState = true;
	    DLog(@"Control down: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyControlDown:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyControlDown: event];
	}
	else if ((event.modifierFlags & NSControlKeyMask) != NSControlKeyMask && lastControlState) {
		lastControlState = false;
	    DLog(@"Control up: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyControlUp:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyControlUp: event];
	}
	
	
	else if ((event.modifierFlags & NSAlternateKeyMask) == NSAlternateKeyMask && !lastOptionState) {
		lastOptionState = true;
	    DLog(@"Option down: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyOptionDown:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyOptionDown: event];
	}
	else if ((event.modifierFlags & NSAlternateKeyMask) != NSAlternateKeyMask && lastOptionState) {
		lastOptionState = false;
	    DLog(@"Option up: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyOptionUp:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyOptionUp: event];
	}
	
	else if ((event.modifierFlags & NSCommandKeyMask) == NSCommandKeyMask && !lastCommandState) {
		lastCommandState = true;
	    DLog(@"Command down: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyCommandDown:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyCommandDown: event];
	}
	else if ((event.modifierFlags & NSCommandKeyMask) != NSCommandKeyMask && lastCommandState) {
		lastCommandState = false;
	    DLog(@"Command up: %i", event.keyCode);
		if ([self.delegate respondsToSelector:@selector(keyboard:KeyCommandUp:)])
			[self.delegate keyboard: self.viewAsAMKeyboardView KeyCommandUp: event];
	}

	else {
		DLog("Other");
	}
	
	[self performClickForKeyCode: event.keyCode];
}

#pragma mark Other methods
- (AMKeyboardView *) viewAsAMKeyboardView {
	return (AMKeyboardView *) self.view;
}

- (void) performClickForKeyCode: (int) keycode {
	NSButton *button = (NSButton *) [self.viewAsAMKeyboardView viewWithTag: keycode];
	if (button) [button performClick:button];
}


- (void) updateKeyTitles {
	[self.viewAsAMKeyboardView updateKeyTitles];
}

@end
