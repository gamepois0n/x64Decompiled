local UI_TM = CppEnums.TextMode
local UI_classType = CppEnums.ClassType
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local UIMode = Defines.UIMode
Panel_SkillCommand:setMaskingChild(true)
Panel_SkillCommand:ActiveMouseEventEffect(true)
Panel_SkillCommand:setGlassBackground(true)
Panel_SkillCommand:RegisterShowEventFunc(true, "Panel_SkkillCommand_ShowAni()")
Panel_SkillCommand:RegisterShowEventFunc(false, "Panel_SkkillCommand_HideAni()")
local skillCommand = {
  _config = {
    pos = {
      gapY = 35,
      startX = 0,
      startY = 0
    }
  },
  _copyCommand = {},
  _slots = Array.new(),
  skilldatatable = {},
  skillCount = 0,
  lvupSkillCount = 0,
  recommandSkillCount = 0,
  skillCommand = {},
  skillCommandControl = {},
  skillCommandCount = 0,
  elapsedTime = 0,
  skillCommandIndex = {},
  skillCommandShowkeep = {},
  color = Defines.Color.C_FF444444,
  viewableMaxSkillCount = 11,
  skillNameSizeX = 0,
  isLevelUp = false,
  sizeUpCount = 0,
  _weaponType = 0
}
function Panel_SkkillCommand_ShowAni()
end
function Panel_SkkillCommand_HideAni()
end
function skillCommand:Init()
  for i = 0, self.viewableMaxSkillCount - 1 do
    local slot = {}
    slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBG", Panel_SkillCommand, "skillCommand_mainBG_" .. i)
    slot._blueBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBlueBG", slot._mainBG, "skillCommand_blueBG_" .. i)
    slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillIcon", slot._mainBG, "skillCommand_skillIcon_" .. i)
    slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillName", slot._mainBG, "skillCommand_skillName_" .. i)
    slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_SkillCommandBody", slot._mainBG, "skillCommand_skillCommandBody_" .. i)
    slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillCommand", slot._mainBG, "skillCommand_skillCommand_" .. i)
    slot._mainBG:SetShow(false)
    slot._blueBG:SetShow(false)
    slot._skillIcon:SetShow(false)
    slot._skillName:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    slot._skillCommand:SetShow(false)
    slot._mainBG:addInputEvent("Mouse_LUp", "SkillCommand_Click(" .. i .. ")")
    self._slots[i] = slot
  end
  Panel_SkillCommand:SetSize(300, 250)
end
function skillCommand:Open()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if selfPlayer:get():getLevel() < 7 then
    return
  end
  if 0 == self.skillCount then
    return
  end
  for i = 0, self.skillCount - 1 do
    local slot = self._slots[i]
    local slotConfig = self._config.pos
    slot._mainBG:SetShow(true)
    slot._skillIcon:SetShow(true)
    slot._skillName:SetShow(true)
    slot._skillCommandBody:SetShow(true)
    slot._blueBG:SetShow(false)
  end
  self.sizeUpCount = 0
  Panel_SkillCommand:SetSize(300, 250)
  skillCommand:SetSkill()
  Panel_SkillCommand:SetShow(true)
end
function FromClient_SkillCommandList(skillNo, isAwaken)
  local self = skillCommand
  if isAwaken then
    if 2 ~= self._weaponType then
      return
    end
  elseif 1 == self._weaponType or 0 == self._weaponType then
  else
    return
  end
  if 0 < #self.skilldatatable then
    local skillCheck = false
    for index = 1, #self.skilldatatable do
      if self.skilldatatable[index] == skillNo then
        skillCheck = true
      end
    end
    if not skillCheck then
      table.insert(self.skilldatatable, skillNo)
      self.recommandSkillCount = self.recommandSkillCount + 1
    end
  else
    table.insert(self.skilldatatable, skillNo)
    self.recommandSkillCount = self.recommandSkillCount + 1
  end
  self.skillCommandShowkeep[self.lvupSkillCount + self.recommandSkillCount - 1] = false
  self.elapsedTime = 0
