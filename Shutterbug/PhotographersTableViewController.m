//
//  PhotographersTableViewController.m
//  Shutterbug
//
//  Created by Mike Goodspeed on 8/26/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PhotographersTableViewController.h"
#import "Photographer.h"
#import "PhotosByPhotographerTableViewController.h"

@implementation PhotographersTableViewController

- (id)initInManagedObjectContext:(NSManagedObjectContext *)context
{
    if ((self = [super initWithStyle:UITableViewStylePlain]))
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Photographer" inManagedObjectContext:context];
        NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                 ascending:YES
                                                                  selector:@selector(localizedCaseInsensitiveCompare:)];
        request.sortDescriptors = [NSArray arrayWithObject:sorter];
        request.predicate = nil;
        request.fetchBatchSize = 20;
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                              managedObjectContext:context
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:@"Photographers"];
        [request release];
        self.fetchedResultsController = frc;
        [frc release];
        self.titleKey = @"name";
    }
    return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    Photographer *photographer = (Photographer *)managedObject;
    PhotosByPhotographerTableViewController *pbptvc = [[PhotosByPhotographerTableViewController alloc]
                                                       initWithPhotographer:photographer];
    [self.navigationController pushViewController:pbptvc animated:YES];
    [pbptvc release];
}

@end
