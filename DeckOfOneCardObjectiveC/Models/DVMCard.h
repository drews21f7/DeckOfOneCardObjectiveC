//
//  DVMCard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Drew Seeholzer on 7/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;

@property (nonatomic, copy, readonly) NSString *image;

- (instancetype)initWithCardName:(NSString *)suit
                           image:(NSString *)image;


@end

@interface DVMCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

