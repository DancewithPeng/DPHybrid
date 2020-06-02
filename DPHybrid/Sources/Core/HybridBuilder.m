//
//  HybridBuilder.m
//  DPHybrid
//
//  Created by DP on 2019/11/6.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "HybridBuilder.h"


#pragma mark - HybridBuilder

@interface HybridBuilder ()

/// 初始的脚本
@property (nonatomic, strong, readonly) WKUserScript *initialScript;

/// 所有的功能
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, HybridFeatureWrapper *> *allFeatures;

@end

@implementation HybridBuilder

@synthesize configuration = _configuration;
@synthesize initialScript = _initialScript;
@synthesize allFeatures = _allFeatures;


#pragma mark - Initialization

+ (instancetype)sharedBuilder {    
    static HybridBuilder *builder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        builder = [[HybridBuilder alloc] init];
    });
    
    return builder;
}


#pragma mark - Interface

// 添加功能
- (void)addFeature:(id<HybridFeature>)feature {
    
    if ([self.allFeatures objectForKey:feature.name] != nil) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:feature.name];
        [self.allFeatures removeObjectForKey:feature.name];
        [self resetUserScripts];
    }
    
    [self.configuration.userContentController addScriptMessageHandler:feature name:feature.name];
    
    WKUserScript *convenientScript = [self universalConvenientJSFunction:feature.name withFeature:feature];
    [self.configuration.userContentController addUserScript:convenientScript];
        
    HybridFeatureWrapper *wrapper = [[HybridFeatureWrapper alloc] initWithFeature:feature convenientScript:convenientScript];
    [self.allFeatures setObject:wrapper forKey:feature.name];
}

// 添加iOS平台特定功能
- (void)addSpecificFeature:(id<HybridFeature>)feature {
    
    if ([self.allFeatures objectForKey:feature.name] != nil) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:feature.name];
        [self.allFeatures removeObjectForKey:feature.name];
        [self resetUserScripts];
    }
    
    [self.configuration.userContentController addScriptMessageHandler:feature name:feature.name];
    
    NSString *funcName = [NSString stringWithFormat:@"ios.%@", feature.name];
    WKUserScript *convenientScript = [self universalConvenientJSFunction:funcName withFeature:feature];
    [self.configuration.userContentController addUserScript:convenientScript];
    
    HybridFeatureWrapper *wrapper = [[HybridFeatureWrapper alloc] initWithFeature:feature convenientScript:convenientScript];
    [self.allFeatures setObject:wrapper forKey:feature.name];
}

// 删除功能
- (void)removeFeatureWithName:(NSString *)featureName {
    if ([self.allFeatures.allKeys containsObject:featureName] == NO) {
        return;
    }
    
    [self.allFeatures removeObjectForKey:featureName];
    [self.configuration.userContentController removeScriptMessageHandlerForName:featureName];
    [self resetUserScripts];
}

// 删除所有功能
- (void)removeAllFeatures {
    if (self.allFeatures.count <= 0) {
        return;
    }
    
    for (NSString *featureName in self.allFeatures) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:featureName];
    }
    
    [self.allFeatures removeAllObjects];
    [self.configuration.userContentController removeAllUserScripts];
    [self resetUserScripts];
}


#pragma mark - Helper Methods

/// 添加通用调用接口
- (WKUserScript *)universalConvenientJSFunction:(NSString *)functionName withFeature:(id<HybridFeature>)feature {
    NSString *convenientInterface = [NSString stringWithFormat:@"native.%@ = function(params) { window.webkit.messageHandlers.%@.postMessage(params); }", functionName, feature.name];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:convenientInterface injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    return script;
}

/// 重置用户脚本
- (void)resetUserScripts {
    [self.configuration.userContentController removeAllUserScripts];
    
    [self.configuration.userContentController addUserScript:self.initialScript];
    
    for (NSString *featureName in self.allFeatures) {
        HybridFeatureWrapper *wrapper = self.allFeatures[featureName];
        [self.configuration.userContentController addUserScript:wrapper.convenientScript];
    }
}


#pragma mark - Setter & Getter

- (WKWebViewConfiguration *)configuration {
    if (_configuration == nil) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        _configuration.userContentController = [[WKUserContentController alloc] init];
        [_configuration.userContentController addUserScript:self.initialScript];
    }
    
    return _configuration;
}

- (WKUserScript *)initialScript {
    if (_initialScript == nil) {
        NSString *script = @"var native = {};"
                            "native.ios = {};";
        _initialScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    }
    
    return _initialScript;
}

- (NSDictionary<NSString *,HybridFeatureWrapper *> *)features {
    return _allFeatures;
}

- (NSMutableDictionary<NSString *,HybridFeatureWrapper *> *)allFeatures {
    if (_allFeatures == nil) {
        _allFeatures = [[NSMutableDictionary alloc] init];
    }
    
    return _allFeatures;
}

@end


#pragma mark - HybridFeatureWrapper

@implementation HybridFeatureWrapper

- (instancetype)initWithFeature:(id<HybridFeature>)feature convenientScript:(WKUserScript *)convenientScript {
    if (self = [super init]) {
        self.feature = feature;
        self.convenientScript = convenientScript;
    }
    
    return self;
}

@end
