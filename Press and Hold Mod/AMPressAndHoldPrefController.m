//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"

@implementation AMPressAndHoldPrefController

- (void)mainViewDidLoad {
    DLog(@"");
    [self setupModel];
    [self setupKeyboardView];
}

- (void)setupModel {
    DLog(@"");
    //create new model object
	self.model = [[AMPressAndHoldPlistModel alloc] init];
	
	//populate drop down menu with the array of human readable names.
	[self.popUpButton addItemsWithTitles: [self.model sortedLanguageList]];
	
	//If the current locale is on the list, select it.
	if ([[self.model plistFiles] objectForKey:[AMLocaleUtility userLanguagePreference]]) {
		[self.popUpButton selectItemWithTitle:[AMLocaleUtility userLanguagePreference]];
		[self readPlistFileIntoTextField];
	}
}

- (void)setupKeyboardView {
    NSViewController *vc = [[NSViewController alloc] initWithNibName:@"AMKeyboardView"
                                                              bundle:[self bundle]];
	self.keyboardView = (AMKeyboardView *) [vc view];
    [self.keyboardView setDelegate: self];
	//[self.keyboardView becomeFirstResponder];
	
	[self.keyboardView setFrame: self.keyboardPlaceHolder.frame];
	[self.mainView addSubview: self.keyboardView];
}

- (IBAction) popUpButtonChanged:(id)sender {
    DLog(@"");
	[self readPlistFileIntoTextField];
}

- (void) readPlistFileIntoTextField {
    DLog(@"");

	NSString *fileContents = [self.model readPlistFileContentsForKey: [self.popUpButton titleOfSelectedItem]];
	[self.textView setString: fileContents];
}

- (void) keyboard:(AMKeyboardView *) keyboard didPressKey:(NSButton *) sender {
	DLog(@"%@", keyboard == self.keyboardView ? @"true" : @"false");
}

- (IBAction)showPopOver:(id)sender {
	[self.popOver showRelativeToRect: [sender bounds] ofView: sender preferredEdge: NSMinYEdge];
}

@end
