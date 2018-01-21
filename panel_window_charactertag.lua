local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_TM = CppEnums.TextMode
local UCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_Class = CppEnums.ClassType
local UI_DefaultFaceTexture = CppEnums.ClassType_DefaultFaceTexture
local PP = CppEnums.PAUIMB_PRIORITY
local ePcWorkingType = CppEnums.PcWorkType
local const_64 = Defines.s64_const
local isDev = ToClient_IsDevelopment()
local isOpenCharacterTag = ToClient_IsContentsGroupOpen("330")
local localDefine = {
  CHARSLOTCOLMAX = 6,
  CHARSLOTROWMAX = 2,
  CHARSLOTLISTMAX = 12,
  SCROLLVERTICAL = 270,
  NODUEL = -1
}
local CharacterTag = {
  _doTag = false,
  _UI = {
    _StaticText_TagAreaValue,
    _Static_MainImage_1,
    _Static_MainImage_2,
    _CheckButton_TagState,
    _Static_CharacterList = {},
    _Button_Question,
    _Button_Close,
    _CheckButton_PopUp,
    _StaticText_Name_1,
    _StaticText_Name_2,
    _Scroll_Tag,
    _Scroll_CtrlButton,
    _StaticText_Desc,
    _StaticText_TagState
  },
  _requestCharacterKey = -1,
  _currentTagState = false,
  _selfCharTag = false,
  _maxCharacterCount = 0,
  _pageIndex = 0
}
function CharacterTag:Initialize()
  local selfUI = self._UI
  selfUI._StaticText_TagAreaValue = UI.getChildControl(Panel_CharacterTag, "StaticText_TagAreaValue")
  local aaa = UI.getChildControl(Panel_CharacterTag, "Static_MainImageBorder_1")
  selfUI._Static_MainImage_1 = UI.getChildControl(Panel_CharacterTag, "Static_MainImage_1")
  selfUI._Static_MainImage_2 = UI.getChildControl(Panel_CharacterTag, "Static_MainImage_2")
  selfUI._Static_QuestionIcon_2 = UI.getChildControl(selfUI._Static_MainImage_2, "Static_QuestionIcon")
  selfUI._CheckButton_TagState = UI.getChildControl(Panel_CharacterTag, "CheckButton_TagState")
  selfUI._Button_Close = UI.getChildControl(Panel_CharacterTag, "Button_Close")
  selfUI._Button_Close:addInputEvent("Mouse_LUp", "PaGlobal_CharacterTag_Close()")
  selfUI._CheckButton_PopUp = UI.getChildControl(Panel_CharacterTag, "CheckButton_PopUp")
  selfUI._CheckButton_PopUp:addInputEvent("Mouse_LUp", "CharacterTag_PopUp_UI()")
  selfUI._CheckButton_PopUp:addInputEvent("Mouse_On", "CharacterTag_PopUp_ShowIconToolTip(true)")
  selfUI._CheckButton_PopUp:addInputEvent("Mouse_Out", "CharacterTag_PopUp_ShowIconToolTip(false)")
  selfUI._StaticText_Name_1 = UI.getChildControl(Panel_CharacterTag, "StaticText_Name_1")
  selfUI._StaticText_Name_2 = UI.getChildControl(Panel_CharacterTag, "StaticText_Name_2")
  local descBg = UI.getChildControl(Panel_CharacterTag, "Static_DescBg")
  selfUI._StaticText_Desc = UI.getChildControl(descBg, "StaticText_Desc")
  selfUI._StaticText_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DESC"))
  selfUI._StaticText_Desc:SetShow(true)
  local templateCharacterList = UI.getChildControl(Panel_CharacterTag, "Static_TemPleate_CharacterImageBorder")
  local templateImage = UI.getChildControl(templateCharacterList, "Static_Image")
  local templateLevel = UI.getChildControl(templateCharacterList, "StaticText_Level")
  local templateState = UI.getChildControl(templateCharacterList, "StaticText_State")
  local mainBg = UI.getChildControl(Panel_CharacterTag, "Static_MainBg")
  mainBg:addInputEvent("Mouse_UpScroll", "PaGlobal_CharacterTag_ScrollEvent(true)")
  mainBg:addInputEvent("Mouse_DownScroll", "PaGlobal_CharacterTag_ScrollEvent(false)")
  self._maxCharacterCount = getCharacterDataCount()
  for index = 0, 11 do
    selfUI._Static_CharacterList[index] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, Panel_CharacterTag, "Static_CharacterList_" .. index)
    CopyBaseProperty(templateCharacterList, selfUI._Static_CharacterList[index])
    local Static_Image = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, selfUI._Static_CharacterList[index], "Static_Image")
    CopyBaseProperty(templateImage, Static_Image)
    local StaticText_State = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, selfUI._Static_CharacterList[index], "StaticText_State")
    CopyBaseProperty(templateState, StaticText_State)
    local StaticText_Level = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, selfUI._Static_CharacterList[index], "StaticText_Level")
    CopyBaseProperty(templateLevel, StaticText_Level)
    selfUI._Static_CharacterList[index]:SetShow(false)
    selfUI._Static_CharacterList[index]:addInputEvent("Mouse_UpScroll", "PaGlobal_CharacterTag_ScrollEvent(true)")
    selfUI._Static_CharacterList[index]:addInputEvent("Mouse_DownScroll", "PaGlobal_CharacterTag_ScrollEvent(false)")
  end
  templateCharacterList:SetShow(false)
  templateCharacterList:SetIgnore(true)
  selfUI._CheckButton_TagState:addInputEvent("Mouse_LUp", "HandleEvent_ClickRequestTag()")
  selfUI._CheckButton_TagState:SetIgnore(false)
  selfUI._Scroll_Tag = UI.getChildControl(Panel_CharacterTag, "Scroll_Tag")
  selfUI._Scroll_CtrlButton = UI.getChildControl(selfUI._Scroll_Tag, "Scroll_CtrlButton")
  selfUI._StaticText_TagState = UI.getChildControl(Panel_CharacterTag, "StaticText_TagState")
  UIScroll.SetButtonSize(selfUI._Scroll_Tag, 2, math.ceil(self._maxCharacterCount / 6))
  UIScroll.InputEvent(selfUI._Scroll_Tag, "PaGlobal_CharacterTag_ScrollEvent")
