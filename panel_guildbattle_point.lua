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
local BattleModes = {
  Normal = 0,
  OneOne = 1,
  All = 2
}
PaGlobal_GuildBattlePoint = {
  _guildAName = UI.getChildControl(Panel_GuidlBattle_Point, "StaticText_Left"),
  _guildBName = UI.getChildControl(Panel_GuidlBattle_Point, "StaticText_Right"),
  _oneonePointBg = UI.getChildControl(Panel_GuidlBattle_Point, "Static_OneOneScore"),
  _guildAPoint = nil,
  _guildBPoint = nil,
  _round = {},
  _perFrmaeTimer = 0,
  _nextStateTime = 0,
  _maxTime = 0,
  _timerPause = false
}
function PaGlobal_GuildBattlePoint:initilize()
  local round = {}
  round._bg = UI.getChildControl(Panel_GuidlBattle_Point, "StaticText_Center")
  round._timer = UI.getChildControl(round._bg, "StaticText_Time")
  round._staticText_BattleMode = UI.getChildControl(round._bg, "StaticText_BattleMode")
  round._staticText_BattleStateDetail = UI.getChildControl(round._bg, "StaticText_BattleStateDetail")
  self._round = round
  self._guildAPoint = UI.getChildControl(self._guildAName, "StaticText_LeftPoint")
  self._guildBPoint = UI.getChildControl(self._guildBName, "StaticText_RightPoint")
  self._guildASurvivorCount = UI.getChildControl(self._guildAName, "StaticText_LeftNumSurvivor")
  self._guildBSurvivorCount = UI.getChildControl(self._guildBName, "StaticText_RightNumSurvivor")
  self._guildAOneOnePoint = UI.getChildControl(self._oneonePointBg, "StaticText_LeftOneOneScore")
  self._guildBOneOnePoint = UI.getChildControl(self._oneonePointBg, "StaticText_RightOneOneScore")
  self._guildASurvivorCount:SetShow(false)
  self._guildBSurvivorCount:SetShow(false)
  self._oneonePointBg:SetShow(false)
end
function PaGlobal_GuildBattlePoint:ShowSurvivorCount(isShow)
  self._guildASurvivorCount:SetShow(isShow)
  self._guildBSurvivorCount:SetShow(isShow)
end
function PaGlobal_GuildBattlePoint:ShowOneOnePoint(isShow)
  self._oneonePointBg:SetShow(isShow)
end
function PaGlobal_GuildBattlePoint:UpdateRemainTime()
  local time = ToClient_GuildBattle_GetRemainTime()
  if time < 0 then
    time = 0
  end
  local min = math.floor(time / 60)
  local sec = math.floor(time % 60)
  local zero = "0"
  if sec < 10 then
    self._round._timer:SetText(tostring(min) .. tostring(" : ") .. zero .. tostring(sec))
  else
    self._round._timer:SetText(tostring(min) .. tostring(" : ") .. tostring(sec))
  end
  if true == self:IsShow() then
    self:UpdateRoundAndScore()
  end
