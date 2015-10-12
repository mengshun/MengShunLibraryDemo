//
//  LLLockPassword.h
//  LockSample
//
//  Created by Lugede on 14/11/12.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//
//  密码保存模块

#import <Foundation/Foundation.h>

@interface LLLockPassword : NSObject

#pragma mark - 锁屏密码读写
+ (NSString*)loadLockPassword;
+ (void)saveLockPassword:(NSString*)pswd;
+ (BOOL)isAlreadyAskedCreateLockPassword;
+ (void)setAlreadyAskedCreateLockPassword;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
