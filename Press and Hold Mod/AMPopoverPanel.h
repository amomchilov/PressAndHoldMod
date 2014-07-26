//  AMPopover.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

@protocol AMPopoverPanelDelegate;

@interface AMPopoverPanel : NSPanel

@property (weak) id <AMPopoverPanelDelegate> delegate;
@property (weak) IBOutlet NSTextField *label;


@end

@protocol AMPopoverPanelDelegate <NSObject>

- (void) popOver:(AMPopoverPanel *)popOver cancelOperation:(id)sender;

@end