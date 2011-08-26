//
//  PhotosByPhotographerTableViewController.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PhotosByPhotographerTableViewController.h"


@implementation PhotosByPhotographerTableViewController


- (id)initWithPhotographer:(Photographer *)photographer
{
    if ((self = [super initWithStyle:UITableViewStylePlain]))
    {
        NSManagedObjectContext *context = photographer.managedObjectContext;
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Photo"
                                     inManagedObjectContext:context];        
        NSSortDescriptor *sorter = [NSSortDescriptor
                                    sortDescriptorWithKey:@"title"
                                    ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sorter];
        request.predicate = [NSPredicate
                             predicateWithFormat:@"whoTook = %@", photographer];
        request.fetchBatchSize = 20;
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:context
                                           sectionNameKeyPath:nil
                                           cacheName:NULL];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        
        self.titleKey = @"title";

    }
    return self;
}

@end
