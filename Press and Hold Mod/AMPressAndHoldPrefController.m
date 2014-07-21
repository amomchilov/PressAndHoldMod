//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"

@implementation AMPressAndHoldPrefController

- (void)mainViewDidLoad {
    //create new model object
	self.model = [[AMPressAndHoldPlistModel alloc] init];
	
	/*****Setup main views*****/
	//populate drop down menu with the array of human readable names.
	[self.popUpButton addItemsWithTitles: [self.model sortedLanguageList]];
	
	//If the current locale is on the list, select it.
	if ([[self.model plistFiles] objectForKey:[AMLocaleUtility userLanguagePreference]]) {
		[self.popUpButton selectItemWithTitle:[AMLocaleUtility userLanguagePreference]];
		[self readPlistFileIntoTextField];
	}
	
	/*****Setup AMKeyboardView*****/
    self.keyboardController = [[AMKeyboardViewController alloc] initWithNibName:@"AMKeyboardView"
																		 bundle:[self bundle]];
    self.keyboardController.delegate = self;
	self.keyboardView = [self.keyboardController view];
	//[self.keyboardView becomeFirstResponder];
	
	[self.keyboardView setFrame: self.keyboardPlaceHolder.frame];
	[self.mainView addSubview: self.keyboardView];
	
	/*****Setup AMPopover*****/
	self.popoverController = [[AMPopoverController alloc] initWithWindowNibName:@"AMPopoverView"];
}

- (IBAction) popUpButtonChanged:(id)sender {
    DLog(@"");
	[self readPlistFileIntoTextField];
}

- (void) readPlistFileIntoTextField {
	NSString *fileContents = [self.model plistFileContentsForKey: [self.popUpButton titleOfSelectedItem]];
	[self.textView setString: fileContents];
}

- (void) keyboard:(NSView *) keyboard didPressKey:(NSButton *) sender {
	//DLog(@"%@", [sender title]);
	//[self.popover showRelativeToRect: [sender bounds] ofView: sender preferredEdge: NSMinYEdge];
	[self.popoverController showWindow: sender];
}

- (IBAction)testButton1Pressed:(NSButton *)sender {
	[self.popover showRelativeToRect: sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}

- (IBAction)testButton2Pressed:(NSButton *)sender {
	[self.popoverController close];
}


@end
