//
//  WKJsBridgeWebView.h
//  ExampleApp-iOS
//
//  Created by miaoshichang on 2018/2/11.
//  Copyright © 2018年 Marcus Westin. All rights reserved.
//


#import "WKWebViewJavascriptBridge.h"

#if defined supportsWKWebView

@interface WKJsBridgeWebView : WKWebView

+ (void)enableLogging;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;

- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;

- (void)reset;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end

#endif
