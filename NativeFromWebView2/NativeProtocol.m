//
//  NativeProtocol.m
//  NativeAndJS
//
//  Created by Adways on 12/06/19.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import "NativeProtocol.h"

@implementation NativeProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return [[[request URL] scheme] isEqualToString:@"native"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSNotificationCenter *center = [ NSNotificationCenter defaultCenter ];
    
    [ center postNotificationName:@"invokeNativeMethod" object:self userInfo:nil];
}

- (void)stopLoading
{
    /* nothing to do */
}

// レスポンスを返す
- (void) sendResponse :(NSString *)body
{
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"text/plain", @"Content-Type",
                             [NSString stringWithFormat:@"%d", [data length]], @"Content-Length",
                             nil];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL]
                                                              statusCode:200
                                                             HTTPVersion:@"1.1"
                                                            headerFields:headers];
    [self.client URLProtocol:self
              didReceiveResponse:response
              cacheStoragePolicy:NSURLCacheStorageAllowedInMemoryOnly];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

@end
