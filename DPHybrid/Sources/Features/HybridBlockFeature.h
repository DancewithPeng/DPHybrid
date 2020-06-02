//
//  HBBasicFeature.h
//  DPHybrid
//
//  Created by DP on 2019/11/6.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HybridFeature.h"
#import "HybridBuilder.h"


NS_ASSUME_NONNULL_BEGIN

/// 使用Block来处理逻辑的功能
@interface HybridBlockFeature : NSObject <HybridFeature>

/// 功能对应的名称，此为JS端调用此功能的对象名
@property (nonatomic, copy, nonnull) NSString *name;

/// 便捷调用标识符，
///
/// 如果设置了此值，则JS端可以通过`<convenientIdentifier>.<name>(<params>)`来调用此功能，
/// 而无需使用`window.webkit.messageHandlers.<name>.postMessage(<params>)`
@property (nonatomic, copy, nullable) NSString *convenientCallIdentifier;

/// 操作处理器
@property (nonatomic, copy, readonly) void (^featureActionHandler)(WKScriptMessage *message);

- (instancetype)initWithName:(NSString *)name convenientCallIdentifier:(nullable NSString *)convenientCallIdentifier featureActionHandler: (void (^)(WKScriptMessage *))featureActionHandler;

/// 初始化方法
/// @param name 名字
/// @param featureActionHandler 功能操作处理器
- (instancetype)initWithName:(NSString *)name featureActionHandler: (void (^)(WKScriptMessage *))featureActionHandler;

@end


/// `HBBasicFeature`对`HybridBuilder`的扩展
@interface HybridBuilder (HBBasicFeature)

/// 添加功能
/// js调用形式: `native.name('{}')`
/// @param name 功能名称
/// @param featureActionHandler 功能的操作
- (void)addFeatureWithName:(NSString *)name featureActionHandler: (nullable void (^)(WKScriptMessage *))featureActionHandler NS_SWIFT_NAME(addFeature(_:featureActionHandler:));

/// 添加iOS平台特有的功能
/// js调用形式: `native.ios.name('{}')`
/// @param name 功能名称
/// @param featureActionHandler 功能的操作
- (void)addSpecificFeatureWithName:(NSString *)name featureActionHandler: (nullable void (^)(WKScriptMessage *))featureActionHandler NS_SWIFT_NAME(addSpecificFeature(_:featureActionHandler:));
 
@end

NS_ASSUME_NONNULL_END
