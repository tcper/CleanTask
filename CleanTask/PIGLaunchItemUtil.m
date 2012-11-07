//
//  PIGLaunchItemUtil.m
//  CleanTask
//
//  Created by loki tang on 12-11-7.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//
#import "PIGLaunchItemUtil.h"
#import <ServiceManagement/ServiceManagement.h>

@implementation PIGLaunchItemUtil

NSString * const APP_IDENTIFIER = @"org.pigtracer.lab.CleanTask";

+ (void) launchAtLogin:(BOOL)value {
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"bundle:%@", [bundle bundleIdentifier]);
    CFStringRef identifier = (__bridge CFStringRef)[bundle bundleIdentifier];//(__bridge CFStringRef) APP_IDENTIFIER;
    
    if (value) {
        if (!SMLoginItemSetEnabled(identifier, true)) {
            NSLog(@"login failed");
        } else {
            NSLog(@"login");
        }
    } else {
        SMLoginItemSetEnabled(identifier, false);
    }
}

@end
