//  AMPopoverController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverPanel.h"
#import "NSView+ActualBounds.h"

@interface AMPopoverController : NSWindowController <NSWindowDelegate>

- (void) showWindow:(id)sender withStringArray: (NSArray*) stringArray;

@end
