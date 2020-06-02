//
//  HybridFeature.h
//  DPHybrid
//
//  Created by DP on 2019/11/6.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#ifndef HybridFeature_h
#define HybridFeature_h

#import <WebKit/WebKit.h>

/// 功能
@protocol HybridFeature <WKScriptMessageHandler>

/// 功能对应的名称，此为JS端调用此功能的对象名
@property (nonatomic, copy, nonnull) NSString *name;

/// 便捷调用标识符，
///
/// 如果设置了此值，则JS端可以通过`<convenientIdentifier>.<name>(<params>)`来调用此功能，
/// 而无需使用`window.webkit.messageHandlers.<name>.postMessage(<params>)`
@property (nonatomic, copy, nullable) NSString *convenientCallIdentifier;

@end

#endif /* HybridFeature_h */
