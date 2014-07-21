//
//  NSView+ViewDebugging.m
//  Press and Hold Mod
//
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "NSView+ViewDebugging.h"

@implementation NSView (ViewDebugging)
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


//- (void)keyDown:(NSEvent *)theEvent
//{
//    DLog(@"%@", self.subviews);
//}
@end
