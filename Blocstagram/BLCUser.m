//
//  BLCUser.m
//  Blocstagram
//
//  Created by Jean Ro on 11/24/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import "BLCUser.h"

@implementation BLCUser
-(instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if(self) {
        self.idNumber = userDictionary[@"profile_picture"];
        self.userName = userDictionary[@"username"];
        self.fullName = userDictionary[@"full_name"];
        
        NSString *profileURLString = userDictionary[@"profile_picture"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
    }
    
    return self;
}
@end
