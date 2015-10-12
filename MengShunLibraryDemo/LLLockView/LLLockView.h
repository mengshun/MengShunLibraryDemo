//
//  LLLockView.h
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//
//  田字形手势解锁控件

#import <UIKit/UIKit.h>
#import "LLLockConfig.h"

@protocol LLLockDelegate <NSObject>

@required
- (void)lockString:(NSString*)string;

@end

@interface LLLockView : UIView

@property (nonatomic, weak) id<LLLockDelegate> delegate;

- (void)showErrorCircles:(NSString*)string; // 设置错误的密码以高亮
- (void)clearColorAndSelectedButton; // 重置

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
