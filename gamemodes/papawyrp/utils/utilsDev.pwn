/*
TODO : Trace Back function
*/

#tryinclude "izcmd"

#if !defined CMD
	#error Veuillez Télécharger L'include izcmd | github.com/YashasSamaga/I-ZCMD
#endif

#tryinclude "YSI\y_timers"

#if !defined _INC_y_timers
	#error Impossible de Charger y_timers , introuvable
#endif

new PlayerText:DevPanel[15][MAX_PLAYERS];
new bool:isDev[MAX_PLAYERS];
new bool:panelState[MAX_PLAYERS];
new Timer:posRefresh[MAX_PLAYERS];

timer RefreshPosTD[50](playerid)
{
  new Float:x, Float:y, Float:z, devstring[256];
  GetPlayerPos(playerid, x, y, z);
  format(devstring, sizeof(devstring), "PosX: %f", x);
  PlayerTextDrawSetString(playerid, DevPanel[3][playerid], devstring);

  format(devstring, sizeof(devstring), "PosY: %f", y);
  PlayerTextDrawSetString(playerid, DevPanel[4][playerid], devstring);

  format(devstring, sizeof(devstring), "PosZ: %f", z);
  PlayerTextDrawSetString(playerid, DevPanel[5][playerid], devstring);
}

