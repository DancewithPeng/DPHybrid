//
//  HBBasicFeature.m
//  DPHybrid
//
//  Created by DP on 2019/11/6.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "HybridBlockFeature.h"

@implementation HybridBlockFeature

@synthesize featureActionHandler = _featureActionHandler;

#pragma mark - Life Cycle Methods

- (instancetype)initWithName:(NSString *)name convenientCallIdentifier:(NSString *)convenientCallIdentifier featureActionHandler:(void (^)(WKScriptMessage * _Nonnull))featureActionHandler {
    if (self = [super init]) {
        self.name                     = name;
        self.convenientCallIdentifier = convenientCallIdentifier;
        _featureActionHandler         = [featureActionHandler copy];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name featureActionHandler:(void (^)(WKScriptMessage * _Nonnull))featureActionHandler {
    return [self initWithName:name convenientCallIdentifier:nil featureActionHandler:featureActionHandler];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.featureActionHandler != nil) {
        self.featureActionHandler(message);
    }
}

@end

@implementation HybridBuilder (HBBasicFeature)

/*
- (void)addFeatureWithName:(NSString *)name featureActionHandler:(void (^)(WKScriptMessage * _Nonnull))featureActionHandler {
    HBBasicFeature *feature = [[HBBasicFeature alloc] initWithName:name featureActionHandler:featureActionHandler];
    [self addFeature:feature];
}

- (void)addSpecificFeatureWithName:(NSString *)name featureActionHandler:(void (^)(WKScriptMessage * _Nonnull))featureActionHandler {
    HBBasicFeature *feature = [[HBBasicFeature alloc] initWithName:name featureActionHandler:featureActionHandler];
    [self addSpecificFeature:feature];
}*/

@end
