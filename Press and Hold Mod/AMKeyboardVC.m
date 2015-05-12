//  AMKeyboardViewController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardVC.h"

const int AMKeyMasks[] = {
	NSShiftKeyMask,
	NSFunctionKeyMask,
	NSControlKeyMask,
	NSAlternateKeyMask,
	NSCommandKeyMask,
	NSShiftKeyMask,
	NSControlKeyMask,
	NSAlternateKeyMask,
	NSCommandKeyMask
};

//case 56: keytype = AMLeftShift;		break;
//case 60: keytype = AMRightShift;	break;
//case 59: keytype = AMLeftControl;	break;
//case 00: keytype = AMRightControl;	break;//TODO: need right control keycode
//case 58: keytype = AMLeftOption;	break;
//case 61: keytype = AMRightOption;	break;
//case 55: keytype = AMLeftCommand;	break;
//case 54: keytype = AMRightCommand;	break;

enum AMModifierKeyType {
	AMLeftShift		= 56,
	AMLeftFn		= 00, //TODO: figure out
	AMLeftControl	= 59,
	AMLeftOption	= 58,
	AMLeftCommand	= 55,
	AMRightShift	= 60,
	AMRightControl	= 01, //TODO: figure out
	AMRightOption	= 61,
	AMRightCommand	= 54};

@implementation AMKeyboardVC;

#pragma mark NSViewController methods

- (instancetype) initWithNibName:(NSString *)nibNameOrNil
						  bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil]) {
		_model = [[AMKeyboardModel alloc] init];
		self.viewAsAMKeyboardView.delegate = self;
    }
    return self;
}

#pragma mark AMKeyboardViewDelegate methods
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *) sender {
	int modifiers = self.getModifierFlags;

	NSEvent *event =
	[NSEvent keyEventWithType: NSKeyDown
					 location: NSZeroPoint
				modifierFlags: modifiers
					timestamp: NSProcessInfo.processInfo.systemUptime
				 windowNumber: sender.window.windowNumber
					  context: sender.window.graphicsContext
				   characters: [AMLocaleUtilities stringForKeyCode: (int) sender.tag
											  WithNSEventModifiers: modifiers]
  charactersIgnoringModifiers: [AMLocaleUtilities stringForKeyCode: (int) sender.tag
											  WithNSEventModifiers: 0]
					isARepeat: NO
					  keyCode: sender.tag];
	if ([self.delegate respondsToSelector: @selector(keyboard:virtualKeyDownFromButton:ForEvent:)])
		[self.delegate keyboard: self.viewAsAMKeyboardView virtualKeyDownFromButton: sender ForEvent: event];
}

- (void) keyboard:(AMKeyboardView *) keyboard
		 keyDown:(NSEvent *) event {
	NSButton *button = (NSButton *) [self.viewAsAMKeyboardView viewWithTag: event.keyCode];
	if (button) [button performClick: button];
}

- (void) keyboard:(AMKeyboardView *)keyboard flagsChanged:(NSEvent *)event {
	NSEventModifierFlags modifierFlags = event.modifierFlags;
	enum AMModifierKeyType keytype = event.keyCode;
	NSEventModifierFlags appropriateKeyMask;

	switch (keytype) {
		case AMLeftFn:
			appropriateKeyMask = NSFunctionKeyMask;
			break;

		case AMLeftShift:
		case AMRightShift:
			appropriateKeyMask = NSShiftKeyMask;
			break;

		case AMLeftControl:
		case AMRightControl:
			appropriateKeyMask = NSControlKeyMask;
			break;

		case AMLeftOption:
		case AMRightOption:
			appropriateKeyMask = NSAlternateKeyMask;
			break;

		case AMLeftCommand:
		case AMRightCommand:
			appropriateKeyMask = NSCommandKeyMask;
			break;
	}

	[self setModifierState: !!(modifierFlags & appropriateKeyMask)
				ForKeyCode: event.keyCode];
	
	[self updateKeyTitlesWithModifiers: (int) event.modifierFlags];

	if ([self.delegate respondsToSelector: @selector(keyboard:ModifierDown:ModifierKey:)]) {
		//TODO: add state machines to detect key up vs key down
		//		[self.delegate keyboard: self.viewAsAMKeyboardView ModifierDown: event ModifierKey: keytype];
	}
}

