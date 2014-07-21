//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"

@interface NSView (foo)

+ (NSString *)hierarchicalDescriptionOfView:(NSView *)view
                                      level:(NSUInteger)level;


- (void)logHierarchy;

@end

@implementation NSView (foo)

+ (NSString *)hierarchicalDescriptionOfView:(NSView *)view
                                      level:(NSUInteger)level
{
    
    // Ready the description string for this level
    NSMutableString * builtHierarchicalString = [NSMutableString string];
    
    // Build the tab string for the current level's indentation
    NSMutableString * tabString = [NSMutableString string];
    for (NSUInteger i = 0; i <= level; i++)
        [tabString appendString:@"\t"];
    
    // Get the view's title string if it has one
    NSString * titleString = ([view respondsToSelector:@selector(title)]) ? [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"\"%@\" ", [(NSButton *)view title]]] : @"";
    NSString *frameString = NSStringFromRect([view frame]);
    
    // Append our own description at this level
    [builtHierarchicalString appendFormat:@"\n%@<%@: %p> %@(%li subviews) %@", tabString, [view className], view, titleString, [[view subviews] count], frameString];
    
    // Recurse for each subview ...
    for (NSView * subview in [view subviews])
        [builtHierarchicalString appendString:[NSView hierarchicalDescriptionOfView:subview
                                                                              level:(level + 1)]];
    
    return builtHierarchicalString;
}

- (void)logHierarchy
{
    NSLog(@"%@", [NSView hierarchicalDescriptionOfView:self
                                                 level:0]);
}

@end

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
	self.keyboardView = [self.keyboardController view];
	
	[self.keyboardView setFrame: self.keyboardPlaceHolder.frame];
	[self.mainView addSubview: self.keyboardView];
	[self.keyboardPlaceHolder removeFromSuperview];
	
	/*****Setup AMPopover*****/
	self.popoverController = [[AMPopoverController alloc] initWithWindowNibName:@"AMPopoverView"];
    self.initialKeyView = self.keyboardView;
}

- (void)didSelect
{
    [self.keyboardView.window makeFirstResponder:self.keyboardView];
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

- (void)printViewHierarchy:(NSView *)view
{
	if (view == nil)
		return;
	
	NSLog(@"%@", view);
	
	for (NSView *subview in [view subviews])
	{
		[self printViewHierarchy: subview];
	}
}
@end
