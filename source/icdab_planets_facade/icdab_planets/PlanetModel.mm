//
//  PlanetModel.m
//  icdab_planets
//
//  Created by Faisal Memon on 16/07/2018.
//  Copyright © 2018 Faisal Memon. All rights reserved.
//

#import "PlanetModel.h"
#import "planet_data.hpp"


@implementation PlanetInfo

- (id)init {
    self = [super init];
    return self;
}

@end

@implementation PlanetModel

- (id)init {
    self = [super init];
    
    NSString *testSupportAddPluto = [[[NSProcessInfo processInfo] environment]
                                     objectForKey:@"AddPluto"];
    
    if ([testSupportAddPluto isEqualToString:@"YES"]) {
        planet::add_planet(planet("Pluto", 2370, 7375 * millionKm));
    }
    
    if (self) {
        _planetDict = [[NSMutableDictionary alloc] init];
        auto pluto_by_find = planet::find_planet_named("Pluto");
        auto jupiter_by_find = planet::find_planet_named("Jupiter");
        
        if (planet::isEnd(jupiter_by_find) || planet::isEnd(pluto_by_find)) {
            return nil;
        }
        auto pluto = pluto_by_find->second;
        auto jupiter = jupiter_by_find->second;

        PlanetInfo *plutoPlanet = [[PlanetInfo alloc] init];
        plutoPlanet.diameter = pluto.get_diameter();
        plutoPlanet.distanceFromSun = pluto.get_distance_from_sun();
        plutoPlanet.volume = pluto.get_volume();
        assert (plutoPlanet.volume != 0.0);
        [_planetDict setObject:plutoPlanet forKey:@"Pluto"];
        
        PlanetInfo *jupiterPlanet = [[PlanetInfo alloc] init];
        jupiterPlanet.diameter = jupiter.get_diameter();
        jupiterPlanet.distanceFromSun = jupiter.get_distance_from_sun();
        jupiterPlanet.volume = jupiter.get_volume();
        assert (jupiterPlanet.volume != 0.0);
        [_planetDict setObject:jupiterPlanet forKey:@"Jupiter"];
    }
    
    return self;
}

@end
