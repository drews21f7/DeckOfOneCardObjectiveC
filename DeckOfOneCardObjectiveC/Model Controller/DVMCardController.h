//
//  DVMCardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Drew Seeholzer on 7/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DVMCard.h"



@interface DVMCardController : NSObject

+ (DVMCardController *) sharedInstance;

+(void)fetchImage:(DVMCard *)card completion:(void (^) (UIImage *))completion;

+(void)fetchCard:(void(^) (DVMCard *card, NSError *error))completion;


@end

