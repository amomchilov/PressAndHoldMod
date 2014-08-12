//  NSView+ViewDebugging.h
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

@interface NSView (ViewDebugging)
+ (NSString *)hierarchicalDescriptionOfView:(NSView *)view
                                      level:(NSUInteger)level;


- (void)logHierarchy;
@end
