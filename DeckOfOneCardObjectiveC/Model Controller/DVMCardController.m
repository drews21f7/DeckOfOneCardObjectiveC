//
//  DVMCardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Drew Seeholzer on 7/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

#import "DVMCardController.h"
#import <UIKit/UIKit.h>

//https://deckofcardsapi.com/api/deck/new/draw/?count=1"

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation DVMCardController

+ (DVMCardController *)sharedInstance
{
    static DVMCardController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DVMCardController new];
    });
    return sharedInstance;
}


+ (void)fetchCard:(void (^)(DVMCard *, NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLComponents *components = [[NSURLComponents alloc]initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *query = [NSURLQueryItem queryItemWithName: @"count" value: @"1"];
    
    NSArray<NSURLQueryItem *> *queryArray = [[NSArray<NSURLQueryItem *> alloc]initWithObjects:query, nil];
    
    components.queryItems = queryArray;
    
    NSURL *finalURL  = components.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the JSON: %@", error);
                completion(nil, error);
                return;
            }
            
            NSArray *cardsArray = topLevelDictionary[@"cards"];
            NSMutableArray *cardsPlaceholder = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionary in cardsArray)
            {
                
                DVMCard *newCard = [[DVMCard alloc] initWithDictionary: dictionary];
                [cardsPlaceholder addObject:newCard];
                completion(newCard, nil);
            }
        }
    }] resume];

    
}



+ (void)fetchImage:(DVMCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.image];

    NSLog(@"%@", imageURL);

    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an image error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }

        if (response)
        {
            NSLog(@"%@", response);
        }

        if (data)
        {
            UIImage *cardImage = [[UIImage alloc] initWithData:data];
            completion(cardImage);
        }
    }] resume];
}

@end
