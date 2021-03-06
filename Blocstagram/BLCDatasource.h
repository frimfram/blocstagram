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

 extern NSString *const BLCImageFinishedNotification;

+(instancetype) sharedInstance;
+(NSString *) instagramClientId;

@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

- (void)deleteMediaItem:(BLCMedia *)item;
- (void)requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void)requestToDownloadImageForMedia:(BLCMedia *)item;

- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;
- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem;
- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText;
@end
