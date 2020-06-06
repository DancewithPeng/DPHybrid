//
//  WKWebViewConfiguration+Hybrid.m
//  DPHybrid
//
//  Created by DP on 2020/6/2.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "WKWebViewConfiguration+Hybrid.h"

@implementation WKWebViewConfiguration (Hybrid)

#pragma mark - Main

- (void)addFeature:(id<HybridFeature>)feature {
    [self.userContentController removeScriptMessageHandlerForName:feature.name];
    [self.userContentController addScriptMessageHandler:feature name:feature.name];
    [self.userContentController addUserScript:[self convenientCallScriptForFeature:feature]];
}

- (void)addScript:(WKUserScript *)script {
    [self.userContentController addUserScript:script];
}

#pragma mark - Helper Methods

/// 添加便捷调用Feature
/// @param feature 对应的功能对象
- (WKUserScript *)convenientCallScriptForFeature:(id<HybridFeature>)feature {
    
    NSMutableString *scripts = [NSMutableString string];
    
    // add objects
    NSArray<NSString *> *objectNames = [feature.convenientCallIdentifier componentsSeparatedByString:@"."];
    NSString *lastObject = nil;
    for (NSString *object in objectNames) {
        if (object.length <= 0) {
            continue;
        }
        if (lastObject == nil || lastObject.length <= 0) {
            [scripts appendFormat:@"if (%@ == undefined || isNaN(%@)) { var %@ = {}; }", object, object, object];
        } else {
            [scripts appendFormat:@"if (%@.%@ == undefined || isNaN(%@.%@)) { %@.%@ = {}; }", lastObject, object, lastObject, object, lastObject, object];
        }
        
        [scripts appendString:@"\n"];
        
        if (lastObject) {
            lastObject = [lastObject stringByAppendingFormat:@".%@", object];
        } else {
            lastObject = object;
        }
    }
    
    NSString *callFunctionName = feature.name;
    if (objectNames.count > 0) {
        if ([feature.convenientCallIdentifier hasSuffix:@"."]) {
            callFunctionName = [NSString stringWithFormat:@"%@%@", feature.convenientCallIdentifier, feature.name];
        } else {
            callFunctionName = [NSString stringWithFormat:@"%@.%@", feature.convenientCallIdentifier, feature.name];
        }
    }
    [scripts appendFormat:@"%@ = function(...args) { window.webkit.messageHandlers.%@.postMessage(args); }", callFunctionName, feature.name];
    
    return [[WKUserScript alloc] initWithSource:scripts injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
}

@end
