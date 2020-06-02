//
//  HybridWebView.m
//  DPHybrid
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "HybridWebView.h"
#import "HybridBuilder.h"


@implementation HybridWebView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame configuration:HybridBuilder.sharedBuilder.configuration.copy]) {
        
    }
    
    return self;
}

@end
