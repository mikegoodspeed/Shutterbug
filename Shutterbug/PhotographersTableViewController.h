//
//  PhotographersTableViewController.h
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"

@interface PhotographersTableViewController : CoreDataTableViewController
{    
}

- (id)initInManagedObjectContext:(NSManagedObjectContext *)context;

@end