end
function PaGlobal_Request_TagCharacter(characterKey)
  ToClient_RequestDuelCharacter(characterKey)
end
function PaGlobal_Delete_TagCharacter(characterKey)
  ToClient_RequestDeleteDuelCharacter(characterKey)
end
function HandleEvent_ClickRequestTag()
  local self = CharacterTag
  self._UI._CheckButton_TagState:SetCheck(self._currentTagState)
  if false == self._selfCharTag then
    return
  end
  if localDefine.NODUEL == self._requestCharacterKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_NEEDSELECTCHARACTER"))
    return
  end
  if self._currentTagState then
    PaGlobal_Delete_TagCharacter(self._requestCharacterKey)
  else
    PaGlobal_Request_TagCharacter(self._requestCharacterKey)
  end
end
function PaGlobal_IsTagChange()
  local retBool = CharacterTag._doTag
  if true == CharacterTag._doTag then
    CharacterTag._doTag = false
  end
  return retBool
end
function PaGlobal_TagCharacter_Change()
  local index = ToClient_GetMyDuelCharacterIndex()
  if localDefine.NODUEL == index then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CURRENT_NOT_TAGGING"))
    return
  end
  if true == ToClient_getJoinGuildBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
    return
  end
  CharacterTag._doTag = true
  Panel_GameExit_ChangeCharacter(index)
end
function CharacterTag:SetLeftFace(idx, isRegionKey)
  local characterData = getCharacterDataByIndex(idx)
  local char_Type = getCharacterClassType(characterData)
  local char_Level = string.format("%d", characterData._level)
  local char_Name = getCharacterName(characterData)
  local char_TextureName = getCharacterFaceTextureByIndex(idx)
  local duelChar_No_s64 = characterData._duelCharacterNo
  local duelRegion_Key = characterData._duelRegionKey
  local isCaptureExist = self._UI._Static_MainImage_1:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, PaGlobal_getIsExitPhoto())
  if true == isCaptureExist then
    self._UI._Static_MainImage_1:getBaseTexture():setUV(0, 0, 1, 1)
  else
    self:FaceSetting(self._UI._Static_MainImage_1, char_Type)
  end
  self._UI._Static_MainImage_1:setRenderTexture(self._UI._Static_MainImage_1:getBaseTexture())
  self._UI._Static_MainImage_1:SetShow(true)
  self._UI._StaticText_Name_1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level .. " " .. char_Name)
  local RegionInfo = getRegionInfoByRegionKey(duelRegion_Key)
  if nil ~= RegionInfo then
    self._UI._StaticText_TagAreaValue:SetText(getRegionInfoByRegionKey(duelRegion_Key):getAreaName())
  end
