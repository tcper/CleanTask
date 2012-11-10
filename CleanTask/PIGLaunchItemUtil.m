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

NSString * const APP_IDENTIFIER = @"org.pigtracer.lab.CleanTaskHelper";

+ (void) launchAtLogin:(BOOL)value {
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"bundle:%@", [bundle bundleIdentifier]);
    //CFStringRef identifier = (__bridge CFStringRef)[bundle bundleIdentifier];//(__bridge CFStringRef) APP_IDENTIFIER;
    
    if (value) {
        if (!SMLoginItemSetEnabled((__bridge CFStringRef)(APP_IDENTIFIER), YES)) {
            NSLog(@"login failed");
        } else {
            NSLog(@"login");
        }
    } else {
        SMLoginItemSetEnabled((__bridge CFStringRef)(APP_IDENTIFIER), YES);
    }
}

+ (BOOL) checkIsAddedLoginItem {
    BOOL isEnabled = NO;
    
    CFArrayRef cfJobDicts = SMCopyAllJobDictionaries(kSMDomainSystemLaunchd);
    NSArray *jobDicts = (__bridge NSArray *)(cfJobDicts);
    if (!jobDicts || [jobDicts count] <= 0) {
        return NO;
    }
    
    for (NSDictionary *job in jobDicts) {
        //NSLog(@"%@", [job objectForKey:@"Label"]);
        if ([APP_IDENTIFIER isEqualToString:[job objectForKey:@"Label"]]) {
            isEnabled = [[job objectForKey:@"OnDemand"] booleanValue];
            break;
        }
    }
    
    return isEnabled;
}

@end
