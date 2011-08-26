//
//  PhotosByPhotographerTableViewController.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerTableViewController : CoreDataTableViewController
{
    
}

- (id)initWithPhotographer:(Photographer *)photographer;

@end