end
function CharacterTag:SetRightFace(idx)
  local characterData = getCharacterDataByIndex(idx)
  local char_Type = getCharacterClassType(characterData)
  local char_Level = string.format("%d", characterData._level)
  local char_Name = getCharacterName(characterData)
  local char_TextureName = getCharacterFaceTextureByIndex(idx)
  local duelChar_No_s64 = characterData._duelCharacterNo
  local duelRegion_Key = characterData._duelRegionKey
  local isCaptureExist = self._UI._Static_MainImage_2:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, PaGlobal_getIsExitPhoto())
  if true == isCaptureExist then
    self._UI._Static_MainImage_2:getBaseTexture():setUV(0, 0, 1, 1)
  else
    self:FaceSetting(self._UI._Static_MainImage_2, char_Type)
  end
  self._UI._Static_MainImage_2:setRenderTexture(self._UI._Static_MainImage_2:getBaseTexture())
  self._UI._Static_MainImage_2:SetShow(true)
  self._UI._StaticText_Name_2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level .. " " .. char_Name)
  self._requestCharacterKey = characterData._characterNo_s64
end
function CharacterTag:LoadMainFace()
  local selfPlayer = getSelfPlayer()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  local selfCharIndex = ToClient_GetMyCharacterIndex()
  local isSetLeft = false
  local isSetRight = false
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPos = float3(selfPlayer:get():getPositionX(), selfPlayer:get():getPositionY(), selfPlayer:get():getPositionZ())
  self._UI._StaticText_TagAreaValue:SetText(getRegionInfoByPosition(selfPos):getAreaName())
  local characterCount = getCharacterDataCount() - 1
  self._UI._StaticText_TagState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_ALREADY_TAG"))
  if localDefine.NODUEL == duelCharIndex then
    self._selfCharTag = false
    for idx = 0, characterCount do
      local characterData = getCharacterDataByIndex(idx)
      local duelChar_No_s64 = characterData._duelCharacterNo
      local duelChar_No_s32 = Int64toInt32(duelChar_No_s64)
      if localDefine.NODUEL ~= duelChar_No_s32 then
        if false == isSetLeft then
          self:SetLeftFace(idx)
          isSetLeft = true
          self._UI._CheckButton_TagState:SetCheck(true)
        else
          self:SetRightFace(idx)
          isSetRight = true
          self._currentTagState = true
          self._UI._Static_QuestionIcon_2:SetShow(false)
        end
      end
    end
    if false == isSetLeft or false == isSetRight then
      isSetLeft = true
      self:SetLeftFace(selfCharIndex, false)
      self._UI._CheckButton_TagState:SetCheck(false)
      self._UI._Static_MainImage_2:ChangeTextureInfoName("")
      self._UI._StaticText_Name_2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_SETTING_TARGET"))
      self._selfCharTag = true
      self._currentTagState = false
      self._UI._Static_QuestionIcon_2:SetShow(true)
      self._UI._StaticText_TagState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANDO"))
    end
  else
    isSetLeft = true
    self:SetLeftFace(selfCharIndex)
    self:SetRightFace(duelCharIndex)
    self._currentTagState = true
    self._UI._CheckButton_TagState:SetCheck(true)
    self._selfCharTag = true
    self._UI._Static_QuestionIcon_2:SetShow(false)
  end
  if false == self._selfCharTag then
    self._UI._CheckButton_TagState:SetMonoTone(true)
    self._UI._CheckButton_TagState:SetIgnore(true)
  end
