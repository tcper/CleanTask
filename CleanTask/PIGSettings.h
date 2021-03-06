//
//  PIGSettings.h
//  CleanTask
//
//  Created by loki tang on 12-11-6.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIGSettings : NSObject {
    NSUserDefaults *userDefautls;
    
    NSMutableDictionary *settingsMap;
}
extern NSString * const APP_DEFAULTS_MAP;

extern NSString * const DESKTOP_STORAGE_DIR;
extern NSString * const CLEAN_TASK_INTERVAL;
extern NSString * const LAST_CLEAN_TIME;
extern NSString * const IS_PERIODICAL;
extern NSString * const INTERVAL_TYPE;

- (NSObject *) getSetting:(NSString *)key;

- (void) updateCleanTime;
- (void) changePeriodical:(BOOL)value;
- (void) changeStorageDirectory:(NSString *)value;
- (void) changeCleanInterval:(int)value;
- (void) changeIntervalType:(NSNumber*) value;

@end
