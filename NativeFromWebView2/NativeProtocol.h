//
//  NativeProtocol.h
//  NativeAndJS
//
//  Created by Adways on 12/06/19.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeProtocol : NSURLProtocol
- (void) sendResponse : (NSString *)body;
@end
