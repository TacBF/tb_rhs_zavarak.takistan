#include "tb_defines.hpp"
zoneList[] =
{
//ID and PROFILE = not used
//LINK = zones capturable after this one
//DEPEND = auto-capture/enable upon these zones being held
//DEPQTY = quantity of zones required for DEPEND i.e. can have only 2 of the 3 zones in DEPEND required
//SYNC = required zones for progression

//ID TEAM          	SPAWNTYPE       LINK         SYNC   PROFILE   DEPEND     DEPQTY  ZONE_DESC
{ 0, 0           , 0          ,    	{}         	, {}    , 1      , {}        , 0      },

{ 1, TEAM_BLUE, 	SPAWN_XRAY ,    {2,3}      	, {}    , 1      , {}        , 0    , "%3" },

{ 2, TEAM_RED, 	SPAWN_NEVER,    {3,4}      	, {3}   	, 1      , {}        , 0    , "Alpha" },

{ 3, TEAM_RED, 	SPAWN_NEVER,    {4}  		, {2}    , 1      , {}        , 0    , "Bravo" },

{ 4, TEAM_RED, 	SPAWN_NEVER,    {5}      	, {}   	, 1      , {}        , 0    , "Charlie" },

{ 5, TEAM_RED, 	SPAWN_NEVER,    {6}      	, {}   	, 1      , {}        , 0    , "Delta" },

{ 6, TEAM_RED, 		SPAWN_NEVER,    {7}		, {}    , 1      , {}        , 0    , "Echo" },

{ 7, TEAM_RED, 		SPAWN_XRAY ,    {}      	, {}    , 1      , {}        , 0    , "Insurgent Main" }
};
