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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"Show Image"]) {
            if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
                NSURL *url = [NSURL URLWithString:[photo.imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
            }
        }
    }
}

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
