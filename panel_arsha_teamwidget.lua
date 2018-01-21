local UI_TM = CppEnums.TextMode
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
Panel_Arsha_TeamWidget:SetShow(false)
local arshaPvPWidget = {
  roundWing = UI.getChildControl(Panel_Arsha_TeamWidget, "Static_RoundWing"),
  freeWing = UI.getChildControl(Panel_Arsha_TeamWidget, "Static_FreeWing"),
  roundCenter = UI.getChildControl(Panel_Arsha_TeamWidget, "Static_RoundCenter"),
  freeCenter = UI.getChildControl(Panel_Arsha_TeamWidget, "Static_FreeCenter"),
  fightState = CppEnums.CompetitionFightState.eCompetitionFightState_Done,
  matchType = CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round
}
arshaPvPWidget.roundTime = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_RoundTime")
arshaPvPWidget.roundCount = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_RoundCount")
arshaPvPWidget.leftPoint = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_LeftPoint")
arshaPvPWidget.rightPoint = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_RightPoint")
arshaPvPWidget.leftParty = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_LeftParty")
arshaPvPWidget.rightParty = UI.getChildControl(arshaPvPWidget.roundCenter, "StaticText_RightParty")
arshaPvPWidget.freeTime = UI.getChildControl(arshaPvPWidget.freeCenter, "StaticText_FreeTime")
arshaPvPWidget.freeLiveTeam = UI.getChildControl(arshaPvPWidget.freeCenter, "StaticText_LiveTeam")
local saveAScore = 0
local saveBScore = 0
local teamCheck = false
local savedMatchType = 0
function ArshaPvP_Widget_Init()
  local self = arshaPvPWidget
  local team = ""
  local teamA = 0
  local teamB = 0
  if 0 == ToClient_CompetitionMatchType() then
    self.roundWing:SetShow(true)
    self.roundCenter:SetShow(true)
    self.freeWing:SetShow(false)
    self.freeCenter:SetShow(false)
  else
    self.roundWing:SetShow(false)
    self.roundCenter:SetShow(false)
    self.freeWing:SetShow(true)
    self.freeCenter:SetShow(true)
  end
  teamA = ToClient_GetRoundTeamScore(1)
  teamB = ToClient_GetRoundTeamScore(2)
  local teamA_Info = ToClient_GetTeamListAt(0)
  local teamB_Info = ToClient_GetTeamListAt(1)
  local teamA_Name = ""
  local teamB_Name = ""
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
  end
  self.leftParty:SetText(teamA_Name)
  self.rightParty:SetText(teamB_Name)
  self.leftPoint:SetText(teamA)
  self.rightPoint:SetText(teamB)
  self.roundCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_USER_OPTION_ROUND_FORCOUNT", "targetScore", ToClient_GetTargetScore()))
end
function ArshaPvP_Widget_Show()
  local self = arshaPvPWidget
  if 0 == ToClient_CompetitionMatchType() then
    self.roundWing:SetShow(true)
    self.roundCenter:SetShow(true)
    self.freeWing:SetShow(false)
    self.freeCenter:SetShow(false)
    Panel_Arsha_TeamWidget:SetShow(true)
  elseif 1 == ToClient_CompetitionMatchType() then
    self.roundWing:SetShow(false)
    self.roundCenter:SetShow(false)
    self.freeCenter:SetShow(true)
    self.freeWing:SetShow(true)
    Panel_Arsha_TeamWidget:SetShow(true)
  end
end
function ArshaPvP_Widget_Hide()
  if Panel_Arsha_TeamWidget:GetShow() then
    Panel_Arsha_TeamWidget:GetShow(false)
  end
end
function FGlobal_ArshaPvP_Widget_Show()
  if -2 == ToClient_GetMyTeamNo() then
    ArshaPvP_Widget_Hide()
    return
  end
  saveAScore = 0
  saveBScore = 0
  ArshaPvP_Widget_Show()
  ArshaPvP_Widget_Update()
end
function ArshaPvP_Widget_Update()
  local self = arshaPvPWidget
  local isMyselfInArena = ToClient_IsMyselfInArena()
  if false == isMyselfInArena then
    return
  end
  local teamA = 0
  local teamB = 0
  local isTeam = ToClient_GetMyTeamNo()
  local isFightType = ToClient_CompetitionFightState()
  self.leftPoint:SetShow(true)
  self.rightPoint:SetShow(true)
  savedMatchType = ToClient_CompetitionMatchType()
  self.matchType = savedMatchType
  if 0 == ToClient_CompetitionMatchType() then
    teamA = ToClient_GetRoundTeamScore(1)
    teamB = ToClient_GetRoundTeamScore(2)
  else
    self.leftPoint:SetShow(false)
    self.rightPoint:SetShow(false)
    self.freeLiveTeam:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_TEAMWIDGET_FREELIVETEAMSCORE", "targetScore", ToClient_GetTargetScore()))
  end
  if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == isFightType then
    local isShowTeamInfo = true
    if 1 == ToClient_CompetitionMatchType() then
      isShowTeamInfo = false
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
    Panel_Arsha_TeamWidget:SetShow(true)
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Done == isFightType then
    Panel_Arsha_TeamWidget:SetShow(true)
    if 1 == ToClient_CompetitionMatchType() then
      isShowTeamInfo = false
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Wait == isFightType then
    if 1 == ToClient_CompetitionMatchType() then
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
    Panel_Arsha_TeamWidget:SetShow(true)
  else
    if ToClient_IsMyselfInArena() then
      Panel_Arsha_TeamWidget:SetShow(true)
    else
      Panel_Arsha_TeamWidget:SetShow(false)
    end
    if 1 == ToClient_CompetitionMatchType() then
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
  end
  local teamA_Info = ToClient_GetTeamListAt(0)
  local teamB_Info = ToClient_GetTeamListAt(1)
  local teamA_Name = ""
  local teamB_Name = ""
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_A_TEAM")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_B_TEAM")
  end
  self.leftParty:SetText(teamA_Name)
  self.rightParty:SetText(teamB_Name)
  self.leftPoint:SetText(teamA)
  self.rightPoint:SetText(teamB)
  self.roundCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ARSHA_USER_OPTION_ROUND_FORCOUNT", "targetScore", ToClient_GetTargetScore()))
  local option = getArshaPvpOption()
  self.freeTime:SetText(convertSecondsToClockTime(option._timeLimit))
  self.roundTime:SetText(convertSecondsToClockTime(option._timeLimit))
