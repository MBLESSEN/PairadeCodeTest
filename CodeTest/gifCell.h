//
//  gifCell.h
//  CodeTest
//
//  Created by max blessen on 4/20/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeTest-Swift.h"
#import <Gifu/Gifu.h>
#import "media.h"

@class media;

@class AnimatableImageView;

@interface gifCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet AnimatableImageView *imageView;
@property BOOL isAnimating;
@property media *media;

@end
