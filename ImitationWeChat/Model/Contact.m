//
//  Contact.m
//
//  Created by 辉 王 on 15/7/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Contact.h"


NSString *const kContactName = @"name";
NSString *const kContactImage = @"image";


@interface Contact ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Contact

@synthesize name = _name;
@synthesize image = _image;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kContactName fromDictionary:dict];
            self.image = [self objectOrNilForKey:kContactImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kContactName];
    [mutableDict setValue:self.image forKey:kContactImage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kContactName];
    self.image = [aDecoder decodeObjectForKey:kContactImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kContactName];
    [aCoder encodeObject:_image forKey:kContactImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    Contact *copy = [[Contact alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
    }
    
    return copy;
}


@end