end
function CharacterTag:FaceSetting(targetImage, char_Type)
  if isNewCharacterInfo() == false then
    if char_Type == UI_Class.ClassType_Warrior then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Ranger then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Sorcerer then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Giant then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 202, 156, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Tamer then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 202, 312, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_BladeMaster then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 202, 468, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Valkyrie then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_BladeMasterWomen then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Wizard then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_WizardWomen then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 202, 156, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_NinjaWomen then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 202, 312, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_NinjaMan then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 202, 468, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_DarkElf then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_Combattant then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == UI_Class.ClassType_CombattantWomen then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    end
  else
    local DefaultFace = UI_DefaultFaceTexture[char_Type]
    targetImage:ChangeTextureInfoName(DefaultFace[1])
    local x1, y1, x2, y2 = setTextureUV_Func(targetImage, DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
    targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
  end
end
function HandleEvent_ClickCharacterList(charIndex)
  local self = CharacterTag
  local charMaxCount = getCharacterDataCount()
  if charIndex < 0 or charIndex > charMaxCount then
    return
  end
  self:SetRightFace(charIndex)
  self._UI._Static_QuestionIcon_2:SetShow(false)
  local characterData = getCharacterDataByIndex(charIndex)
  self._requestCharacterKey = characterData._characterNo_s64
end
function CharacterTag:LoadList()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isSetLeft = false
  local selfPlayerIndex = ToClient_GetMyCharacterIndex()
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPos = float3(selfPlayer:get():getPositionX(), selfPlayer:get():getPositionY(), selfPlayer:get():getPositionZ())
  local selfPlayerRegionInfoKey = getRegionInfoByPosition(selfPos):getRegionKey()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  local characterListMax = getCharacterDataCount()
  for jj = 0, 11 do
    self._UI._Static_CharacterList[jj]:SetShow(false)
  end
  for idx = 0, 11 do
    local ii = idx + self._pageIndex * 6
    if ii > characterListMax - 1 then
      return
    end
    local targetUI = self._UI._Static_CharacterList[idx]
    local targetLevel = UI.getChildControl(targetUI, "StaticText_Level")
    local targetImage = UI.getChildControl(targetUI, "Static_Image")
    local targetState = UI.getChildControl(targetUI, "StaticText_State")
    local characterData = getCharacterDataByIndex(ii)
    local char_Type = getCharacterClassType(characterData)
    local char_Level = string.format("%d", characterData._level)
    local char_Name = getCharacterName(characterData)
    local char_No_s64 = characterData._characterNo_s64
    local char_TextureName = getCharacterFaceTextureByIndex(ii)
    local pcDeliveryRegionKey = characterData._arrivalRegionKey
    local char_float3_position = characterData._currentPosition
    local duelChar_No_s64 = characterData._duelCharacterNo
    local duelRegion_Key = characterData._duelRegionKey
    local currentChar_Tag = false
    targetUI:SetShow(true)
    self:SetMonotoneIgnore(targetUI, targetImage, false)
    targetUI:SetPosX(32 + 108 * (idx % localDefine.CHARSLOTCOLMAX))
    targetUI:SetPosY(363 + math.floor(idx / localDefine.CHARSLOTCOLMAX) * 138)
    targetState:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
    targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANDO"))
    local isCaptureExist = targetImage:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, PaGlobal_getIsExitPhoto())
    if isCaptureExist == true then
      targetImage:getBaseTexture():setUV(0, 0, 1, 1)
    else
      self:FaceSetting(targetImage, char_Type)
    end
    targetImage:setRenderTexture(targetImage:getBaseTexture())
    targetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
    targetImage:addInputEvent("Mouse_LUp", "HandleEvent_ClickCharacterList(" .. tostring(ii) .. ")")
    targetImage:addInputEvent("Mouse_UpScroll", "PaGlobal_CharacterTag_ScrollEvent(true)")
    targetImage:addInputEvent("Mouse_DownScroll", "PaGlobal_CharacterTag_ScrollEvent(false)")
    local regionInfo = getRegionInfoByPosition(char_float3_position)
    local serverUtc64 = getServerUtc64()
    local workingText = global_workTypeToStringSwap(characterData._pcWorkingType)
    if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < characterData._arrivalTime then
      self:SetMonotoneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY"))
    elseif "" ~= workingText then
      targetState:SetText(workingText)
      self:SetMonotoneIgnore(targetUI, targetImage, true)
    elseif localDefine.NODUEL ~= Int64toInt32(duelChar_No_s64) then
      self:SetMonotoneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_ALREADY_TAG"))
    elseif selfPlayerRegionInfoKey ~= regionInfo:getRegionKey() or false == regionInfo:get():isMainOrMinorTown() then
      self:SetMonotoneIgnore(targetUI, targetImage, true)
      targetState:SetText(tostring(regionInfo:getAreaName()))
    end
    local removeTime = getCharacterDataRemoveTime(idx)
    if nil ~= removeTime then
      self:SetMonotoneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_DELETE"))
    end
    if ii == selfPlayerIndex then
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LASTONLINETIME"))
      self:SetMonotoneIgnore(targetUI, targetImage, true)
    end
    if true == self._currentTagState then
      self:SetMonotoneIgnore(targetUI, targetImage, true)
    end
  end
