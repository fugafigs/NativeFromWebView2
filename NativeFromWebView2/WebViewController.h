//
//  WebViewController.h
//  Sample
//
//  Created by Adways on 12/06/28.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
