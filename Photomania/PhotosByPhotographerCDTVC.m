//
//  PhotosByPhotographerCDTVC.m
//  Photomania
//
//  Created by Alex Paul on 3/20/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "PhotosByPhotographerCDTVC.h"
#import "Photo.h"

@implementation PhotosByPhotographerCDTVC

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    self.title = photographer.name; 
    [self setupFetchResultsController];
}

- (void)setupFetchResultsController
{
    if (self.photographer.managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", self.photographer];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.photographer.managedObjectContext sectionNameKeyPath:nil cacheName:nil];  // Every managed object knows what context it was created in
    }else{
        self.fetchedResultsController = nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell; 
}

@end
