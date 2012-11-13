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
- (NSString *)serialNumber
{
    io_service_t    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                                 
                                                                 IOServiceMatching("IOPlatformExpertDevice"));
    CFStringRef serialNumberAsCFString = NULL;
    
    if (platformExpert) {
        serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert,
                                                                 CFSTR(kIOPlatformSerialNumberKey),
                                                                 kCFAllocatorDefault, 0);
        IOObjectRelease(platformExpert);
    }
    
    NSString *serialNumberAsNSString = nil;
    if (serialNumberAsCFString) {
        serialNumberAsNSString = [NSString stringWithString:(__bridge NSString *)serialNumberAsCFString];
        CFRelease(serialNumberAsCFString);
    }
    
    return serialNumberAsNSString;
}
- (void) survey {
    NSString *uuid = [self serialNumber];
    NSString *URLString = [NSString stringWithFormat:@"http://pigtracerlab.net/ct/s.php?uuid=%@", uuid];
    NSURL *baseURL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"data:%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
}

@end
