//
//  QPCFunctionConst.h
//  QPCommonSDK
//
//  Created by admin on 2017/10/18.
//  Copyright © 2019年 QiPeng. All rights reserved.
//

#ifndef QPCFunctionConst_h
#define QPCFunctionConst_h

// 无效或空值的字符串
#define F_QpIsStringValue_Empty(msg) (![msg isKindOfClass:[NSString class]] || msg.length <= 0 ? YES : NO)
// 有效且有值的字符串
#define F_QpIsStringValue_Valid(msg) ([msg isKindOfClass:[NSString class]] && msg.length > 0 ? YES : NO)

// 获取当前时间戳字符串（13位，毫秒级）
#define F_QpCurrentTimeInterval_str_13 ([NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000])

// 获取当前时间戳（13位，毫秒级）
#define F_QpCurrentTimeInterval_13 (floor([[NSDate date] timeIntervalSince1970] * 1000))

// 获取当前时间戳字符串（10位，秒级）
#define F_QpCurrentTimeInterval_str_10 ([NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]])

// 获取当前时间戳（10位，秒级）
#define F_QpCurrentTimeInterval_10 (floor([[NSDate date] timeIntervalSince1970]))

#define F_QpSafeBlock(block, ...) block ? block(__VA_ARGS__) : nil

#define F_QpSafeBlockInMainQueue(block, ...) dispatch_async(dispatch_get_main_queue(), ^{ \
block ? block(__VA_ARGS__) : nil;                                                     \
})

#pragma mark - UI function

#define F_QPScreenWidth [UIScreen mainScreen].bounds.size.width
#define F_QPScreenHeight [UIScreen mainScreen].bounds.size.height
#define F_QPViewWidth(view) view.bounds.size.width
#define F_QPViewHeight(view) view.bounds.size.height
#define F_QPViewX(view) view.frame.origin.x
#define F_QPViewY(view) view.frame.origin.y
#define F_QPViewMaxX(view) CGRectGetMaxX(view.frame)
#define F_QPViewMaxY(view) CGRectGetMaxY(view.frame)

#define SystemIphoneX      [UIDevice currentDevice] systemVersion] >= 11.0
#define StatusBarH   [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBarH      self.navigationController.navigationBar.frame.size.height
#define SCreenH      MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define DeviceVersion(versionValue)  [UIDevice currentDevice].systemVersion.floatValue >= versionValue

#define SafeBottom    self.view.safeAreaInsets.bottom
#define SafeTop       self.view.safeAreaInsets.top
#define VCSizeWidth   self.view.frame.size.width
#define VCSizeHeight  self.view.frame.size.height

#pragma mark - 获取 RGB 颜色

#define F_QPRgba(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#define F_QPRgb(r, g, b) F_QPRgba(r, g, b, 1.0f)

#define YP_DefaultBlueColor F_QPRgb(62, 118, 248)

#define Blue0Color            F_QPRgba(51, 100, 255, 1)
#define Purple0Color          F_QPRgba(98, 72, 137, 1)
#define Black0Color           F_QPRgba(29, 35, 84, 1)
#define Black1Color           F_QPRgba(25, 48, 105, 1)
#define Black2Color           F_QPRgba(74, 74, 74, 1)
#define Gray0Color           F_QPRgba(232, 238, 255, 1)


//Log
#ifdef DEBUG

#define DebugLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define DebugLog(...)

#endif

#endif /* QPCFunctionConst_h */
