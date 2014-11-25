//
//  BLCMediaTableViewCell.h
//  Blocstagram
//
//  Created by Jean Ro on 11/24/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaTableViewCell : UITableViewCell
@property (nonatomic, strong) BLCMedia *mediaItem;

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

@end