end
function ArshaPvP_Match_ScoreReset()
  local self = arshaPvPWidget
  self.leftPoint:SetText(0)
  self.rightPoint:SetText(0)
end
local saveLocalWarTime = 0
local delayTime = 1
local competitionGameDeltaTime = 0
function ArshaPvP_Widget_PerframeMain(deltaTime)
  local self = arshaPvPWidget
  local isPlaying = self.fightState == CppEnums.CompetitionFightState.eCompetitionFightState_Fight
  if not isPlaying then
    return
  end
  if delayTime > competitionGameDeltaTime + deltaTime then
    competitionGameDeltaTime = competitionGameDeltaTime + deltaTime
    return
  end
  competitionGameDeltaTime = 0
  self:updateTimerWidget()
end
function arshaPvPWidget:updateTimerWidget()
  if self.matchType == CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round then
    self:_upadteTimerWidget(self.roundTime)
  elseif self.matchType == CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll then
    self:_upadteTimerWidget(self.freeTime)
  end
  Panel_Arsha_TeamWidget:ComputePos()
end
function arshaPvPWidget:_upadteTimerWidget(targetControl)
  local warTime = ToClient_CompetitionRemainMatchTime()
  if warTime > 0 then
    targetControl:SetText(convertSecondsToClockTime(warTime))
  else
    targetControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
  end
end
function FromClient_UpdateFightState(fightState)
  local self = arshaPvPWidget
  if nil == fightState or "" == fightState then
    return
  end
  self.fightState = fightState
  ArshaPvP_Widget_Init()
  if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == fightState then
    local isShowTeamInfo = true
    if 1 == ToClient_CompetitionMatchType() then
      isShowTeamInfo = false
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
    CompetitionGame_TeamUi_Create()
    Panel_Arsha_TeamWidget:SetShow(true)
    local message = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_START_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_START_SUB"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 5, 56, false)
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Done == fightState then
    Panel_Arsha_TeamWidget:SetShow(true)
    CompetitionGameTeamUI_Close()
    local message = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_STOP_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_FIGHTSTATE_STOP_SUB"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 5, 57, false)
    if 1 == ToClient_CompetitionMatchType() then
      isShowTeamInfo = false
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Wait == fightState then
    if 1 == ToClient_CompetitionMatchType() then
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
    CompetitionGameTeamUI_Close()
    Panel_Arsha_TeamWidget:SetShow(true)
  else
    if ToClient_IsMyselfInArena() then
      Panel_Arsha_TeamWidget:SetShow(true)
    else
      Panel_Arsha_TeamWidget:SetShow(false)
    end
    if 1 == ToClient_CompetitionMatchType() then
      self.roundWing:SetShow(false)
      self.roundCenter:SetShow(false)
      self.freeWing:SetShow(true)
      self.freeCenter:SetShow(true)
    else
      self.roundWing:SetShow(true)
      self.roundCenter:SetShow(true)
      self.freeWing:SetShow(false)
      self.freeCenter:SetShow(false)
      self.leftPoint:SetShow(true)
      self.rightPoint:SetShow(true)
      self.leftParty:SetShow(true)
      self.rightParty:SetShow(true)
    end
  end
end
function ArshaPvP_Widget_Repos()
  Panel_Arsha_TeamWidget:SetPosX(getScreenSizeX() / 2 - Panel_Arsha_TeamWidget:GetSizeX() / 2)
  Panel_Arsha_TeamWidget:SetPosY(0)
end
function ArshaPvP_Widget_SubInit()
  if -2 == ToClient_GetMyTeamNo() then
    ArshaPvP_Widget_Hide()
    return
  end
end
function FromClient_WaitTimeAlert(second)
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_WAIT_BEFORE_FIGHT", "waitTime", second)
  if msg ~= nil and msg ~= "" then
    Proc_ShowMessage_Ack(msg)
  end
end
function ArshaPvP_Widget_LualoadComplete()
  FGlobal_ArshaPvP_Widget_Show()
  ArshaPvP_Widget_Update()
end
ArshaPvP_Widget_Init()
ArshaPvP_Widget_SubInit()
registerEvent("FromClient_luaLoadComplete", "ArshaPvP_Widget_LualoadComplete")
registerEvent("onScreenResize", "ArshaPvP_Widget_Repos")
registerEvent("FromClient_UpdateFightState", "FromClient_UpdateFightState")
registerEvent("FromClient_UpdateTeamScore", "ArshaPvP_Widget_Update")
registerEvent("FromClient_FirstMatchStart", "ArshaPvP_Match_ScoreReset")
registerEvent("FromClient_WaitTimeAlert", "FromClient_WaitTimeAlert")
Panel_Arsha_TeamWidget:RegisterUpdateFunc("ArshaPvP_Widget_PerframeMain")
