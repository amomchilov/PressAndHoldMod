//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtilities.h"


@implementation AMPressAndHoldPrefController

#pragma mark NSPreferencePane methods
- (void)mainViewDidLoad {
    //create new model object
	_model = [[AMPressAndHoldPlistModel alloc] init];
	/*****Setup main views*****/
	//populate drop down menu with the array of supported languages.
	NSArray *userISPrefs = [AMLocaleUtilities userLanguagePreferences]; //User's Input Source Preferences
	NSArray *supportedLanguages = [_model sortedLanguageList]; //All supported languages
	NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", supportedLanguages];
	NSArray *filteresdUserISPrefs = [userISPrefs filteredArrayUsingPredicate:intersectPredicate]; //All supported User Input Source Preferences
	NSArray *sortedUserISPrefs = [filteresdUserISPrefs sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[self.languagesPopUpButton addItemsWithTitles: sortedUserISPrefs];
	[self.languagesPopUpButton selectItemWithTitle: filteresdUserISPrefs[0]];
	[self updateInputSource];
	
	/*****Setup AMKeyboardView*****/
    _keyboardController = [[AMKeyboardViewController alloc]
						   initWithNibName:@"AMKeyboardView"
						   bundle: self.bundle];
    _keyboardController.delegate = self;
	self.keyboardView = (AMKeyboardView *) _keyboardController.view;
	
	self.keyboardView.frame = _keyboardPlaceHolder.frame;
    [_keyboardPlaceHolder removeFromSuperview];

	[self.mainView addSubview: self.keyboardView];
	
	/*****Setup AMPopover*****/
	_popoverController = [[AMPopoverController alloc] initWithWindowNibName: @"AMCharPopover"];

	/*****Observe Input Source Changes*****/
	[[NSDistributedNotificationCenter defaultCenter] addObserver: self
														selector: @selector(updateInputSource)
															name: (NSString *)kTISNotifySelectedKeyboardInputSourceChanged
														  object: nil];
	/*****Observe changes to the popup's key window status *****/
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(resignKeyWindow)
												 name: NSWindowDidResignKeyNotification
											   object: _popoverController.window];
}

//Notifies the receiver that the main application has just displayed the preference pane’s main view.
- (void)didSelect {
	[self.mainView.window performSelector: @selector(makeFirstResponder:)
							   withObject: self.keyboardView
							   afterDelay: 0.0];
}

//Notifies the receiver that the main application is about to stop displaying the preference pane’s main view.
- (void) willUnselect {
	[_popoverController close];
}

#pragma mark AMKeyboardViewControllerDelegate methods
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *)sender ForEvent:(NSEvent *)event {
	if ([AMLocaleUtilities isCharacterForKeycode: event.keyCode]) {
		//NSLog(@"%@", event);
		NSArray *stringArray = [_model stringArrayForPlistKey: _currentPlist CharacterKey: [sender title]];
		[_popoverController showWindow: sender withStringArray: stringArray];
	}
}

#pragma mark IBActions
- (IBAction) popUpButtonChanged:(NSPopUpButton *)sender {
	[self updateInputSource];
}

#pragma mark Other methods
- (void) resignKeyWindow {
	[_popoverController close];
	[_keyboardController resetModifierKeyStates];
}

- (void) updateInputSource {
	_currentPlist = self.languagesPopUpButton.titleOfSelectedItem;
	
	[_keyboardController rebuildKeyLayout];
}


@end
