//  AMPopoverController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverController.h"


@implementation AMPopoverController

#pragma mark NSWindowController methods
- (id)initWithWindow:(NSWindow *)window {
    if (self = [super initWithWindow:window]) {
        // Initialization code here.
    }
    return self;
}

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
		NSRect popupRect = NSMakeRect(senderRect.origin.x,
									  senderRect.origin.y + senderRect.size.height,
									  5 + 26 * (stringArray.count + 1),
									  46);
		[self.window setFrame: popupRect display: YES];
	}
	
	if (stringArray) {
		NSMutableString *labelString = [NSMutableString stringWithCapacity: 18];
		for (NSString *s in stringArray) {
			[labelString appendFormat: @"%@ ", s];
		}
		DLog(@"%lu", labelString.length);
		self.windowAsAMPopoverPanel.label.stringValue = labelString;
	}
	
	[super showWindow: sender];
}

- (void) popOver:(AMPopoverPanel *)popOver cancelOperation:(id)sender {
	[self.window close];
#warning should use performClose
}

@end
