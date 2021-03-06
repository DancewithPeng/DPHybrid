//
//  WKUserScript+Hybrid.m
//  DPHybrid
//
//  Created by DP on 2020/6/2.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "WKUserScript+Hybrid.h"
#import <WebKit/WebKit.h>

@implementation WKUserScript (Hybrid)

- (instancetype)initWithSourceFile:(NSString *)sourceFilePath injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly {
    NSError *error = nil;
    NSString *jsSource = [NSString stringWithContentsOfFile:sourceFilePath encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSLog(@"%@", error);
        return nil;
    }
    
    self = [self initWithSource:jsSource injectionTime:injectionTime forMainFrameOnly:forMainFrameOnly];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithSourceFile:(NSString *)sourceFilePath injectionTime:(WKUserScriptInjectionTime)injectionTime {
    return [self initWithSourceFile:sourceFilePath injectionTime:injectionTime forMainFrameOnly:NO];
}

- (instancetype)initWithSourceFile:(NSString *)sourceFilePath {
    return [self initWithSourceFile:sourceFilePath injectionTime:WKUserScriptInjectionTimeAtDocumentStart];
}

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
/// @param injectionTime JS代码注入时机
/// @param forMainFrameOnly 是否只作用于MainFrame
+ (instancetype)scriptWithSource:(NSString *)source injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly {
    return [[WKUserScript alloc] initWithSource:source injectionTime:injectionTime forMainFrameOnly:forMainFrameOnly];
}

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
/// @param injectionTime JS代码注入时机
+ (instancetype)scriptWithSource:(NSString *)source injectionTime:(WKUserScriptInjectionTime)injectionTime {
    return [WKUserScript scriptWithSource:source injectionTime:injectionTime forMainFrameOnly:NO];
}

/// 便捷方法创建WKUserScript对象
/// @param source JS脚本
+ (instancetype)scriptWithSource:(NSString *)source {
    return [WKUserScript scriptWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart];
}

@end
