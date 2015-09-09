//
//  BackendUtility.h
//  TWC
//
//  Created by Anudeep Rastogi on 9/9/15.
//  Copyright (c) 2015 Anudeep Rastogi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^receivedData)(id receivedData);

@interface BackendUtility : NSObject


+ (void)requestWithURL:(NSString *)url andCompletionBlock:(receivedData)compblock;
@end