end
function FromClient_SkillCommandListonLevelUp(skillNo, isAwaken)
  local self = skillCommand
  if isAwaken then
    if 2 == self._weaponType then
      FromClient_SkillCommandDataSet()
    end
    return
  elseif 1 == self._weaponType or 0 == self._weaponType then
  else
    return
  end
  if 0 < #self.skilldatatable then
    local skillCheck = false
    for index = 1, #self.skilldatatable do
      if self.skilldatatable[index] == skillNo then
        skillCheck = true
      end
    end
    if not skillCheck then
      table.insert(self.skilldatatable, skillNo)
      self.lvupSkillCount = self.lvupSkillCount + 1
    end
  else
    table.insert(self.skilldatatable, skillNo)
    self.lvupSkillCount = self.lvupSkillCount + 1
  end
  self.skillCommandShowkeep[self.lvupSkillCount - 1] = true
  self.elapsedTime = 0
end
function FromClient_CheckLevelUpforSkillCommand()
  skillCommand.lvupSkillCount = 0
  SkillCommand_Reset()
end
function FromClient_SkillCommandDataSet()
  SkillCommand_Reset()
  if nil == getSelfPlayer() then
    return
  end
  local pcPosition = getSelfPlayer():get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  if regionInfo:get():isSafeZone() then
    return
  end
  ToClient_RequestCommandList()
  local self = skillCommand
  self.skillCount = self.recommandSkillCount + self.lvupSkillCount
  if 0 == self.skillCount then
    return
  end
  if isChecked_SkillCommand then
    self:Open()
  end
  self.lvupSkillCount = 0
end
function skillCommand:SetSkill()
  for i = 0, self.skillCount - 1 do
    local skillWrapper = getSkillCommandStatus(self.skilldatatable[i + 1])
    local iconPath = skillWrapper:getIconPath()
    local name = skillWrapper:getName()
    local slot = self._slots[i]
    slot._skillIcon:ChangeTextureInfoName("Icon/" .. iconPath)
    slot._skillName:SetText(name)
    self.skillNameSizeX = math.max(self.skillNameSizeX, slot._skillName:GetPosX() + slot._skillName:GetTextSizeX())
  end
  local maxBgSizeX = 0
  for i = 0, self.skillCount - 1 do
    local skillWrapper = getSkillCommandStatus(self.skilldatatable[i + 1])
    local command = skillWrapper:getCommand()
    local slot = self._slots[i]
    self.skillCommand[i] = 0
    self.skillCommandControl[i] = {}
    command = SkillCommand_SearchCommand(command, i, self.skilldatatable[i + 1])
    slot._skillCommandBody:SetPosX(self.skillNameSizeX)
    self._slots[i]._mainBG:SetPosY(0 + (i + self.sizeUpCount) * 30 + i * 2)
    if Panel_SkillCommand:GetSizeX() < slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() then
      if slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() > 500 then
        Panel_SkillCommand:SetSize(400, 250)
      end
      skillCommand:CommandControl_RePos(i)
      slot._skillIcon:SetPosY(17)
      slot._skillName:SetPosY(15)
      self.sizeUpCount = self.sizeUpCount + 1
    else
      slot._skillIcon:SetPosY(2)
      slot._skillName:SetPosY(0)
    end
    maxBgSizeX = math.max(maxBgSizeX, self.skillNameSizeX + slot._skillCommandBody:GetSizeX())
  end
  for i = 0, self.skillCount - 1 do
    local slot = self._slots[i]
    slot._mainBG:SetSize(maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._blueBG:SetSize(maxBgSizeX, slot._skillCommandBody:GetSizeY())
  end
  for i = 0, self.skillCount - 1 do
    if self.skillCommandShowkeep[i] then
      self._slots[i]._blueBG:SetShow(true)
    end
  end
end
function skillCommand:CommandControl_RePos(index)
  local slot = self._slots[index]
  local basePosX = slot._skillCommandBody:GetPosX()
  local tempPosX = 5
  for controlCountIndex = 0, #self.skillCommandControl[index] do
    local controlPos = self.skillCommandControl[index][controlCountIndex]:GetPosX() + self.skillCommandControl[index][controlCountIndex]:GetSizeX() + basePosX
    if controlPos > Panel_SkillCommand:GetSizeX() then
      self.skillCommandControl[index][controlCountIndex]:SetPosX(tempPosX)
      self.skillCommandControl[index][controlCountIndex]:SetPosY(self.skillCommandControl[index][controlCountIndex]:GetPosY() + 30)
      tempPosX = tempPosX + self.skillCommandControl[index][controlCountIndex]:GetSizeX() + 5
    end
  end
  slot._skillCommandBody:SetSize(Panel_SkillCommand:GetSizeX() - slot._skillCommandBody:GetPosX(), 60)
end
function SkillCommand_StringMatchForConvert(commandIndex, stringIndex, plusIndex)
  local returnValue
  if nil ~= commandIndex then
    returnValue = 0
    if nil ~= stringIndex then
      if stringIndex < commandIndex then
        returnValue = 1
      end
      if nil ~= plusIndex and plusIndex < math.min(commandIndex, stringIndex) then
        returnValue = 2
      end
    elseif nil ~= plusIndex and plusIndex < commandIndex then
      returnValue = 2
    end
  elseif nil ~= stringIndex then
    returnValue = 1
    if nil ~= plusIndex and plusIndex < stringIndex then
      returnValue = 2
    end
  elseif nil ~= plusIndex then
    returnValue = 2
  end
  return returnValue
end
function skillCommand:commandControlSet(controlType, text, uiIndex)
  local tempControl
  if 0 == controlType then
    if "LB" == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandLMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandLMouse_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    elseif "RB" == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandRMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandRMouse_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    else
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_CommandBg", self._slots[uiIndex]._skillCommandBody, "StaticText_CommandBG_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif 1 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Command", self._slots[uiIndex]._skillCommandBody, "StaticText_Command_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif 2 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandPlus", self._slots[uiIndex]._skillCommandBody, "Static_CommandPlus_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = self._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  self._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, self._slots[uiIndex]._skillCommandBody:GetSizeY())
  self.skillCommandControl[uiIndex][self.skillCommand[uiIndex]] = tempControl
  self.skillCommand[uiIndex] = self.skillCommand[uiIndex] + 1
