//
//  DemoPhotographerCDTVC.m
//  Photomania
//
//  Created by Alex Paul on 3/18/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "DemoPhotographerCDTVC.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"

@implementation DemoPhotographerCDTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.managedObjectContext) [self useDemoDocument]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged]; 
}

- (void)useDemoDocument
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"Demo Document"];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        //  Create it
        [document saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success){
              if (success) {
                  self.managedObjectContext = document.managedObjectContext;
                  [self refresh]; 
              }
          }];
    }else if (document.documentState == UIDocumentStateClosed){
        //  Open it
        [document openWithCompletionHandler:^(BOOL success){
            if (success) {
                self.managedObjectContext = document.managedObjectContext;
            }
        }];
        
    }else{
        //  Try to use it
        self.managedObjectContext = document.managedObjectContext;
    }
}

- (void)refresh
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetch", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *photos = [FlickrFetcher latestGeoreferencedPhotos];
        //  Put the photos in Core Data
        [self.managedObjectContext performBlock:^{ // Do the code block on the right thread for this context. It knows which thread is the right thread
            for (NSDictionary *photo in photos) {
                [Photo photoWithFlickrInfo:photo inManagedObjectContext:self.managedObjectContext];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
            });
        }];
    });
}


@end
