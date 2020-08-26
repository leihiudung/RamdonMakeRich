//
//  TAVFileDatabaseTool.m
//  OKfone
//
//  Created by Tom-Li on 2020/7/23.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVFileDatabaseTool.h"

@implementation TAVFileDatabaseTool

/// 保存用户名
/// @param userName 用户名
+ (void)saveUserName:(NSString *)userName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"UserName"];
}

/// 获取用户名
+ (NSString *)obtainUserName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"UserName"];
}

/// 保存用户头像文件
/// @param originPath 原路径
/// @param path 现路径
+ (BOOL)saveUserIcon:(NSString *)originPath inPath:(NSString *)path {
   NSError *downloadImagError = nil;
   BOOL flag = [[NSFileManager defaultManager] copyItemAtPath:originPath toPath:path error:&downloadImagError];
    return flag;
}

+ (void)saveUserAccount:(NSString *)userAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userAccount forKey:@"UserAccount"];
}

+ (NSString *)obtainUserAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"UserAccount"];
}

+ (void)deleteUserAccount {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"UserAccount"];
}

+ (void)saveDatabaseVersion:(NSString *)version {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:@"DatabaseVersion"];
}

+ (NSString *)obtainDatabaseVersion {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"DatabaseVersion"];
}

+ (id)getFileInPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory:NO]) {
        
    }
    return nil;
}

@end
