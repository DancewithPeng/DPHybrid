//
//  HybridWebViewController.h
//  DPHybrid
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HybridWebView.h"


NS_ASSUME_NONNULL_BEGIN

/// 混合页面控制器
@interface HybridWebViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

/// 网页
@property (nonatomic, strong, readonly) HybridWebView *webView;

/// 默认的URL
@property (nonatomic, strong, nullable) NSURL *defaultURL;


/// 便捷初始化方法
/// @param defaultURL 默认URL
- (instancetype)initWithDefaultURL:(nullable NSURL *)defaultURL;

@end

NS_ASSUME_NONNULL_END
