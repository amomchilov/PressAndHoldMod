//  AMPopoverController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverController.h"


@implementation AMPopoverController

#pragma mark NSWindowController methods
//- (id)initWithWindow:(NSWindow *)window {
//	if (self = [super initWithWindow:window]) {
//    }
//    return self;
//}

//- (void)windowDidLoad {
//    [super windowDidLoad];
//    
//    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
//}

#pragma mark Other methods
- (AMPopoverPanel *) windowAsAMPopoverPanel {
	return (AMPopoverPanel *) self.window;
}

- (void) showWindow:(id)sender withStringArray: (NSArray*) stringArray {
	if ([sender isKindOfClass: [NSView class]]) {
		NSRect senderRect = ((NSView *) sender).actualBounds;
		NSRect frameRect = NSMakeRect(senderRect.origin.x + senderRect.size.width / 2, //Horizontally centered with senderRect
									  senderRect.origin.y + senderRect.size.height, //Top edge of senderRect
									  3 + 26 * (stringArray.count/* + 1*/), //width needs work.
									  45);
		[self.window setFrame: frameRect display: YES];
	}

	if (stringArray) {
		NSMutableString *labelString = [NSMutableString stringWithCapacity: 18];
		for (NSString *s in stringArray) {
			[labelString appendFormat: @"%@ ", s];
//			NSView *v = _cellController.view;
//			v.frame = NSMakeRect(6+1+2+26i,
//								 6+1+2,
//								 25,
//								 42);
//			[self.window.contentView addSubview: v];
//			self.keyboardView = (AMKeyboardView *) [_keyboardController view];
//			
//			[self.mainView addSubview: self.keyboardView];
		}
		self.windowAsAMPopoverPanel.label.stringValue = labelString;
	}
	else {
		//default case
	}
	
	[super showWindow: sender];
}

- (BOOL) windowShouldClose:(id)sender {
	DLog(@"test");
	return YES;
}

@end
