//
//  main.m
//  Election
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward declarations
@class Contender;
@class Election;

// Contender class
@interface Contender : NSObject

- (instancetype)initWithName:(NSString *)name;
    
- (void)addVote;
- (NSInteger)votesReceived;
- (NSString *)name;

@end

@implementation Contender {
    NSInteger _votesReceived;
    NSString *_name;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _votesReceived = 0;
        _name = name;
        return self;
    }
    return nil;
}

- (void)addVote {
    _votesReceived++;
}

- (NSInteger)votesReceived {
    return _votesReceived;
}

- (NSString *)name {
    return _name;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ received %ld votes", _name, _votesReceived];
}

@end


@interface Election : NSObject

- (instancetype)initWithElectionName:(NSString *)name;

- (void)setElectionName:(NSString *)name;
- (NSString *)electionName;

- (void)addContender:(Contender *)contender;
- (void)vote;
- (void)vote:(NSInteger)index;
- (void)displayCandidates;
- (void)displayResults;

@end

// Election class
@implementation Election {
    NSString *_electionName;
    NSMutableArray *_listOfContenders;
}

- (instancetype)initWithElectionName:(NSString *)name {
    if (self = [super init]) {
        _electionName = name;
        return self;
    }
    return nil;
}

- (void)addContender:(Contender *)contender {
   if (_listOfContenders == nil) {
       _listOfContenders = [[NSMutableArray alloc] init];
   }
    [_listOfContenders addObject:contender];
}

- (void)setElectionName:(NSString *)name {
    _electionName = name;
}

- (NSString *)electionName {
    return _electionName;
}

- (void)vote:(NSInteger)index {
    Contender *contender = (Contender *)[_listOfContenders objectAtIndex:index];
    [contender addVote];
}

- (void)displayCandidates {
    for (Contender *c in _listOfContenders) {
        NSLog(@"%@", [c name]);
    }
}

- (void)displayResults {
    printf("\n%s\n", [_electionName UTF8String]);
    for (Contender *c in _listOfContenders) {
        printf("%s\n", [[c description] UTF8String]);
    }
}

- (void)vote {
    NSInteger i = 1;
    
    for (Contender *c in _listOfContenders) {
        printf("\nIndex = %ld, Contender = %s", i, [[c name] UTF8String]);
        i++;
    }
    
    printf("\n");
    
    BOOL voted = NO;
    
    while (!voted) {
        printf("\nEnter the index of the Contender you want to vote for: ");
        int vote;
        scanf("%d", &vote);
        
        int index = vote - 1;
        
        if (index >= 0 && index < _listOfContenders.count) {
            [self vote:index];
            voted = true;
        } else {
            printf("Contender does not exist...\n");
        }
    }
        
}

@end

// ElectionManager class
@interface ElectionManager : NSObject

- (void)manage:(Election *)race;
- (void)initiatePolling;
- (void)displayResults;
- (BOOL)pollsOpen;

@end

@implementation ElectionManager {
    NSMutableArray *_races;
}

- (void)manage:(Election *)race {
    if (_races == nil) {
        _races = [[NSMutableArray alloc] init];
    }
    [_races addObject:race];
}

- (void)initiatePolling {
    while ([self pollsOpen]) {
        for (Election *race in _races) {
            printf("\nVOTE FOR ONE! \n");
            [race vote];
        }
    }
}

- (void)displayResults {
    printf("Results of voting...\n");
    for (Election *race in _races) {
        [race displayResults];
    }
}

- (BOOL)pollsOpen {
    printf("Type 0 to close polls otherwise enter 1 to continue: ");
    int answer;
    scanf("%d", &answer);
    fpurge(stdin);
    
    return answer != 0;
}

@end

@interface VotingSimulator : NSObject

-(void)simulate;

@end

@implementation VotingSimulator

-(void)simulate{
    //Select Election name
    char electionNameByUser[60];
    NSLog(@"Please enter election name: ");
    scanf("%[^\n]", electionNameByUser);
    NSString *electionName = [NSString stringWithFormat:@"%s", electionNameByUser];

    //First candidate
    char firstCandidateByUser[60];
    NSLog(@"Enter a name for candidate 1: ");
    scanf(" %[^\n]", firstCandidateByUser);
    NSString *firstCandidate = [NSString stringWithFormat:@"%s", firstCandidateByUser];
    
    //second candidate
    char secondCandidateByUser[60];
    NSLog(@"Enter a name for candidate 2: ");
    scanf(" %[^\n]", secondCandidateByUser);
    NSString *secondCandidate = [NSString stringWithFormat:@"%s", secondCandidateByUser];
    
    //third candidate
    char thirdCandidateByUser[60];
    NSLog(@"Enter a name for candidate 3: ");
    scanf(" %[^\n]", thirdCandidateByUser);
    NSString *thirdCandidate = [NSString stringWithFormat:@"%s", thirdCandidateByUser];
    
    //fourth candidate
    char fourthCandidateByUser[60];
    NSLog(@"Enter a name for candidate 4: ");
    scanf(" %[^\n]", fourthCandidateByUser);
    NSString *fourthCandidate = [NSString stringWithFormat:@"%s", fourthCandidateByUser];

    Election *Election2015 = [[Election alloc] initWithElectionName:electionName];
    
    Contender *Candidate1 = [[Contender alloc] initWithName:firstCandidate];
    Contender *Candidate2 = [[Contender alloc] initWithName:secondCandidate];
    Contender *Candidate3 = [[Contender alloc] initWithName:thirdCandidate];
    Contender *Candidate4 = [[Contender alloc] initWithName:fourthCandidate];

    [Election2015 addContender:Candidate1];
    [Election2015 addContender:Candidate2];
    [Election2015 addContender:Candidate3];
    [Election2015 addContender:Candidate4];
    
    ElectionManager *Manager = [[ElectionManager alloc] init];
    
    [Manager manage:Election2015];
    [Manager initiatePolling];
    [Manager displayResults];
    
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        VotingSimulator *getReadyToVote = [[VotingSimulator alloc] init];
        [getReadyToVote simulate];
    }
    return 0;
}