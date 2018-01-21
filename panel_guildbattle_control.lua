local isShowGuildBattleCam = true
PaGlobal_GuildBattle_Control = {_elapsedTime = 0}
local BattleModes = {
  Normal = 0,
  OneOne = 1,
  All = 2
}
local BattleStates = {
  Idle = 0,
  Join = 1,
  SelectEntry = 2,
  SelectAttend = 3,
  Ready = 4,
  Fight = 5,
  End = 6,
  Teleport = 7
}
local GuildBattleWinStates = {
  Win = 0,
  Lose = 1,
  Draw = 2
}
local HideIfShowing = function(panel)
  if true == panel:IsShow() then
    panel:Show(false)
  end
end
local ShowIfNotShowing = function(panel)
  if true ~= panel:IsShow() then
    panel:Show(true)
  end
end
function FGlobal_GuildBattle_IsOpen()
  return true == PaGlobal_GuildBattlePoint:IsShow() or true == PaGlobal_GuildBattle_SelectEntry:IsShow() or true == PaGlobal_GuildBattle_SelectAttend:IsShow()
end
local function UpdatePanelsVisibility()
  local isMaster = ToClient_GuildBattle_AmIMasterForThisBattle()
  local battleState = ToClient_GuildBattle_GetCurrentState()
  if BattleStates.Idle == battleState then
    HideIfShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.Join == battleState then
    if true == ToClient_getJoinGuildBattle() then
      ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    else
      HideIfShowing(PaGlobal_GuildBattlePoint)
    end
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.SelectEntry == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    if true == isMaster then
      ShowIfNotShowing(PaGlobal_GuildBattle_SelectEntry)
    end
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.SelectAttend == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    if true == isMaster then
      ShowIfNotShowing(PaGlobal_GuildBattle_SelectAttend)
    end
  elseif BattleStates.Ready == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.Fight == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.End == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  elseif BattleStates.Teleport == battleState then
    ShowIfNotShowing(PaGlobal_GuildBattlePoint)
    HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
    HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  else
    _PA_ASSERT(false, "\236\131\136\235\161\156\236\154\180 BattleState\234\176\128 \236\182\148\234\176\128\235\144\156 \235\147\175\237\149\169\235\139\136\235\139\164. \236\189\148\235\147\156\235\165\188 \236\151\133\235\141\176\236\157\180\237\138\184 \237\149\180\236\163\188\236\132\184\236\154\148.")
  end
