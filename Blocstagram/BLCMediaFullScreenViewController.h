//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Jean Ro on 12/1/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) BLCMedia *media;

-(instancetype) initWithMedia:(BLCMedia *)media;

-(void) centerScrollView;
-(void) recalculateZoomScale;

@end
