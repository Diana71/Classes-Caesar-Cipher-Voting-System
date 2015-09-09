//
//  main.m
//  Person
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person: NSObject

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setCity:(NSString *)city;
- (NSString *)city;

- (void)setPhoneNumber:(NSString *)phoneNumber;
- (NSString *)phoneNumber;



-(void) changePersonsName:(Person *)aPerson toName:(NSString *)newName;

- (BOOL)checkSameCity:(Person *)otherPerson;

- (Person *)registerChild;

@end

@implementation Person {
    NSString *_name;
    NSString *_phoneNumber;
    NSString *_city;
    Person *_returnChild;
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}

- (void)setCity:(NSString *)city {
    _city = city;
}

- (NSString *)city {
    return _city;
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
}

- (NSString *)phoneNumber {
    return _phoneNumber;
}


- (BOOL)checkSameCity:(Person *)otherPerson{

    if ([[otherPerson city] isEqualToString: [self city]]){
        NSLog (@"%@ and %@ live in the same city" , [self name], [otherPerson name]);
        return YES;
    } else {
        NSLog (@"%@ and %@ do not live in the same city" , [self name], [otherPerson name]);

        return NO;
    }
 }

 -(void) changePersonsName:(Person *)aPerson toName:(NSString *)newName {
    [aPerson setName: newName];
}


- (Person *)registerChild {
    Person* child = [[Person alloc]init];
    
    [child setPhoneNumber:_phoneNumber];
    [child setCity:_city];
    [child setName:@"Baby"];
    return child;
}




@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        Person *Carl = [[Person alloc] init];
        Person *Matt = [[Person alloc] init];
        
        [Carl setName: @"Carl"];
        [Carl setCity: @"Queens"];
        [Carl setPhoneNumber:@"599-6452"];
        
        [Matt setName: @"Matt"];
        [Matt setCity: @"New York"];
        [Matt setPhoneNumber:@"600-3454"];

        
 
        [Carl checkSameCity:Matt];
        
        NSLog(@"Sorry Carl, I don't like you anymore. I will change your name!");
        [Carl setName:@"Jack"];
        NSLog (@"Carl's new name is %@ ", [Carl name]);
        
       
        NSLog (@"***** Matt has a babyyyy *****");
        Person *mattsBaby = [Matt registerChild];
        
        [mattsBaby setName:@"Anthony"];
        
        NSLog(@"His name is %@", [mattsBaby name]);
        NSLog (@"Matt lives in %@ and %@ lives also in %@", [Matt city], [mattsBaby name], [mattsBaby city]);
        NSLog(@"Matt's phone number is: %@" , [Matt phoneNumber]);
        NSLog(@"His baby's phone number is %@", [mattsBaby phoneNumber]);
        
    }
    
    return 0;
}
