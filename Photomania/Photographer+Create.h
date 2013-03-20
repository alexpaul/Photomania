//
//  Photographer+Create.h
//  Photomania
//
//  Created by Alex Paul on 3/17/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)

+ (Photographer *)photographerWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;

@end
