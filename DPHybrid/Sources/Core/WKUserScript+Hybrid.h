//
//  WKUserScript+Hybrid.h
//  DPHybrid
//
//  Created by DP on 2020/6/2.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Hybrid框架对WKUserScript的扩展
@interface WKUserScript (Hybrid)

/// 根据JS源文件进行初始化
/// @param sourceFilePath JS源文件名
/// @param injectionTime JS代码注入时机
/// @param forMainFrameOnly 是否只作用于MainFrame
- (nullable instancetype)initWithSourceFile:(NSString *)sourceFilePath
                              injectionTime:(WKUserScriptInjectionTime)injectionTime
                           forMainFrameOnly:(BOOL)forMainFrameOnly;

/// 根据JS源文件进行初始化
/// @param sourceFilePath JS源文件名
/// @param injectionTime JS代码注入时机
- (nullable instancetype)initWithSourceFile:(NSString *)sourceFilePath
                              injectionTime:(WKUserScriptInjectionTime)injectionTime;

/// 根据JS源文件进行初始化
/// @param sourceFilePath JS源文件名
- (nullable instancetype)initWithSourceFile:(NSString *)sourceFilePath;

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
/// @param injectionTime JS代码注入时机
/// @param forMainFrameOnly 是否只作用于MainFrame
+ (instancetype)scriptWithSource:(NSString *)source
                   injectionTime:(WKUserScriptInjectionTime)injectionTime
                forMainFrameOnly:(BOOL)forMainFrameOnly;

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
/// @param injectionTime JS代码注入时机
+ (instancetype)scriptWithSource:(NSString *)source
                   injectionTime:(WKUserScriptInjectionTime)injectionTime;

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
+ (instancetype)scriptWithSource:(NSString *)source;

@end

NS_ASSUME_NONNULL_END
