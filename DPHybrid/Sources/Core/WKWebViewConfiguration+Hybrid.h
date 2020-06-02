//
//  WKWebViewConfiguration+Hybrid.h
//  DPHybrid
//
//  Created by 张鹏 on 2020/6/2.
//  Copyright © 2020 深圳可飞猪科技有限公司. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Hybrid对WKWebViewConfiguration的扩展
@interface WKWebViewConfiguration (Hybrid)

/// 添加功能
/// @param feature 功能
- (void)addFeature:(id<HybridFeature>)feature;

/// 添加JS脚本
/// @param script JS脚本
- (void)addScript:(WKUserScript *)script;

@end

NS_ASSUME_NONNULL_END