stock LoadDevPanel(playerid)
{
  DevPanel[0][playerid] = CreatePlayerTextDraw(playerid, 439.472869, 111.416610, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[0][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[0][playerid], 205.212295, 337.166625);
  PlayerTextDrawAlignment(playerid, DevPanel[0][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[0][playerid], -2139062017);
  PlayerTextDrawSetShadow(playerid, DevPanel[0][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[0][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[0][playerid], 4);

  DevPanel[1][playerid] = CreatePlayerTextDraw(playerid, 494.758575, 124.250045, "DEBUG_MODE");
  PlayerTextDrawLetterSize(playerid, DevPanel[1][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[1][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[1][playerid], -1);
  PlayerTextDrawUseBox(playerid, DevPanel[1][playerid], true);
  PlayerTextDrawBoxColor(playerid, DevPanel[1][playerid], 0);
  PlayerTextDrawSetShadow(playerid, DevPanel[1][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[1][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[1][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[1][playerid], 3);
  PlayerTextDrawSetProportional(playerid, DevPanel[1][playerid], 1);

  DevPanel[2][playerid] = CreatePlayerTextDraw(playerid, 439.004394, 146.999969, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[2][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[2][playerid], 200.527069, 3.500000);
  PlayerTextDrawAlignment(playerid, DevPanel[2][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[2][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[2][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[2][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[2][playerid], 4);

  DevPanel[3][playerid] = CreatePlayerTextDraw(playerid, 444.626983, 155.750015, "PosX:");
  PlayerTextDrawLetterSize(playerid, DevPanel[3][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[3][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[3][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[3][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[3][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[3][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[3][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[3][playerid], 1);

  DevPanel[4][playerid] = CreatePlayerTextDraw(playerid, 444.626556, 171.499984, "PosY:");
  PlayerTextDrawLetterSize(playerid, DevPanel[4][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[4][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[4][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[4][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[4][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[4][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[4][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[4][playerid], 1);

  DevPanel[5][playerid] = CreatePlayerTextDraw(playerid, 444.158294, 186.083374, "PosZ:");
  PlayerTextDrawLetterSize(playerid, DevPanel[5][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[5][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[5][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[5][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[5][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[5][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[5][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[5][playerid], 1);

  DevPanel[6][playerid] = CreatePlayerTextDraw(playerid, 439.941375, 205.916732, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[6][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[6][playerid], 200.058563, 4.083343);
  PlayerTextDrawAlignment(playerid, DevPanel[6][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[6][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[6][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[6][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[6][playerid], 4);

  DevPanel[7][playerid] = CreatePlayerTextDraw(playerid, 467.584838, 214.666580, "Runing_Function_List");
  PlayerTextDrawLetterSize(playerid, DevPanel[7][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[7][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[7][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[7][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[7][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[7][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[7][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[7][playerid], 1);

  DevPanel[8][playerid] = CreatePlayerTextDraw(playerid, 439.941436, 237.416671, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[8][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[8][playerid], 200.058563, 4.083328);
  PlayerTextDrawAlignment(playerid, DevPanel[8][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[8][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[8][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[8][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[8][playerid], 4);

  DevPanel[9][playerid] = CreatePlayerTextDraw(playerid, 446.501129, 246.166702, "Function");
  PlayerTextDrawLetterSize(playerid, DevPanel[9][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[9][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[9][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[9][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[9][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[9][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[9][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[9][playerid], 1);

  DevPanel[10][playerid] = CreatePlayerTextDraw(playerid, 586.308105, 241.150009, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[10][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[10][playerid], 3.279663, 207.083328);
  PlayerTextDrawAlignment(playerid, DevPanel[10][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[10][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[10][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[10][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[10][playerid], 4);

  DevPanel[11][playerid] = CreatePlayerTextDraw(playerid, 439.472930, 266.000000, "LD_SPAC:white");
  PlayerTextDrawLetterSize(playerid, DevPanel[11][playerid], 0.000000, 0.000000);
  PlayerTextDrawTextSize(playerid, DevPanel[11][playerid], 200.527069, 2.916687);
  PlayerTextDrawAlignment(playerid, DevPanel[11][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[11][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[11][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[11][playerid], 0);
  PlayerTextDrawFont(playerid, DevPanel[11][playerid], 4);

  DevPanel[12][playerid] = CreatePlayerTextDraw(playerid, 595.818420, 245.758331, "Line");
  PlayerTextDrawLetterSize(playerid, DevPanel[12][playerid], 0.449999, 1.600000);
  PlayerTextDrawAlignment(playerid, DevPanel[12][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[12][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[12][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[12][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[12][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[12][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[12][playerid], 1);

  DevPanel[13][playerid] = CreatePlayerTextDraw(playerid, 444.533020, 271.833038, "");
  PlayerTextDrawLetterSize(playerid, DevPanel[13][playerid], 0.283206, 0.993332);
  PlayerTextDrawAlignment(playerid, DevPanel[13][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[13][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[13][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[13][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[13][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[13][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[13][playerid], 1);

  DevPanel[14][playerid] = CreatePlayerTextDraw(playerid, 593.944519, 273.525451, "");
  PlayerTextDrawLetterSize(playerid, DevPanel[14][playerid], 0.268213, 0.999166);
  PlayerTextDrawAlignment(playerid, DevPanel[14][playerid], 1);
  PlayerTextDrawColor(playerid, DevPanel[14][playerid], -1);
  PlayerTextDrawSetShadow(playerid, DevPanel[14][playerid], 0);
  PlayerTextDrawSetOutline(playerid, DevPanel[14][playerid], 1);
  PlayerTextDrawBackgroundColor(playerid, DevPanel[14][playerid], 51);
  PlayerTextDrawFont(playerid, DevPanel[14][playerid], 1);
  PlayerTextDrawSetProportional(playerid, DevPanel[14][playerid], 1);

  for(new i = 0; i < 16; i++)
  {
    PlayerTextDrawShow(playerid, DevPanel[i][playerid]);
  }

  posRefresh[playerid] = repeat RefreshPosTD(playerid);
}

stock UnloadDevPanel(playerid)
{
  for(new i = 0; i < 16; i++)
  {
    PlayerTextDrawHide(playerid, DevPanel[i][playerid]);
    PlayerTextDrawDestroy(playerid, DevPanel[i][playerid]);
  }
  stop posRefresh[playerid];
}

stock EnableDevMode(playerid)
{
  if(IsPlayerLoged(playerid))
  {
    switch(isDev[playerid])
    {
      case 0:
      {
        isDev[playerid] = true;
        SendClientMessage(playerid, COLOR_ACTIVEBORDER, "Dev Mode Enabled");
      }
      case 1:
      {
        isDev[playerid] = false;
        SendClientMessage(playerid, COLOR_ACTIVEBORDER, "Dev Mode Disabled");
      }
    }
  }
  return 1;
}

CMD:dev(playerid,params[])
{
  EnableDevMode(playerid);
  return CMD_SUCCESS;
}

CMD:devpanel(playerid, params[])
{
  switch(isDev[playerid])
  {
    case 0: return 0;
    case 1:
    {
      switch (panelState[playerid])
      {
        case 0: LoadDevPanel(playerid), panelState[playerid] = true;
        case 1: UnloadDevPanel(playerid), panelState[playerid] = false;
      }
    }
  }
  return CMD_SUCCESS;
}

stock ShowConsole(playerid)
{
  #pragma unused playerid
  return 1;
}

CMD:outputconsole(playerid, params[])
{
  switch(isDev[playerid])
  {
    case 0:
    {
      return ShowConsole(playerid);
    }
    case 1:
    {
      return 0;
    }
  }
  return CMD_SUCCESS;
}

