//
//  BLCDatasource.h
//  Blocstagram
//
//  Created by Jean Ro on 11/24/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLCDatasource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

-(void)removeMediaItemAtIndex:(NSUInteger)index;

@end
