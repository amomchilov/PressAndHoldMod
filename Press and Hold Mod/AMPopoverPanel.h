//  AMPopover.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverView.h"

@protocol AMPopoverPanelDelegate;

@interface AMPopoverPanel : NSPanel {
	CGFloat _padding;
	int _borderWidth;
	NSRectEdge _arrowEdge;
}

#warning delegate naming conflict
@property (weak) id <AMPopoverPanelDelegate> delegate;
@property (weak) IBOutlet NSTextField *label;

@end

@protocol AMPopoverPanelDelegate <NSObject>

- (void) popOver:(AMPopoverPanel *)popOver cancelOperation:(id)sender;

@end