end
function SkillCommand_SearchCommand(command, index, skillNo)
  local self = skillCommand
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert(commandIndex, stringIndex, plusIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    self:commandControlSet(0, text, index)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    self:commandControlSet(1, text, index)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    self:commandControlSet(2, text, index)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = SkillCommand_SearchCommand(command, index, skillNo)
end
function SkillCommand_UpdateTime(updateTime)
  local self = skillCommand
  if not self.isLevelUp then
    return
  end
  if nil == self.skilldatatable then
    SkillCommand_Reset()
    return
  end
  self.elapsedTime = self.elapsedTime + updateTime
  if self.elapsedTime > 30 then
    self.lvupSkillCount = 0
    SkillCommand_Reset()
    FromClient_SkillCommandDataSet()
    self.elapsedTime = 0
    self.isLevelUp = false
    for i = 0, self.skillCount - 1 do
      self._slots[i]._blueBG:SetShow(false)
    end
  end
end
function SkillCommand_Reset()
  local self = skillCommand
  if 0 < self.skillCount then
    for i = 0, self.skillCount - 1 do
      self._slots[i]._mainBG:SetShow(false)
      self._slots[i]._skillIcon:SetShow(false)
      self._slots[i]._skillName:SetShow(false)
      self._slots[i]._skillCommand:SetShow(false)
      self._slots[i]._skillCommandBody:SetShow(false)
      self._slots[i]._skillCommandBody:SetSize(5, 30)
      table.remove(self.skilldatatable, self.skillCount - i)
    end
    self.skilldatatable = {}
    for index = 0, self.skillCount - 1 do
      if nil ~= self.skillCommandControl[index] then
        for controlCountIndex = 0, #self.skillCommandControl[index] do
          if nil ~= self.skillCommandControl[index][controlCountIndex] then
            UI.deleteControl(self.skillCommandControl[index][controlCountIndex])
            self.skillCommandControl[index][controlCountIndex] = nil
          end
        end
      end
    end
  end
  self.elapsedTime = 0
  self.skillCount = 0
  self.recommandSkillCount = 0
  self.skillCommand = {}
end
function SkillCommand_Click(index)
  HandleMLUp_SkillWindow_OpenForLearn()
end
function FGlobal_SkillCommand_ResetPosition()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  if CppDefine.ChangeUIAndResolution == true then
    if Panel_SkillCommand:GetRelativePosX() == -1 and Panel_SkillCommand:GetRelativePosY() == 1 then
      local initPosX = scrX / 2 * 1.2
      local initPosY = scrY / 2 * 0.85
      Panel_SkillCommand:SetPosX(initPosX)
      Panel_SkillCommand:SetPosY(initPosY)
      changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, false, true, false)
      FGlobal_InitPanelRelativePos(Panel_SkillCommand, initPosX, initPosY)
    elseif Panel_SkillCommand:GetRelativePosX() == 0 and Panel_SkillCommand:GetRelativePosY() == 0 then
      Panel_SkillCommand:SetPosX(scrX / 2 * 1.2)
      Panel_SkillCommand:SetPosY(scrY / 2 * 0.85)
    else
      Panel_SkillCommand:SetPosX(scrX * Panel_SkillCommand:GetRelativePosX() - Panel_SkillCommand:GetSizeX() / 2)
      Panel_SkillCommand:SetPosY(scrY * Panel_SkillCommand:GetRelativePosY() - Panel_SkillCommand:GetSizeY() / 2)
    end
  else
    Panel_SkillCommand:SetPosX(scrX / 2 * 1.2)
    Panel_SkillCommand:SetPosY(scrY / 2 * 0.85)
    changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, false, true, false)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_SkillCommand)
