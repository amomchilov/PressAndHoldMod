//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"
#import "NSView+ViewDebugging.h"


@implementation AMPressAndHoldPrefController

- (void)mainViewDidLoad {
    [super mainViewDidLoad];
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
	self.keyboardView = (AMKeyboardView *) [self.keyboardController view];
	
	[self.keyboardView setFrame: self.keyboardPlaceHolder.frame];
    [self.keyboardPlaceHolder removeFromSuperview];

	[self.mainView addSubview: self.keyboardView];
	
	/*****Setup AMPopover*****/
	self.popoverController = [[AMPopoverController alloc] initWithWindowNibName:@"AMPopoverView"];
	
	[self.mainView logHierarchy];
	self.timer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void) tick {
	DLog(@"tick: %@", self.mainView.window.firstResponder);
}

//Notifies the receiver that the main application has just displayed the preference pane’s main view.
- (void)didSelect {
	DLog(@"Before: %@", self.mainView.window.firstResponder);
    [self.keyboardView.window makeFirstResponder:self.keyboardView];
	DLog(@"After: %@", self.mainView.window.firstResponder);
}

//Notifies the receiver that the main application is about to stop displaying the preference pane’s main view.
- (void) willUnselect {
	[self.popoverController close];
	[self.timer invalidate];
}
h
- (IBAction) popUpButtonChanged:(id)sender {
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
