//
//  PIGSettings.m
//  CleanTask
//
//  Created by loki tang on 12-11-6.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGSettings.h"

@implementation PIGSettings

NSString * const APP_DEFAULTS_MAP = @"appDefautlsMap";

NSString * const CLEAN_TASK_INTERVAL = @"cleanTaskInterval";
NSString * const LAST_CLEAN_TIME = @"lastCleanTime";
NSString * const IS_PERIODICAL = @"isPeriodical";
NSString * const DESKTOP_STORAGE_DIR = @"desktopStorageDirectory";
NSString * const INTERVAL_TYPE = @"intervalType";

- (id) init {
    NSDictionary *initialMap = [NSDictionary dictionaryWithObjectsAndKeys:
                                NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0], @"desktopStorageDirectory",
                                @0, @"intervalType",
                                @604800, @"cleanTaskInterval", // for seconds of 24h * 7
                                @0, @"lastCleanTime",          // last clean timestamp
                                @YES, @"isPeriodical",
                                @"value1", @"key1",           // key for testing
                                @"value2", @"key2", nil];
    userDefautls = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *readMapFromLocal = [[userDefautls dictionaryForKey:APP_DEFAULTS_MAP] mutableCopy];
    if (readMapFromLocal) {
        settingsMap = readMapFromLocal;
        [self flush];
    } else {
        settingsMap = [initialMap mutableCopy];
        [self flush];
    }
    
    NSLog(@"user defaults:%@", settingsMap);
    return self;
}

- (NSObject *) getSetting:(NSString *)key {
    return [settingsMap valueForKey:key];
}

- (void) flush {
    [userDefautls setValue:settingsMap forKey:APP_DEFAULTS_MAP];
    [userDefautls synchronize];
}

- (void) updateCleanTime {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    [settingsMap setValue:[NSNumber numberWithInt:(int)[date timeIntervalSince1970]] forKey:LAST_CLEAN_TIME];
    [self flush];
}

- (void) changePeriodical:(BOOL)value {
    [settingsMap setValue:[NSNumber numberWithBool:value] forKey:IS_PERIODICAL];

    [self flush];
}

- (void) changeStorageDirectory:(NSString *)value {
    [settingsMap setValue:value forKey:DESKTOP_STORAGE_DIR];
    [self flush];
}

- (void) changeCleanInterval:(int)value {
    [settingsMap setValue:[NSNumber numberWithInt:value] forKey:CLEAN_TASK_INTERVAL];
    [self flush];
}

- (void) changeIntervalType:(NSNumber *)value {
    [settingsMap setValue:value forKey:INTERVAL_TYPE];
    [self flush];
}

@end
