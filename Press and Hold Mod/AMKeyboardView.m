//  AMKeyboardView.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (void)awakeFromNib {
	[self updateKeyTitles];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)event {
	if ([self isCharacterForKeycode: event.keyCode]) {
		//pass desired keyDown event to the delegate
		[self.delegate keyboard: self keyDown: event];
	}
	else {
		//pass undesired keyDown event to the nextResponder
		[self.nextResponder keyDown:event];
	}
}

- (void) flagsChanged:(NSEvent *)event {
    if ((event.modifierFlags & NSShiftKeyMask) == NSShiftKeyMask) {
        DLog(@"Shift: %i", event.keyCode);
    }
//    else if ((event.modifierFlags & NSFunctionKeyMask) == NSFunctionKeyMask) {
//        DLog(@"Fn: %i", event.keyCode);
//    }
//    else if ((event.modifierFlags & NSControlKeyMask) == NSControlKeyMask) {
//        DLog(@"Control: %i", event.keyCode);
//    }
//    else if ((event.modifierFlags & NSAlternateKeyMask) == NSAlternateKeyMask) {
//        DLog(@"Option: %i", event.keyCode);
//    }
//    else if ((event.modifierFlags & NSCommandKeyMask) == NSCommandKeyMask) {
//        DLog(@"Command: %i", event.keyCode);
//    }
}

- (void) updateKeyTitles {
	for (NSView *v in self.subviews) {
		if ([v isKindOfClass:[NSButton class]] && [self isCharacterForKeycode: (int) v.tag]) {
			NSButton *b = (NSButton *) v;
			NSString *s = [AMLocaleUtilities stringForKeyCode: (int) b.tag];
			if (s) b.title = s;
			else b.title = @"";
		}
	}
}

- (BOOL) isCharacterForKeycode: (int) keycode {
	if (0 <= keycode
		&& keycode <= 50
		&& keycode != 10
		&& keycode != 36
		&& keycode != 48
		&& keycode != 49) return YES;
	return NO;
}

/*		case 36:	//enter
 case 48:	//tab
 case 51:	//delete (backspace)
 case 53:	//esc
 case 56:	//shift - left
 case 60:	//shift - right
 case 63:	//fn
 case 59:	//control - left
 case 62:	//control - right
 case 58:	//option - left
 case 61:	//option - right
 case 55:	//command - left
 case 54:	//command - right
 case 122:	//F1
 case 120:	//F2
 case 99:	//F3
 case 118:	//F4
 case 96:	//F5
 case 97:	//F6
 case 98:	//F7
 case 100:	//F8
 case 101:	//F9
 case 109:	//F10
 case 103:	//F11
 case 111:	//F12
 case 123:	//arrow - left
 case 124:	//arrow - right
 case 125:	//arrow - down
 case 126:	//arrow - up*/

@end
