
//  main.m
//  CaesarCipher
//
//  Created by Diana Elezaj 👩 on 6/21/15.
//  Copyright (c) 2015 Diana Elezaj. All rights reserved.


#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;
- (BOOL) codeBreaker: (NSString *)string1 compareWith: (NSString *)string2;

@end


@implementation CaesarCipher

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);

        result[i] = allchars[new_idx];
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}

    // check two strings before decoding them.
    // If they complete these first sonditions, then decode, and compare if there is the same input message
BOOL checkTwoStrings (NSString *S1, NSString *S2, int off1, int off2) {
    
    // check string's length, If they aren't the same length
    // then we don't need to loop
    NSInteger count = [S1 length];
    if (count != [S2 length]) {
        NSLog(@"Strings don't have the same length");
        return YES;
    }
    //if strings are the same, but with different offsets
    else if (S1 == S2 && off1!=off2) {
        NSLog(@"Not the same input message! ");
        return YES;
    }
    // if strings different, but with the same offset
    else if (S1 != S2 && off1==off2) {
        NSLog(@"Not the same input message! ");
        return YES;
    }
    // if same strings, and same offset
    else if (S1 == S2 && off1==off2) {
        NSLog(@"You entered same strings, and same offsets! ");
        return YES;
    }
    return 0;
}

    // use codeBreaker only after decoding two trings
- (BOOL) codeBreaker: (NSString *)string1 compareWith: (NSString *)string2{
    for (int i = 1; i <26; i++) {
    //if decoded strings are equal
            if ([[self encode: string1 offset:i] isEqualToString:[self encode:string2 offset:i]]) {
                NSLog(@"Same input message!");
                return YES;
                break;
            }
    // if decoded strings are different
            else if ([[self encode: string1 offset:i] isNotEqualTo:[self encode:string2 offset:i]]) {
                    NSLog(@"Not the same input message!");
                return NO;
                break;
            }
    }
    return 0;
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CaesarCipher *checkStrings = [[CaesarCipher alloc] init];
        char firstStr [30];
        char secondStr[30];
        int offset1, offset2, option, thatsDrivingMeCrazy;

        NSLog(@"Choose an option:");
        NSLog(@"1. Encode a string");
        NSLog(@"2. Decode a string");
        NSLog(@"3. Check two encoded strings");
        scanf("%d", &option);
        
        //Encode a string
        if (option==1) {
            NSLog(@"Please enter a string:");
            scanf("%d", &thatsDrivingMeCrazy);
            scanf("%[^\n]", firstStr);
            NSLog(@"Offset:");
            scanf("%d", &offset1);
            if (offset1 > 25) {
                NSLog(@"offset is out of range. 1 - 25");
                return NO;
            }
        NSString *encodeAString = [NSString stringWithFormat:@"%s", firstStr];
        NSString *encodedString = [checkStrings encode:encodeAString offset:offset1];
        NSLog(@"Your sting encoded with offset of %d is %@", offset1, encodedString);
            
        }
        
        // Decode a string
        else if (option==2) {
    
        NSLog(@"Please enter a string:");
        scanf("%d", &thatsDrivingMeCrazy);
        scanf("%[^\n]", firstStr);
        NSLog(@"Offset:");
        scanf("%d", &offset1);
        if (offset1 > 25) {
            NSLog(@"offset is out of range. 1 - 25");
            return NO;
        }
        NSString *decodeAString = [NSString stringWithFormat:@"%s", firstStr];
        NSString *decodedString = [checkStrings decode:decodeAString offset:offset1];
        NSLog(@"Your sting decoded with offset of %d is %@", offset1, decodedString);
        }
        
        // Check two encoded strings
        else if (option==3) {
        
        NSLog(@"Please enter a string:");
        scanf("%d", &thatsDrivingMeCrazy); //I just had to add this line, in order to read the string
        scanf("%[^\n]", firstStr);
        NSLog(@"Offset:");
        scanf("%d", &offset1);
        if (offset1 > 25) {
            NSLog(@"offset is out of range. 1 - 25");
            return NO;
        }
        
        NSLog(@"Please enter another string:");
        scanf("%d", &thatsDrivingMeCrazy);  //I just had to add this line, in order to read the second string
        scanf("%[^\n]", secondStr);
        NSLog(@"Offset:");
        scanf("%d", &offset2);
        if (offset1 > 25) {
            NSLog(@"offset is out of range. 1 - 25");
            return NO;
        }
        
        NSString *firstWord = [NSString stringWithFormat:@"%s", firstStr];
        NSString *secondWord = [NSString stringWithFormat:@"%s", secondStr];
        
        // check the strings and offset before decoding them.
        // checkTwoStrings(firstWord, secondWord, offset1, offset2);
        BOOL checkedStringsBeforeDecoding = checkTwoStrings(firstWord, secondWord, offset1, offset2);
        
        if (checkedStringsBeforeDecoding == 0) {
            
            if (firstWord != secondWord && offset1 != offset2) {
                //decode encodedFirstString
                NSString *decodedFirstString = [checkStrings decode:firstWord offset:offset1];
                NSLog(@"String %@ decoded with offset of %d is %@", firstWord, offset1, decodedFirstString);
        
                //decode encodedFirstString2
                NSString *decodedSecondString = [checkStrings decode:secondWord offset:offset2];
                NSLog(@"String %@ decoded with offset of %d is %@", secondWord, offset2, decodedSecondString);
        
                //check decoded Strings if they are the same
                [checkStrings codeBreaker:decodedFirstString compareWith:decodedSecondString];
                }
            }
        }
    }
}