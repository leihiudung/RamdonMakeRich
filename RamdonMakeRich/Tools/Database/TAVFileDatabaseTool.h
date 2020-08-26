//
//  TAVFileDatabaseTool.h
//  OKfone
//
//  Created by Tom-Li on 2020/7/23.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAVFileDatabaseTool : NSObject
+ (void)saveUserName:(NSString *)userName;
+ (NSString *)obtainUserName;
+ (BOOL)saveUserIcon:(NSString *)originPath inPath:(NSString *)path;

+ (void)saveUserAccount:(NSString *)userAccount;
+ (NSString *)obtainUserAccount;
+ (void)deleteUserAccount;

+ (void)saveDatabaseVersion:(NSString *)version;
+ (NSString *)obtainDatabaseVersion;
@end

NS_ASSUME_NONNULL_END
