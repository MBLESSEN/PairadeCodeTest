//
//  media.h
//  CodeTest
//
//  Created by max blessen on 4/21/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface media : NSObject

@property (strong, nonatomic) NSData *gifData;
@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) NSString *gifURLString;


+ (instancetype)newMedia:(NSData *)image withGif:(NSString *)gifURLString;

@end
