//
//  BLCDatasource.h
//  Blocstagram
//
//  Created by Jean Ro on 11/24/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDatasource : NSObject

+(instancetype) sharedInstance;
+(NSString *) instagramClientId;

@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

-(void)deleteMediaItem:(BLCMedia *)item;
-(void)requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
 - (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
-(void)requestToDownloadImageForMedia:(BLCMedia *)item;
@end
