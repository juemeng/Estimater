//
//  ServiceHelper.m
//  Estimater
//
//  Created by Jo on 12-10-18.
//
//

#import "ServiceHelper.h"

@interface ServiceHelper()
@end

@implementation ServiceHelper
static ServiceHelper* serviceHelper;

+(ServiceHelper*)getServiceHelper
{
    if (!serviceHelper) {
        serviceHelper= [[ServiceHelper alloc] init];
    }
    return serviceHelper;
}

-(void)sendGet:(NSString*)url sendData:(NSMutableDictionary *)data onCompetion:(SucceedBlock)comption onError:(ErrorBlock)err
{
    MKNetworkEngine* engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url params:data httpMethod:@"GET"];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        comption(op);
    }
    onError:^(NSError *error) {
        err(error);
    }];
    [engine enqueueOperation:op];
}


-(void)sendPost:(NSString*)url sendData:(NSMutableDictionary *)data onCompetion:(SucceedBlock)comption onError:(ErrorBlock)err
{
    MKNetworkEngine* engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url params:data httpMethod:@"POST"];
    [op setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        comption(op);
    }
             onError:^(NSError *error) {
                 err(error);
             }];
    [engine enqueueOperation:op];
}

@end
