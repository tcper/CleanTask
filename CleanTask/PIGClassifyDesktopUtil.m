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

NSString const *DIR_CREATOR = @"loki";

- (id) init {
    manager = [NSFileManager defaultManager];
    
    // -- init json settings file
    NSData *sourceData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FileSettings" ofType:@"json"]];
    settingSource = [NSJSONSerialization JSONObjectWithData:sourceData options:NSJSONReadingAllowFragments error:nil];
    
    // -- init home & desktop path;
    homePath = (NSString *) NSHomeDirectoryForUser(NSUserName());
    desktopPath = [homePath stringByAppendingFormat:@"/Desktop"];
    
    return self;
}

- (void) initTargetDirectory:(PIGSettings *) value{
    settings = value;
}

- (void) performPackage {
    NSArray *desktopFilesList = [manager contentsOfDirectoryAtPath:desktopPath error:nil];    
    if (![self checkDeskopFile:desktopFilesList]) {
        return;
    }
    
    [self checkMoveToDirectoryBeforePerform];

    for (NSString *fileName in desktopFilesList) {
        [self handleSingleItem:fileName];
    }
}

- (BOOL) checkDeskopFile:(NSArray *)data {
    return [data count] > 0;
}

- (void) checkMoveToDirectoryBeforePerform {
    NSString *storageBase = [(NSString *) [settings getSetting:DESKTOP_STORAGE_DIR] stringByAppendingString:@"/"];
    NSLog(@"url:%@", storageBase);
    // check base dir;
    if ([manager fileExistsAtPath:storageBase]) {
        NSLog(@"do nothing");
    } else {
        [manager createDirectoryAtPath:storageBase withIntermediateDirectories:NO attributes:nil error:NULL];
    }
    //check date dir;
    [self checkOrCreateMoveToDirectory:storageBase createPathLevel:0];
}

- (void) checkOrCreateMoveToDirectory:(NSString *) path createPathLevel:(int) level {
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateDirectory = [formatter stringFromDate:today];
    
    if (level == 0) {
        moveToDirectory = [path stringByAppendingString:dateDirectory];
    } else {
        moveToDirectory = [path stringByAppendingFormat:@"%@-%u", dateDirectory, level];
    }
    
    NSLog(@"moveTo:%@", moveToDirectory);
    
    if ([manager fileExistsAtPath:moveToDirectory]) {
        [self checkOrCreateMoveToDirectory:path createPathLevel:level+1];
    } else {
        [manager createDirectoryAtPath:moveToDirectory withIntermediateDirectories:NO attributes:nil error:NULL];
        const char *cMoveToDirectory = [moveToDirectory UTF8String];
        setxattr(cMoveToDirectory, "creator", "loki", 4, 0, 0);
    }
}

- (void) handleSingleItem:(NSString *) fileName {
    if ([self checkIgnoreFile:fileName]) {
        return;
    }
    
    BOOL isDir;
    
    NSString *fullPathFileName = [[desktopPath stringByAppendingString:@"/"] stringByAppendingString:fileName];

    [manager fileExistsAtPath:fullPathFileName isDirectory:&isDir];
    
    if (isDir) {
        [self handleSingleDir:fileName];
    } else {
        [self handleSingleFile:fileName];
    }
}

- (BOOL) checkIgnoreFile:(NSString *)fileName {
    // char '.' == 46;
    if ([fileName characterAtIndex:0] == 46) {
        return YES;
    }
    return NO;
}

- (void) handleSingleDir:(NSString *)path {
    NSLog(@"handle dir: %@", path);
    NSString *fullPath = [[desktopPath stringByAppendingString:@"/"] stringByAppendingString:path];
    
    if ([self checkIgnoreFile:path]) {
        return;
    }
    
    NSString *moveToFullPath = [[moveToDirectory stringByAppendingString:@"/"] stringByAppendingString:path];
    NSLog(@"handleSingleDir:%@", moveToFullPath);
    [manager moveItemAtPath:fullPath toPath:moveToFullPath error:nil];
}

- (BOOL) checkDirectoryCreator:(NSString *) path {
    const char *cPath = [path UTF8String];
    char *folderKey[0];
    
    getxattr(cPath, "creator", folderKey, 4, 0, 0);
    NSString *createString = [[NSString alloc] initWithUTF8String:folderKey];
    return [DIR_CREATOR compare:createString];
}

- (void) handleSingleFile:(NSString *)file {
    NSString *fileFullPath = [desktopPath stringByAppendingFormat:@"/%@", file];
    
    NSArray *fileSplit = [file componentsSeparatedByString:@"."];
    NSString *fileExt = (NSString *) [fileSplit objectAtIndex:[fileSplit count] - 1];
    
    NSArray *typeList = [self parseFileSettings:settingSource];
    for (NSObject *typeBundle in typeList) {
        
        NSString *typeDocName = [typeBundle valueForKey:@"typeName"];
        NSArray *extList = [typeBundle valueForKey:@"extensions"];
        
        for (NSString *ext in extList) {

            if (![ext compare:fileExt]) {
                //move file to target dir than return;
                NSString *moveToFullPath = [moveToDirectory stringByAppendingFormat:@"/%@", typeDocName];
                NSString *moveToFullPathFile = [moveToFullPath stringByAppendingFormat:@"/%@", file];

                NSLog(@"filename:%@", fileFullPath);
                NSLog(@"handleSingleFile:%@", moveToFullPath);

                [self moveFileToPath:fileFullPath moveToPath:moveToFullPathFile checkPath:moveToFullPath];
                return;
            }
        }
    }
    
    // mov file to other doc;
    NSString *otherFullPath = [moveToDirectory stringByAppendingFormat:@"/%@", @"Other Files"];
    NSString *otherFullPathFile = [[otherFullPath stringByAppendingString:@"/"] stringByAppendingString:file];
    [self moveFileToPath:fileFullPath moveToPath:otherFullPathFile checkPath:otherFullPath];
}

- (void) moveFileToPath:(NSString *) fileFullPath moveToPath:(NSString *) moveToFullPath checkPath:(NSString *) path{
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:NULL];
    }
    
    [manager moveItemAtPath:fileFullPath toPath:moveToFullPath error:nil];
}

- (NSArray *) parseFileSettings:(NSObject *) source {
    NSArray *typeList = (NSArray *) [source valueForKey:@"root"];
    return typeList;
}

@end
