//
//  ViewController.m
//  CodeTest
//
//  Created by max blessen on 4/20/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import "ViewController.h"
#import "CodeTest-Swift.h"
#import "gifCell.h"
#import <Gifu/Gifu.h>
#import "customLayout.h"
#import "media.h"

@import Gifu;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *controller;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray<media *> *mediaArray;
@property (weak, nonatomic) IBOutlet customLayout *layout;


//Sizes

@property CGFloat fullSize;
@property CGFloat bigSize;
@property CGFloat smallSize;
@property CGFloat padding;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.layout.isDynamicSize = false;
    [super viewDidLoad];
    [self setupSizes];
    self.mediaArray = [NSMutableArray new];
    [self loadGif];
    //[self setupCollectionViewForSegment:0];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupSizes {
    self.padding = 2;
    self.fullSize = self.view.frame.size.width;
    self.bigSize = self.view.frame.size.width * (2/3);
    self.smallSize = self.view.frame.size.width/3;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadGif {
    Router *router = [[Router alloc] init];
    [router getGifs:25 completion:^(NSArray *mediaArray, NSError *error) {
            self.mediaArray = mediaArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return (self.mediaArray.count + 2)/3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    gifCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gifCell" forIndexPath:indexPath];
    if (self.mediaArray.count != 0 && (indexPath.section * 3 + indexPath.item) < self.mediaArray.count) {
            media *data = self.mediaArray[indexPath.section * 3 + indexPath.item];
            cell.media = data;
            [cell.imageView setImage:[UIImage imageWithData:data.imageData]];
    }
    return cell;
}

//
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.isDynamicSize == true) {
//        int cellNumber = indexPath.row + 1;
//        int modulo = 25 % cellNumber;
//        if (modulo == 0 ) {
//            return CGSizeMake(self.bigSize - self.padding, self.bigSize - self.padding);
//        }else {
//            return CGSizeMake(self.smallSize - self.padding, self.smallSize - self.padding);
//        }
//    }else {
//        return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3);
//    }
//}

//- (void)setupCollectionViewForSegment:(NSInteger *)segment {
//    if (segment == 0) {
//        self.layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3);
//    }else {
//        self.layout.itemSize = CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.height/3);
//    }
//}

- (IBAction)segentedControllerValueChanged:(id)sender {
    NSInteger *index = self.controller.selectedSegmentIndex;
    if (index == 0) {
        self.layout.isDynamicSize = false;
    }else {
        self.layout.isDynamicSize = true;
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:false];
        [self.collectionView.collectionViewLayout invalidateLayout];
    });
}


@end
