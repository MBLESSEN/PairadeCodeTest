//
//  gifCell.m
//  CodeTest
//
//  Created by max blessen on 4/20/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import "gifCell.h"
#import <Gifu/Gifu.h>

@import Gifu;



@implementation gifCell

- (IBAction)tappedGif:(id)sender {
    if (self.isAnimating == false){
        NSURL *gifURL = [NSURL URLWithString:self.media.gifURLString];
        [self.imageView animateWithImageData:[NSData dataWithContentsOfURL:gifURL]];
        self.isAnimating = true;
    }else {
        [self.imageView stopAnimatingGIF];
        self.isAnimating = false;
    }
}


@end
