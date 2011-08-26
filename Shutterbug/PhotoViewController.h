//
//  PhotoViewController.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoViewController : UIViewController <UIScrollViewDelegate>

- initWithPhoto:(Photo *)photo;

@property (nonatomic, retain) Photo *photo;

@end
