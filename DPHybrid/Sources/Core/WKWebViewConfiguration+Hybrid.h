//
//  WKWebViewConfiguration+Hybrid.h
//  DPHybrid
//
//  Created by DP on 2020/6/2.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "HybridFeature.h"

NS_ASSUME_NONNULL_BEGIN

/// Hybrid对WKWebViewConfiguration的扩展
@interface WKWebViewConfiguration (Hybrid)

/// 添加功能
/// @param feature 功能
- (void)addFeature:(id<HybridFeature>)feature NS_SWIFT_NAME(addFeature(_:));

/// 添加JS脚本
/// @param script JS脚本
- (void)addScript:(WKUserScript *)script NS_SWIFT_NAME(addScript(_:));

@end

NS_ASSUME_NONNULL_END
