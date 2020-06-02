//
//  HybridBuilder.h
//  DPHybrid
//
//  Created by DP on 2019/11/6.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "HybridFeature.h"

@class HybridFeatureWrapper;


NS_ASSUME_NONNULL_BEGIN

/// 生成器
@interface HybridBuilder : NSObject

/// 配置
@property (nonatomic, strong, readonly) WKWebViewConfiguration *configuration;

/// 所有的功能
@property (nonatomic, strong, readonly) NSDictionary<NSString *, HybridFeatureWrapper *> *features;

/// 单例
@property (class, nonatomic, readonly) HybridBuilder *sharedBuilder;


/// 添加功能
/// @param feature 功能
- (void)addFeature:(id<HybridFeature>)feature;

/// 添加iOS平台特有的功能
/// @param feature 功能
- (void)addSpecificFeature:(id<HybridFeature>)feature;

/// 移除功能
/// @param featureName 功能名称
- (void)removeFeatureWithName:(NSString *)featureName NS_SWIFT_NAME(removeFeature(_:));

/// 移除所有功能
- (void)removeAllFeatures;

@end


/// 功能包装盒
@interface HybridFeatureWrapper : NSObject

/// 对应的便捷脚本
@property (nonatomic, strong) WKUserScript *convenientScript;

/// 对应的功能
@property (nonatomic, strong) id<HybridFeature> feature;

/// 初始化方法
/// @param feature 功能
/// @param convenientScript 便捷脚本
- (instancetype)initWithFeature:(id<HybridFeature>)feature convenientScript:(WKUserScript *)convenientScript;

@end

NS_ASSUME_NONNULL_END