end
local function ShowBattleStateChangeMessage(state)
  local progressServer = ToClient_GuildBattle_GetMyGuildBattleServer()
  local curChannelData = getCurrentChannelServerData()
  if progressServer == 0 or progressServer ~= curChannelData._serverNo then
    return
  end
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_USE_GUILDWINDOW"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  if state == BattleStates.Idle then
  elseif state == BattleStates.Join then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_USE_GUILDWINDOW"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_MATCH_SUCCESS"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif state == BattleStates.SelectEntry then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_STARTSELECT_ENTRY"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif state == BattleStates.SelectAttend then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_STARTSELECT_ATTEND"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif state == BattleStates.Ready then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_READYSTATE"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif state == BattleStates.Fight then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_FIGHTSTART"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif state == BattleStates.End then
    local winnerGuildNo = ToClient_GuildBattle_GetWinGuildNo()
    if Int64toInt32(winnerGuildNo) == -1 then
      msg = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_MATCH_DONE_DRAW"),
        sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_END"),
        addMsg = ""
      }
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
    else
      local guildName = ToClient_guild_getGuildName(winnerGuildNo)
      msg = {
        main = tostring(guildName) .. " " .. tostring(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_WINNER")),
        sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_END"),
        addMsg = ""
      }
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
    end
  elseif state == BattleStates.Teleport then
  else
    self._CanCancel = false
  end
end
function FGlobal_GuildBattle_UpdatePerFrame(deltaTime)
  if nil == ToClient_GuildBattle_IsInGuildBattle or nil == PaGlobal_GuildBattle_SelectEntry or nil == PaGlobal_GuildBattle_SelectAttend or nil == PaGlobal_GuildBattlePoint or nil == PaGlobal_GuildBattle_Control or nil == PaGlobal_GuildBattle then
    return
  end
  PaGlobal_GuildBattle_Control._elapsedTime = PaGlobal_GuildBattle_Control._elapsedTime + deltaTime
  if PaGlobal_GuildBattle_Control._elapsedTime >= 0.2 then
    ToClient_GuildBattle_UpdateTimerPerFrame()
    if true == ToClient_getJoinGuildBattle() then
      UpdatePanelsVisibility()
      if true == PaGlobal_GuildBattle_SelectEntry:IsShow() then
        PaGlobal_GuildBattle_SelectEntry:UpdateRemainTime()
      end
      if true == PaGlobal_GuildBattle_SelectAttend:IsShow() then
        PaGlobal_GuildBattle_SelectAttend:UpdateRemainTime()
      end
      if true == PaGlobal_GuildBattlePoint:IsShow() then
        PaGlobal_GuildBattlePoint:UpdateRemainTime()
      end
    end
    if true == PaGlobal_GuildBattle:IsShow() then
      PaGlobal_GuildBattle:UpdateRemainTime()
    end
    PaGlobal_GuildBattle_Control._elapsedTime = PaGlobal_GuildBattle_Control._elapsedTime - 0.2
  end
end
function FromClient_GuildBattle_Control_Initialize()
  PaGlobal_GuildBattle_Control._elapsedTime = 0
  HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
  HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  HideIfShowing(PaGlobal_GuildBattlePoint)
end
function FromClient_GuildBattle_GuildBattleTimerEnd()
end
function FromClient_GuildBattle_FightEnd(winState)
  if winState == GuildBattleWinStates.Win then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_WINFIGHT"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif winState == GuildBattleWinStates.Lose then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_LOSEFIGHT"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  elseif winState == GuildBattleWinStates.Draw then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_DRAWFIGHT"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  else
    _PA_ASSERT(false, "\236\131\136\235\161\156\236\154\180 WinState\234\176\128 \236\131\157\234\178\188\236\138\181\235\139\136\234\185\140? winState=" .. winState)
  end
end
function FromClient_GuildBattle_OnUpdateBattleInfo()
  if true == PaGlobal_GuildBattle_SelectEntry:IsShow() then
    PaGlobal_GuildBattle_SelectEntry:UpdateMemberInfo()
  end
  if true == PaGlobal_GuildBattle_SelectAttend:IsShow() then
    PaGlobal_GuildBattle_SelectAttend:UpdateMemberInfo()
  end
  if true == PaGlobal_GuildBattlePoint:IsShow() then
    PaGlobal_GuildBattlePoint:UpdateRoundAndScore()
  end
  if true == PaGlobal_GuildBattle:IsShow() then
    PaGlobal_GuildBattle:UpdateGuildBattleInfo()
  end
end
function FromClient_GuildBattle_OnChangeBattleState()
  local battleState = ToClient_GuildBattle_GetCurrentState()
  if true == ToClient_getJoinGuildBattle() then
    ShowBattleStateChangeMessage(battleState)
    UpdatePanelsVisibility()
    if true == PaGlobal_GuildBattle_SelectEntry:IsShow() then
      PaGlobal_GuildBattle_SelectEntry:UpdateMemberInfo()
      PaGlobal_GuildBattle_SelectEntry:UpdateRemainTime()
    end
    if true == PaGlobal_GuildBattle_SelectAttend:IsShow() then
      PaGlobal_GuildBattle_SelectAttend:UpdateMemberInfo()
      PaGlobal_GuildBattle_SelectAttend:UpdateRemainTime()
    end
    if true == PaGlobal_GuildBattlePoint:IsShow() then
      PaGlobal_GuildBattlePoint:UpdateRoundAndScore()
      PaGlobal_GuildBattlePoint:UpdateRemainTime()
    end
  end
  if true == PaGlobal_GuildBattle:IsShow() then
    PaGlobal_GuildBattle:UpdateGuildBattleInfo()
  end
end
function FromClient_GuildBattle_UnjoinBattle()
  PaGlobal_GuildBattle_Control._elapsedTime = 0
  HideIfShowing(PaGlobal_GuildBattle_SelectEntry)
  HideIfShowing(PaGlobal_GuildBattle_SelectAttend)
  HideIfShowing(PaGlobal_GuildBattlePoint)
end
function FromClient_GuildBattle_OurMemberJoined_GuildBattleControl(userNo)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local memberInfo = guildWrapper:getMemberByUserNo(userNo)
  if nil == memberInfo then
    return
  end
  local userName = ""
  if true == memberInfo:isOnline() then
    userName = memberInfo:getCharacterName()
  else
    userName = memberInfo:getName()
  end
  msg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_PLAYERJOINED", "characterName", userName),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 78)
end
function FromClient_GuildBattle_OurMemberUnjoined_GuildBattleControl(userNo)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local memberInfo = guildWrapper:getMemberByUserNo(userNo)
  if nil == memberInfo then
    return
  end
  local userName = ""
  if true == memberInfo:isOnline() then
    userName = memberInfo:getCharacterName()
  else
    userName = memberInfo:getName()
  end
  msg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_PLAYERUNJOINED", "characterName", userName),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 78)
  if true == PaGlobal_GuildBattle_SelectEntry:IsShow() then
    PaGlobal_GuildBattle_SelectEntry:UpdateMemberInfo()
  end
  if true == PaGlobal_GuildBattle_SelectAttend:IsShow() then
    PaGlobal_GuildBattle_SelectAttend:UpdateMemberInfo()
  end
end
function FromClient_GuildBattle_SomeOneKilledSomeOne_GuildBattleControl(attackerName, peerName, attackerTeamNo, peerTeamNo)
  local attackerGuildInfo = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(attackerTeamNo)
  local peerGuildInfo = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(peerTeamNo)
  if nil == attackerGuildInfo or nil == peerGuildInfo then
    return
  end
  msg = {
    main = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SOMEONEKILLEDSOMEONE", "attackerName", attackerName, "attackGuildName", attackerGuildInfo:getName(), "peerName", peerName, "peerGuildName", peerGuildInfo:getName()),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 4.5, 78)
end
function FromClient_GuildBattle_AttendPlayer_GuildBattleControl()
  msg = {
    main = "\236\176\184\234\176\128\236\158\144\235\161\156 \236\132\160\237\131\157\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.",
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 78)
end
local GuildWatchMode = {
  UI_BG = UI.getChildControl(Panel_GuildBattleWatchingMode, "Static_CommandBG"),
  UI_KeyQ = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Key_Q"),
  UI_KeyE = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Key_E"),
  UI_KeyR = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Key_R"),
  UI_TextSmall = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Small"),
  UI_TextBig = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Big"),
  UI_TextExit = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_Exit"),
  UI_TextDesc = UI.getChildControl(Panel_GuildBattleWatchingMode, "StaticText_CameraSpeedLow"),
  UI_ShowButton = UI.getChildControl(Panel_GuildBattleWatchingMode, "Button_ShowCommand")
}
function HandleClick_WatchShowToggle()
  if true == GuildWatchMode.UI_BG:GetShow() then
    GuildWatchMode_SetControlShow(false)
  else
    GuildWatchMode_SetControlShow(true)
  end
end
function GuildWatchMode_SetControlShow(isShow)
  GuildWatchMode.UI_BG:SetShow(isShow)
  GuildWatchMode.UI_KeyQ:SetShow(isShow)
  GuildWatchMode.UI_KeyE:SetShow(isShow)
  GuildWatchMode.UI_KeyR:SetShow(isShow)
  GuildWatchMode.UI_TextSmall:SetShow(isShow)
  GuildWatchMode.UI_TextBig:SetShow(isShow)
  GuildWatchMode.UI_TextExit:SetShow(isShow)
  GuildWatchMode.UI_TextDesc:SetShow(isShow)
  if false == isShow then
    Panel_GuildBattleWatchingMode:SetPosY(Panel_GuildBattleWatchingMode:GetPosY() + 200)
  else
    Panel_GuildBattleWatchingMode:SetPosY(Panel_GuildBattleWatchingMode:GetPosY() - 200)
  end
end
function WatchingPanel_SetPosition()
  local ScrX = getScreenSizeX()
  local ScrY = getScreenSizeY()
  Panel_GuildBattleWatchingMode:SetSize(200, 320)
  Panel_GuildBattleWatchingMode:SetPosY(ScrY * 3 / 4)
  Panel_GuildBattleWatchingMode:ComputePos()
end
function FromClient_NotifyGuildTeamBattleShowWatchPanel(isShow)
  if false == isShowGuildBattleCam then
    ToClient_CanOpenGuildBattleCam(false)
    return
  end
  WatchingPanel_SetPosition()
  GuildWatchMode.UI_BG:SetShow(isShow)
  GuildWatchMode.UI_KeyQ:SetShow(isShow)
  GuildWatchMode.UI_KeyE:SetShow(isShow)
  GuildWatchMode.UI_KeyR:SetShow(isShow)
  GuildWatchMode.UI_TextSmall:SetShow(isShow)
  GuildWatchMode.UI_TextBig:SetShow(isShow)
  GuildWatchMode.UI_TextExit:SetShow(isShow)
  GuildWatchMode.UI_TextDesc:SetShow(isShow)
  GuildWatchMode.UI_ShowButton:SetCheck(isShow)
  Panel_GuildBattleWatchingMode:SetShow(isShow)
  ToClient_CanOpenGuildBattleCam(isShow)
end
function FromClient_NotifyGuildBattleCameraMessage()
  return
end
Panel_GuildBattleWatchingMode:SetShow(false)
GuildWatchMode.UI_ShowButton:addInputEvent("Mouse_LUp", "HandleClick_WatchShowToggle()")
GuildWatchMode.UI_ShowButton:SetCheck(true)
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildBattle_Control_Initialize")
registerEvent("FromClient_GuildBattle_FightEnd", "FromClient_GuildBattle_FightEnd")
registerEvent("FromClient_guildBattleTimer", "FromClient_GuildBattle_GuildBattleTimerEnd")
registerEvent("FromClient_responseRequestGuildBattleInfo", "FromClient_GuildBattle_OnUpdateBattleInfo")
registerEvent("FromClient_GuildBattle_StateChanged", "FromClient_GuildBattle_OnChangeBattleState")
registerEvent("FromClient_unjoinGuildBattle", "FromClient_GuildBattle_UnjoinBattle")
registerEvent("FromClient_GuildBattle_OurMemberJoined", "FromClient_GuildBattle_OurMemberJoined_GuildBattleControl")
registerEvent("FromClient_GuildBattle_OurMemberUnjoined", "FromClient_GuildBattle_OurMemberUnjoined_GuildBattleControl")
registerEvent("FromClient_GuildBattle_SomeOneKilledSomeOne", "FromClient_GuildBattle_SomeOneKilledSomeOne_GuildBattleControl")
registerEvent("FromClient_GuildBattle_AttendPlayer", "FromClient_GuildBattle_AttendPlayer_GuildBattleControl")
registerEvent("FromClient_NotifyGuildTeamBattleShowWatchPanel", "FromClient_NotifyGuildTeamBattleShowWatchPanel")
registerEvent("FromClient_NotifyGuildBattleCameraMessage", "FromClient_NotifyGuildBattleCameraMessage")
