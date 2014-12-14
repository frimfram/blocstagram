//
//  BLCMediaTests.m
//  Blocstagram
//
//  Created by Jean Ro on 12/13/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"


@interface BLCMediaTests : XCTestCase

@end

@implementation BLCMediaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatInitializationWorks
{
    NSDictionary *userSourceDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    
    NSDictionary *commentSourceDictionary = @{@"id": @"8675309",
                                       @"text" : @"Sample Comment"};
    
    NSDictionary *mediaSourceDictionary = @{@"id": @"123",
                                            @"user": userSourceDictionary,
                                            @"images": @{@"standard_resolution": @{ @"url": @"http://www.example.com/example.jpg"}},
                                            @"caption": @{@"text": @"some caption"},
                                            @"comments": @{ @"data": @[commentSourceDictionary]},
                                            @"likeState": @(BLCLikeStateNotLiked),
                                            @"likes": @{@"count": @33}};
    BLCMedia *testMedia = [[BLCMedia alloc] initWithDictionary:mediaSourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, mediaSourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.user.idNumber, mediaSourceDictionary[@"user"][@"id"], @"The user should be equal");
    
    XCTAssertEqual(testMedia.downloadState, BLCMediaDownloadStateNeedsImage, @"Download state should be equal");
    
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:mediaSourceDictionary[@"images"][@"standard_resolution"][@"url"]], @"The mediaURL should be equal");
    XCTAssertEqualObjects(testMedia.caption, mediaSourceDictionary[@"caption"][@"text"], @"The caption should be equal");
    
    NSUInteger count = 0;
    for (BLCComment *aComment in testMedia.comments) {
        XCTAssertEqualObjects(aComment.idNumber, mediaSourceDictionary[@"comments"][@"data"][count][@"id"], @"The comments should be equal");
        count++;
    }
    
    XCTAssertEqual(testMedia.likeState, [mediaSourceDictionary[@"likeState"] intValue], @"Like state should be equal");
    XCTAssertEqual(testMedia.likeCount, [mediaSourceDictionary[@"likes"][@"count"] intValue], @"Like count should be equal");
}


@end
