//
//  PIGAppDelegate.m
//  CleanTaskHelper
//
//  Created by loki tang on 12-11-8.
//  Copyright (c) 2012年 pigtracerlab. All rights reserved.
//

#import "PIGAppDelegate.h"

@implementation PIGAppDelegate

NSString * const APP_IDENTIFIER = @"org.pigtracer.lab.CleanTask";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    BOOL alreadyRunning = NO;
    NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in running) {
        if ([[app bundleIdentifier] isEqualToString:APP_IDENTIFIER]) {
            alreadyRunning = YES;
        }
    }
    
    if (!alreadyRunning) {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSArray *p = [path pathComponents];
        NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:p];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents removeLastObject];
        [pathComponents addObject:@"MacOS"];
        [pathComponents addObject:@"CleanTask"];
        NSString *newPath = [NSString pathWithComponents:pathComponents];
        [[NSWorkspace sharedWorkspace] launchApplication:newPath];
    }
    [NSApp terminate:nil];
}

@end
