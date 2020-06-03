//
//  ViewController.m
//  DPHybridExample-ObjC
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <DPHybrid/DPHybrid.h>

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView; ///< 网页

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.webView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0] setActive:YES];
    [[self.webView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0] setActive:YES];
    [[self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0] setActive:YES];
    [[self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0] setActive:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    __weak typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.webView evaluateJavaScript:@"sayHello()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    });
}

#pragma mark - Getters

- (WKWebView *)webView {
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        [configuration addFeatureWithName:@"sayHello" featureActionHandler:^(WKScriptMessage * _Nonnull message) {
            NSLog(@"啦啦啦 Hello World!");
        }];
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    }
    return _webView;
}


@end
