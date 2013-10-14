//
//  ServiceHelper.h
//  Estimater
//
//  Created by Jo on 12-10-18.
//
//

#import <Foundation/Foundation.h>

@interface ServiceHelper:NSObject

typedef void (^SucceedBlock)(MKNetworkOperation* op);


+(ServiceHelper*)getServiceHelper;

-(void)sendGet:(NSString*)url sendData:(NSMutableDictionary *)data onCompetion:(SucceedBlock)comption onError:(MKNKErrorBlock)err;
-(void)sendPost:(NSString*)url sendData:(NSMutableDictionary *)data onCompetion:(SucceedBlock)comption onError:(MKNKErrorBlock)err;

@end
