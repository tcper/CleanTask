//
//  PIGClassifyDesktopUtil.m
//  CleanTask
//
//  Created by loki on 12-11-10.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGClassifyDesktopUtil.h"

@implementation PIGClassifyDesktopUtil

NSString const *ALL_FILES = @"all";
NSString const *DIR_FILES = @"dir";

- (id) init {
    manager = [NSFileManager defaultManager];
    NSData *sourceData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FileSettings" ofType:@"json"]];
    settingSource = [NSJSONSerialization JSONObjectWithData:sourceData options:NSJSONReadingAllowFragments error:nil];
    return self;
}

- (void) initTargetDirectory:(PIGSettings *) value{
    settings = value;
    
    NSString *targetDirectoryPath = (NSString *) [settings getSetting:DESKTOP_STORAGE_DIR];
    if ([manager fileExistsAtPath:targetDirectoryPath]) {
        NSLog(@"PIGClassifyDesktopUtil storage dir exists, do nothing");
    } else {
        [manager createDirectoryAtPath:targetDirectoryPath withIntermediateDirectories:NO attributes:nil error:NULL];
    }
}

- (void) performPackage {
    NSArray *typeList = [self parseFileSettings:settingSource];
    for (NSObject *typeBundle in typeList) {
        NSArray *extList = [typeBundle valueForKey:@"extensions"];
        for (NSString *ext in extList) {
            NSLog(@"%@", ext);
        }
    }
}



- (NSArray *) parseFileSettings:(NSObject *) source {
    NSArray *typeList = (NSArray *) [source valueForKey:@"root"];
    return typeList;
}

@end