end
function PaGlobal_GuildBattlePoint:UpdateRoundAndScore()
  local battleState = ToClient_GuildBattle_GetCurrentState()
  local battleMode = ToClient_GuildBattle_GetCurrentMode()
  local round = ToClient_GuildBattle_GetBattleCurrentRound()
  local guildA = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(0)
  local guildB = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(1)
  self._round._staticText_BattleStateDetail:SetShow(false)
  if battleState == BattleStates.Idle then
    self._round._bg:SetText("")
  elseif battleState == BattleStates.Join then
    self._round._bg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_JOIN"))
  elseif battleState == BattleStates.Ready then
    self._round._bg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", round))
    self._round._staticText_BattleStateDetail:SetShow(true)
    self._round._staticText_BattleStateDetail:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_READYSTATE_SHORT"))
  elseif battleState == BattleStates.SelectEntry then
    self._round._bg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", round))
    self._round._staticText_BattleStateDetail:SetShow(true)
    self._round._staticText_BattleStateDetail:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SELECTENTRY_SHORT"))
  elseif battleState == BattleStates.SelectAttend then
    self._round._bg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", round))
    self._round._staticText_BattleStateDetail:SetShow(true)
    self._round._staticText_BattleStateDetail:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SELECTATTEND_SHORT"))
  elseif battleState == BattleStates.Fight then
    self._round._bg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ROUND", "round", round))
  elseif battleState == BattleStates.End then
    self._round._bg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
  elseif battleState == BattleStates.Teleport then
    self._round._bg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_TELEPORT"))
  else
    self._round._bg:SetText(PAGetString(Defines.StringSheet_GAME, ""))
  end
  self._round._staticText_BattleMode:SetShow(false)
  if battleState == BattleStates.Fight or battleState == BattleStates.SelectEntry or battleState == BattleStates.SelectAttend or battleState == BattleStates.Ready then
    self._round._staticText_BattleMode:SetShow(true)
    if battleMode == BattleModes.Normal then
      self._round._staticText_BattleMode:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_NORMAL"))
    elseif battleMode == BattleModes.OneOne then
      self._round._staticText_BattleMode:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_ONEONE"))
    elseif battleMode == BattleModes.All then
      self._round._staticText_BattleMode:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_ALL"))
    else
      self._round._staticText_BattleMode:SetText("")
    end
  end
  self._guildASurvivorCount:SetShow(false)
  self._guildBSurvivorCount:SetShow(false)
  self._oneonePointBg:SetShow(false)
  if guildA ~= nil and guildB ~= nil then
    self._guildAName:SetText(guildA:getName())
    self._guildBName:SetText(guildB:getName())
    self._guildAPoint:SetText(guildA:winPoint())
    self._guildBPoint:SetText(guildB:winPoint())
    if battleMode == BattleModes.Normal then
      if battleState == BattleStates.Fight then
        self._guildASurvivorCount:SetShow(true)
        self._guildBSurvivorCount:SetShow(true)
        local guildASurvivorCount = guildA:getNumSurvivors()
        local guildBSurvivorCount = guildB:getNumSurvivors()
        self._guildASurvivorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SURVIVORCOUNT", "count", tostring(guildASurvivorCount)))
        self._guildBSurvivorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SURVIVORCOUNT", "count", tostring(guildBSurvivorCount)))
      end
    elseif battleMode == BattleModes.OneOne then
      if battleState == BattleStates.Fight or battleState == BattleStates.Ready or battleState == BattleStates.Teleport or battleState == BattleStates.SelectAttend then
        self._oneonePointBg:SetShow(true)
        self._guildAOneOnePoint:SetText(guildA:getModeWinScore())
        self._guildBOneOnePoint:SetText(guildB:getModeWinScore())
      end
    elseif battleMode == BattleModes.All and battleState == BattleStates.Fight then
      self._guildASurvivorCount:SetShow(true)
      self._guildBSurvivorCount:SetShow(true)
      local guildASurvivorCount = guildA:getNumSurvivors()
      local guildBSurvivorCount = guildB:getNumSurvivors()
      self._guildASurvivorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SURVIVORCOUNT", "count", tostring(guildASurvivorCount)))
      self._guildBSurvivorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SURVIVORCOUNT", "count", tostring(guildBSurvivorCount)))
    end
  else
  end
end
function PaGlobal_GuildBattlePoint:Show(isShow)
  Panel_GuidlBattle_Point:SetShow(isShow)
  if true == isShow then
    self:UpdateRoundAndScore()
  end
end
function PaGlobal_GuildBattlePoint:IsShow()
  return Panel_GuidlBattle_Point:GetShow()
end
function FromClient_guildBattlePointTimer(time, max)
  PaGlobal_GuildBattlePoint:SetTimer(time, max)
end
function FromClient_unjoinGuildBattle()
  PaGlobal_GuildBattlePoint:PaGlobal_GuildBattlePoint()
end
function GuildBattlePoint_LuaLoadComplete()
  PaGlobal_GuildBattlePoint:initilize()
  Panel_GuidlBattle_Point:SetShow(false)
end
registerEvent("FromClient_luaLoadComplete", "GuildBattlePoint_LuaLoadComplete")