end
function CharacterTag:SetMonotoneIgnore(UIControl, ImageControl, value)
  UIControl:SetIgnore(value)
  ImageControl:SetMonoTone(value)
  ImageControl:SetIgnore(value)
end
function CharacterTag:Clear()
  self._UI._CheckButton_TagState:SetIgnore(false)
  self._UI._CheckButton_TagState:SetMonoTone(false)
  self._UI._Static_MainImage_2:SetShow(true)
  self._UI._Static_QuestionIcon_2:SetShow(true)
  self._UI._Static_MainImage_2:ChangeTextureInfoName("")
  self._UI._Static_MainImage_2:setRenderTexture(self._UI._Static_MainImage_2:getBaseTexture())
  self._requestCharacterKey = -1
  for ii = 0, 11 do
    self._UI._Static_CharacterList[ii]:SetShow(false)
  end
end
function CharacterTag:WindowPosition()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local panelSizeX = Panel_CharacterTag:GetSizeX()
  local panelSizeY = Panel_CharacterTag:GetSizeY()
  Panel_CharacterTag:SetPosX(screenSizeX / 2 - panelSizeX / 2)
  Panel_CharacterTag:SetPosY(math.max(0, (screenSizeY - panelSizeY) / 2))
end
function CharacterTag:Open()
  if false == isOpenCharacterTag then
    return
  end
  if -1 == ToClient_GetMyCharacterIndex() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  self:WindowPosition()
  self:Clear()
  self:LoadMainFace()
  self:LoadList()
  Panel_CharacterTag:SetShow(true, true)
end
function CharacterTag:Close()
  Panel_CharacterTag:CloseUISubApp()
  self._UI._CheckButton_PopUp:SetCheck(false)
  Panel_CharacterTag:SetShow(false, false)
end
function InitializeCharacterTag()
  CharacterTag:Initialize()
end
function FromClient_SuccessRequest()
  CharacterTag:Open()
end
function FromClient_SuccessDelete()
  CharacterTag._doTag = false
  CharacterTag:Open()
end
function PaGlobal_CharacterTag_Open()
  CharacterTag:Open()
end
function PaGlobal_CharacterTag_Close()
  CharacterTag:Close()
end
function PaGlobal_CharacterTag_ScrollEvent(isUp)
  local self = CharacterTag
  self._pageIndex = UIScroll.ScrollEvent(self._UI._Scroll_Tag, isUp, 2, math.ceil(self._maxCharacterCount / 6), self._pageIndex, 1)
  self:LoadList()
end
registerEvent("FromClient_luaLoadComplete", "InitializeCharacterTag")
registerEvent("FromClient_SuccessRequest", "FromClient_SuccessRequest")
registerEvent("FromClient_SuccessDelete", "FromClient_SuccessDelete")
function CharacterTag_PopUp_UI()
  local self = CharacterTag
  if self._UI._CheckButton_PopUp:IsCheck() then
    Panel_CharacterTag:OpenUISubApp()
  else
    Panel_CharacterTag:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function CharacterTag_PopUp_ShowIconToolTip(isShow)
  local self = CharacterTag
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if self._UI._CheckButton_PopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(self._UI._CheckButton_PopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function CharacterTag_WebHelper_ShowToolTip(isShow)
  local self = CharacterTag
  if isShow then
    local name = ""
    local desc = ""
    TooltipSimple_Show(self._UI._Button_Question, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function CharacterTag_WebHelper()
  Panel_WebHelper_ShowToggle("CharacterTag")
end
