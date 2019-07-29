//  AMKeyboardViewController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardVC.h"

@implementation AMKeyboardVC;

#pragma mark NSViewController methods

- (instancetype) initWithNibName:(NSString *)nibNameOrNil
						  bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil]) {
		_model = [[AMKeyboardModel alloc] init];
		self.viewAsAMKeyboardView.delegate = self;

		_modifierStates = calloc(AMModifierKeyCodes_Size, sizeof(BOOL));
	}
	return self;
}

- (void) physicalKeyEvent: (NSEvent *) event {
	[self combinedKeyEvent: event
				fromButton: [self.view viewWithTag: event.keyCode]];
}

- (void) flagsChanged:(NSEvent *) event {
	[self combinedModEvent: event
				fromButton: [self.view viewWithTag: event.keyCode]];
}

- (void) buttonAction:(NSButton *) sender {
	NSEventType keyEventAction;

	if ([AMKeyboardModel isModifier: sender.tag]) keyEventAction = NSFlagsChanged;
	else {
		switch (sender.state) {
			case NSOnState:
				keyEventAction = NSKeyUp;
				break;

			case NSMixedState:
			case NSOffState:
			default:
				keyEventAction = NSKeyDown;
				break;
		}
	}

	NSWindow *window = sender.window;

	unsigned short keyCode = (unsigned short) sender.tag;

	NSRect fuckingStupidRect;
	fuckingStupidRect.origin  = [NSEvent mouseLocation];
	NSPoint mouseLocationInWindow = [window convertRectFromScreen: fuckingStupidRect].origin;

	NSEventModifierFlags flags = 0;

	if ([[self getModifierButton: AMLeftFn]			isPressed])
		flags |= NSFunctionKeyMask;

	if ([[self getModifierButton: AMLeftShift]		isPressed] ||
		[[self getModifierButton: AMRightShift]		isPressed])
		flags |= NSShiftKeyMask;

	if ([[self getModifierButton: AMLeftControl]	isPressed] ||
		[[self getModifierButton: AMLeftControl]	isPressed])
		flags |= NSControlKeyMask;

	if ([[self getModifierButton: AMLeftOption]		isPressed] ||
		[[self getModifierButton: AMRightOption]	isPressed])
		flags |= NSAlternateKeyMask;

	if ([[self getModifierButton: AMLeftCommand]	isPressed] ||
		[[self getModifierButton: AMRightCommand]	isPressed])
		flags |= NSCommandKeyMask;

	NSEvent *event =
	[NSEvent keyEventWithType: keyEventAction
					 location: mouseLocationInWindow
				modifierFlags: flags
					timestamp: NSProcessInfo.processInfo.systemUptime
				 windowNumber: window.windowNumber
					  context: window.graphicsContext
				   characters: [AMLocaleUtilities stringForKeyCode: keyCode
											  WithModifiers: flags]
  charactersIgnoringModifiers: [AMLocaleUtilities stringForKeyCode: keyCode
											  WithModifiers: 0]
					isARepeat: NO
					  keyCode: keyCode];

	switch (keyEventAction) {
		case NSFlagsChanged:
			[self combinedModEvent: event fromButton: sender];
			break;

		case NSKeyDown:
		case NSKeyUp:
			[self combinedKeyEvent: event fromButton: sender];
			break;

		default: [NSException raise:@"Invalid enumeration value" format:@"How did %lu even get in here?", keyEventAction];
	}
}

- (void) combinedKeyEvent:(NSEvent *) event
			   fromButton:(NSButton *) button {
	switch (event.type) {
		case NSKeyUp:
			if ([self.delegate respondsToSelector: @selector(keyDown:fromButton:)])
				[self.delegate keyDown: event fromButton: button];
			break;

		case NSKeyDown:
			if ([self.delegate respondsToSelector: @selector(keyUp:fromButton:)])
				[self.delegate keyUp: event fromButton: button];
			break;

		default: break;
	}
}

- (void) combinedModEvent:(NSEvent *) event
			   fromButton:(NSButton *) button {
	switch (event.type) {

		[self updateKeyTitlesWithModifiers: event.modifierFlags];

		case NSKeyUp:
			if ([self.delegate respondsToSelector: @selector(modDown:fromButton:)])
				[self.delegate modDown: event fromButton: button];
			break;

		case NSKeyDown:
			if ([self.delegate respondsToSelector: @selector(modUp:fromButton:)])
				[self.delegate modUp: event fromButton: button];
			break;

		default: break;
	}
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
		if ([v isKindOfClass:[NSButton class]] &&
			[AMLocaleUtilities isCharacterForKeycode: (int) v.tag]) {
			NSButton *b = (NSButton *) v;
			NSString *s = [_model stringForKeyCode: (int) b.tag WithNSEventModifiers: modifiers];
			if (s) b.title = s;
		}
	}
}

- (AMModifierButton *) getModifierButton: (enum AMModifierKeyType) type {
	return (AMModifierButton *) [self.viewAsAMKeyboardView viewWithTag: type];
}
@end