end
function ScreenReisze_RePosCommand()
  changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, false, true, false)
end
function FromClient_RegionChange(regionData)
  if nil == regionData then
    return
  end
  if not isChecked_SkillCommand then
    return
  end
  local isSaftyZone = regionData:get():isSafeZone()
  if not isSafeZone then
    FromClient_SkillCommandDataSet()
  end
end
function FGlobal_SkillCommand_Show(isShow)
  if isShow then
    FromClient_SkillCommandDataSet()
  end
end
function SkillCommand_LimitLevelCheck()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if not isChecked_SkillCommand then
    return
  end
  if 50 == selfPlayer:get():getLevel() then
    setShowSkillCmd(false)
    isChecked_SkillCommand = false
    GameOption_UpdateOptionChanged()
    return
  end
  skillCommand.isLevelUp = true
  FromClient_SkillCommandDataSet()
end
function SkillCommand_Effect(skillWrapper)
  if not Panel_SkillCommand:GetShow() then
    return
  end
  local self = skillCommand
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    for i = 0, self.skillCount - 1 do
      if skillNo == self.skilldatatable[i + 1] then
        self._slots[i]._skillIcon:AddEffect("UI_ButtonLineRight_WhiteLong", false, 50, 0)
      end
    end
  end
end
function FromClient_SkillCommandWeaponType(weaponType)
  local self = skillCommand
  if self._weaponType == weaponType or 0 == weaponType then
    self._weaponType = weaponType
    return
  else
    self._weaponType = weaponType
    if Panel_SkillCommand:GetShow() == true then
      FromClient_SkillCommandDataSet()
    end
  end
end
skillCommand:Init()
Panel_SkillCommand:RegisterUpdateFunc("SkillCommand_UpdateTime")
registerEvent("FromClient_CheckLevelUpforSkillCommand", "FromClient_CheckLevelUpforSkillCommand")
registerEvent("FromClient_SkillCommandListonLevelUp", "FromClient_SkillCommandListonLevelUp")
registerEvent("EventSelfPlayerLevelUp", "SkillCommand_LimitLevelCheck")
registerEvent("FromClient_SkillCommandList", "FromClient_SkillCommandList")
registerEvent("onScreenResize", "FGlobal_SkillCommand_ResetPosition")
registerEvent("selfPlayer_regionChanged", "FromClient_RegionChange")
registerEvent("FromClient_RenderModeChangeState", "FGlobal_SkillCommand_ResetPosition")
registerEvent("FromClient_SkillCommandWeaponType", "FromClient_SkillCommandWeaponType")
