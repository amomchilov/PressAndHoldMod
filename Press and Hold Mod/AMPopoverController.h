//  AMPopoverController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverPanel.h"
#import "NSView+ActualBounds.h"

/**
 @brief  A NSWindowController subclass which controls an AMPopoverPanel
 */
@interface AMPopoverController : NSWindowController <NSWindowDelegate>

/**
 @brief  Shows an AMPopoverPanel, such that the arrowtip is positioned at the center of the top of the sender NSView
 
 @param sender      The view about which the new AMPopoverPanel is to be placed
 @param stringArray An array of the strings to be placed in the AMPopoverPanel
 */
- (void) showWindow:(NSView *)sender withStringArray: (NSArray*) stringArray;

@end
