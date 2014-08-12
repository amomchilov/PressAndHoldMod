//  AMPopover.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverView.h"

@interface AMPopoverPanel : NSPanel {
	CGFloat _padding;
	int _borderWidth;
	NSRectEdge _arrowEdge;
}

@property (weak) IBOutlet NSTextField *label;

@end