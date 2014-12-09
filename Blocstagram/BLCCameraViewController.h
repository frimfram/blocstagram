//
//  BLCCameraViewController.h
//  Blocstagram
//
//  Created by Jean Ro on 12/8/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCCameraViewController;

@protocol BLCCameraViewControllerDelegate <NSObject>

-(void) cameraViewController:(BLCCameraViewController *)cameraViewController didCompleteWithImage:(UIImage *)image;

@end

@interface BLCCameraViewController : UIViewController
@property (nonatomic, weak) NSObject <BLCCameraViewControllerDelegate> *delegate;
@end