//- (void) TEMPkeyboard:(AMKeyboardView *)keyboard flagsChanged:(NSEvent *)event {
//	DLog("%lu", (unsigned long)event.modifierFlags);
//    if ((event.modifierFlags & NSShiftKeyMask) && !lastShiftState) { //shift down
//		lastShiftState = true;
//		[self setModifierState: YES ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyShiftDown:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyShiftDown: event];
//    }
//	else if (!(event.modifierFlags & NSShiftKeyMask) && lastShiftState) { //shift raised
//		lastShiftState = false;
//		[self setModifierState: NO ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyShiftUp:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyShiftUp: event];
//	}
//	
//	else if ((event.modifierFlags & NSFunctionKeyMask) && !lastFnState) {
//		lastFnState = true;
//		[self setModifierState: YES ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyFnDown:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyFnDown: event];
//	}
//	else if (!(event.modifierFlags & NSFunctionKeyMask) && lastFnState) {
//		lastFnState = false;
//		[self setModifierState: NO ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyFnUp:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyFnUp: event];
//	}
//	
//	else if ((event.modifierFlags & NSControlKeyMask) && !lastControlState) {
//		lastControlState = true;
//		[self setModifierState: YES ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyControlDown:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyControlDown: event];
//	}
//	else if (!(event.modifierFlags & NSControlKeyMask) && lastControlState) {
//		lastControlState = false;
//		[self setModifierState: NO ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyControlUp:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyControlUp: event];
//	}
//	
//	
//	else if ((event.modifierFlags & NSAlternateKeyMask) && !lastOptionState) {
//		lastOptionState = true;
//		[self setModifierState: YES ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyOptionDown:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyOptionDown: event];
//	}
//	else if (!(event.modifierFlags & NSAlternateKeyMask) && lastOptionState) {
//		lastOptionState = false;
//		[self setModifierState: NO ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyOptionUp:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyOptionUp: event];
//	}
//	
//	else if ((event.modifierFlags & NSCommandKeyMask) && !lastCommandState) {
//		lastCommandState = true;
//		[self setModifierState: YES ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyCommandDown:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyCommandDown: event];
//	}
//	else if (!(event.modifierFlags & NSCommandKeyMask) && lastCommandState) {
//		lastCommandState = false;
//		[self setModifierState: NO ForKeyCode: event.keyCode];
//		if ([self.delegate respondsToSelector:@selector(keyboard:KeyCommandUp:)])
//			[self.delegate keyboard: self.viewAsAMKeyboardView KeyCommandUp: event];
//	}
//
//	else DLog("Other");
//	
//	[self updateKeyTitlesWithModifiers: (int) event.modifierFlags];
//}

- (void) keyboard:(AMKeyboardView *) keyboard updateKeyTitlesWithModifiers:(int) modifiers {
	[self updateKeyTitlesWithModifiers: modifiers];
}

#pragma mark Other methods
- (AMKeyboardView *) viewAsAMKeyboardView {
	return (AMKeyboardView *) self.view;
}

- (void) rebuildKeyLayout {
	[_model rebuildKeyLayout];
	[self updateKeyTitlesWithModifiers: 0];
}

- (void) updateKeyTitlesWithModifiers:(int) modifiers {
	for (NSView *v in self.view.subviews) {
		if ([v isKindOfClass:[NSButton class]] && [AMLocaleUtilities isCharacterForKeycode: (int) v.tag]) {
			NSButton *b = (NSButton *) v;
			NSString *s = [_model stringForKeyCode: (int) b.tag WithNSEventModifiers: modifiers];
			if (s) b.title = s;
		}
	}
}

- (void) setModifierState:(BOOL) state ForKeyCode:(int) keycode {
	AMModifierButton *button = [self getModifierButton: keycode];
	if (button) [button setMouseEnabledAndState: state];
}

- (void) resetModifierKeyStates {
	for (int i = 0; i < sizeof(modifierKeyCodes)/sizeof(*modifierKeyCodes); i++) {
		[self setModifierState: NO ForKeyCode: modifierKeyCodes[i]];
	}
	[self updateKeyTitlesWithModifiers: 0];
}

- (AMModifierButton *) getModifierButton: (enum AMModifierKeyType) type {
	return (AMModifierButton *) [self.viewAsAMKeyboardView viewWithTag: type];
}

- (NSEventModifierFlags) getModifierFlags {
	NSEventModifierFlags flags = 0;

	if ([[self getModifierButton: AMLeftFn]			isPressed])
		flags |= NSFunctionKeyMask;

	if ([[self getModifierButton: AMLeftShift]		isPressed] ||
		[[self getModifierButton: AMRightShift]		isPressed])
		flags |= NSShiftKeyMask;

	if ([[self getModifierButton: AMLeftControl]	isPressed] ||
		[[self getModifierButton: AMRightControl]	isPressed])
		flags |= NSControlKeyMask;

	if ([[self getModifierButton: AMLeftOption]		isPressed] ||
		[[self getModifierButton: AMRightOption]	isPressed])
		flags |= NSAlternateKeyMask;

	if ([[self getModifierButton: AMLeftCommand]	isPressed] ||
		[[self getModifierButton: AMRightCommand]	isPressed])
		flags |= NSCommandKeyMask;

	return flags;
}

@end
