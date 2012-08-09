//
//  WebViewController.m
//  Sample
//
//  Created by 波切 賢一 on 12/06/28.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import "WebViewController.h"
#import "NativeProtocol.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // NativeProtocolを有効にする
        [ NSURLProtocol registerClass: [ NativeProtocol class] ];
        
        // NativeProtocolへのリクエストをViewControllerへ通知する
        NSNotificationCenter *center = [ NSNotificationCenter defaultCenter ];
        [ center addObserver:self selector:@selector(handleNativeProtocol:) name:@"handleNativeProtocol" object:nil ];
    }
    return self;
}

-(void)dealloc
{
    [ NSURLProtocol unregisterClass: [ NativeProtocol class ]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// NativeProtocolの処理を行う
-(void)handleNativeProtocol : (NSNotification *)notification
{
    NativeProtocol *protocol = notification.object;
    NSURLRequest   *request  = protocol.request;
    
    // native://closeWebViewが指定された場合
    if ([request.URL.host isEqualToString:@"closeWebView"]) {
        [ self performSelectorOnMainThread:@selector(closeWebView) withObject:nil waitUntilDone:NO];
    }
    // native://getSystemInfoが指定された場合
    else if ([request.URL.host isEqualToString:@"getSystemInfo"]) {
        NSString *systemInfo = [ self getSystemInfo ];
        
        // 値を返す
        [protocol sendResponse: systemInfo];
    }
}

// WebViewを閉じる
-(void)closeWebView
{    
    [ self.presentingViewController dismissModalViewControllerAnimated: YES ];
}

// システムの情報をWebView内に表示する。
-(NSString *)getSystemInfo
{
    // システム情報を取得する
    UIDevice *device = [ UIDevice currentDevice];
    NSString *systemInfo = [ NSString stringWithFormat:@"name=%@, version=%@",
                            device.systemName, 
                            device.systemVersion ];
    
    return systemInfo;
}

@end
