//V2.0
//Add this to the INIT line of the vehicle you want to use nul = [this] execVM "OffroadAUG.sqf";
//Configured to work on Offroaders and trucks. Will work on nearly everything but weapon placing may be unrelyable.

//setup MP
mpAddEventHand = {
private["_obj","_type","_code"];
_obj = _this select 0;
_type = _this select 1;
_code = _this select 2;
_add = _obj addEventHandler [_type,_code];
};
mpRemoveEventHand = {
private["_obj","_type","_index"];
_obj = _this select 0;
_type = _this select 1;
_index = _this select 2;
_obj removeEventHandler [_type, _index];
};
mpSetDir = {
private["_obj","_dir"];
_obj = _this select 0;
_dir = _this select 1;

_obj setDir _dir;
};

//SetupLocal
_veh = (_this select 0);
_moved = false;
_Cname = nil;
_Dname = nil;
_add = nil;
_MG = ["I_HMG_01_high_F","I_GMG_01_high_F","O_HMG_01_high_F","O_GMG_01_high_F","B_HMG_01_high_F","B_GMG_01_high_F","RDS_KORD_high_FIA","RDS_DSHKM_FIA","RDS_Igla_AA_pod_FIA"];
_ZU = ["RDS_ZU23_FIA"];
_LMG = ["I_HMG_01_F","O_HMG_01_F","B_HMG_01_F","I_HMG_01_A_F","O_HMG_01_A_F","B_HMG_01_A_F","RHS_NSV_TriPod_MSV","RDS_KORD_FIA","RDS_DSHkM_Mini_TriPod_FIA","RDS_Metis_FIA"];
_SPG = ["RDS_SPG9_FIA"];
_L = ["I_static_AA_F","O_static_AA_F","B_static_AA_F","RDS_TOW_TriPod_FIA"];
_M = ["I_Mortar_01_F","O_Mortar_01_F","B_Mortar_01_F","B_G_Mortar_01_F","RDS_2b14_82mm_FIA","RDS_M252_FIA"];
_veh setVariable["offAug_attached",false,true];

//Action
_add = _veh addAction ["",{

	//Import Variables
	_veh = (_this select 3) select 0;
	_L = (_this select 3) select 1;
	_MG = (_this select 3) select 2;
	_M = (_this select 3) select 3;
	_LMG = (_this select 3) select 4;
	_SPG = (_this select 3) select 5;
	_ZU = (_this select 3) select 6;
	_aug = _veh getVariable "offAug_attached";
	_NO = nearestObjects [[(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0],_MG + _L + _M + _LMG + _SPG + _ZU,5];

	//Logic
	if(( typeNAME(_veh getVariable["offAug_attached",false]) == "BOOL")  AND ((count _NO) >= 1)) then {

		//Attach
		//Locations
		if(typeOf (_NO select 0) in _L) then {(_NO select 0) attachTo [_veh,[0,-1.5,3]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;};
		if(typeOf (_NO select 0) in _LMG) then {(_NO select 0) attachTo [_veh,[-0.3,-1.5,2.9]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _SPG) then {(_NO select 0) attachTo [_veh,[-0.1,-2,2.7]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _ZU) then {(_NO select 0) attachTo [_veh,[0.05,-2,3.55]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _MG) then {(_NO select 0)attachTo [_veh,[0.25,-2,3.1]];};
		if(typeOf (_NO select 0) in _M) then {(_NO select 0) attachTo [_veh,[0,-2,2.3]];};
		//Event Handler
		[[(_NO select 0),"GetOut",{(_this select 2) setPos ((_this select 0) modelToWorld [-3,-1.1,-0.1])}],"mpAddEventHand",true,true] spawn BIS_fnc_MP;
		 _veh setVariable["offAug_attached",(_NO select 0),true];
	}else{
		if ( typeNAME(_veh getVariable["offAug_attached",false]) == "OBJECT") then {

			//Detach
			detach _aug;
			_aug setPos [(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0];
			//Remove event Handler
			[[_aug,"GetOut", 0],"mpRemoveEventHand",true,true]spawn BIS_fnc_MP;
			_veh setVariable["offAug_attached",false,true];
		}else{
			//Null
			hint "Nothing Mount/Dismount.";
		};
	};
},[_veh,_L,_MG,_M,_LMG,_SPG,_ZU],1.5,true,true,"","speed _target <= 1 AND speed _target >= -1"];


//scan
while {alive _veh} do {
sleep 1;
_aug = _veh getVariable "offAug_attached";
	if (speed _veh <= 1 AND speed _veh >= -1 ) then {
		if( typeNAME(_veh getVariable["offAug_attached",false]) == "OBJECT")  then{

			//Display name
			_Cname = typeOf _aug;
			_Dname = getText (configFile >> "cfgVehicles" >> _Cname >> "displayName");
			_veh setUserActionText [_add,format["Detach %1",_Dname]];
		}else{

			//Detection
			_NO = nearestObjects [[(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0],_MG + _L + _M + _LMG + _SPG + _ZU,5];

			if((count _NO)>=1)then{

				//Display name
				_Cname = typeOf (_NO select 0);
				_Dname = getText (configFile >> "cfgVehicles" >> _Cname >> "displayName");
				_veh setUserActionText [_add,format["Attach %1",_Dname]];
			}else{

				//Null
				_veh setUserActionText [_add,""];
			};
		};

	};
};






