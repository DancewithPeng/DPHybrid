//
//  HybridWebViewController.m
//  DPHybrid
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "HybridWebViewController.h"

@interface HybridWebViewController ()

@end

@implementation HybridWebViewController

@synthesize webView = _webView;


#pragma mark - Initialization Methods

- (instancetype)initWithDefaultURL:(NSURL *)defaultURL {
    if (self = [super init]) {
        _defaultURL = defaultURL;
    }    
    
    return self;
}


#pragma mark - Life Cycle Methods

- (void)loadView {
    _webView = [[HybridWebView alloc] init];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaultURLIfNeeded];
}


#pragma mark - WKUIDelegate


#pragma mark - WKNavigationDelegate

// 导航的决定策略
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (decisionHandler == nil) {        
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 导航的决定策略 - iOS13
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences * _Nonnull))decisionHandler  API_AVAILABLE(ios(13.0)){
    
    if (decisionHandler == nil) {
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow, preferences);
}

// 响应策略
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    if (decisionHandler == nil) {
        return;
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - Helper Methods

/// 如果必要，加载默认URL
- (void)loadDefaultURLIfNeeded {
    if (self.defaultURL == nil) {
        return;
    }
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.defaultURL];
    [self.webView loadRequest:request];
}

/// 配置WebView
- (void)setupWebView {
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
}


#pragma mark - Setter & Getter Methods

- (void)setDefaultURL:(NSURL *)defaultURL {
    if (_defaultURL != defaultURL) {
        _defaultURL = defaultURL;
        
        if (self.isViewLoaded == YES) {
            [self loadDefaultURLIfNeeded];
        }
    }
}

@end
