//
//  media.m
//  CodeTest
//
//  Created by max blessen on 4/21/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import "media.h"

@implementation media

+ (instancetype)newMedia:(NSData *)image withGif:(NSString *)gif {
    
    media *newMedia = [media new];
    
    newMedia.imageData = image;
    newMedia.gifURLString = gif;
    
    return newMedia;
    
}

@end
