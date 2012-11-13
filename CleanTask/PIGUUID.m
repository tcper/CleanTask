//
//  PIGUUID.m
//  CleanTask
//
//  Created by loki tang on 12-11-13.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGUUID.h"

@implementation PIGUUID
+(NSString*)UUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}
@end