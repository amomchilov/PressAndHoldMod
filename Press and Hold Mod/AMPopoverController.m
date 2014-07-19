//  AMPopoverController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverController.h"

@implementation AMPopoverController

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

- (void) showWindow:(id)sender {
	if ([sender isKindOfClass: [NSView class]]) {
		NSView *view = (NSView *) sender;
		NSRect f = [view.window convertRectToScreen:view.frame];
		NSPoint p = NSMakePoint(f.origin.x + f.size.height, f.origin.y + f.size.height);
		[self.window setFrameOrigin: p];
		DLog(@"%@", NSStringFromRect(f));
	}
	[super showWindow: sender];
}

@end
