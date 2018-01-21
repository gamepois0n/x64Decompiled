PaGlobal_MiniGame_Find = {
  _ui = {
    _baseOpenSlot = UI.getChildControl(Panel_MiniGame_Find, "Static_OpenSlot"),
    _baseCloseSlot = UI.getChildControl(Panel_MiniGame_Find, "Static_CloseSlot"),
    _closeButton = UI.getChildControl(Panel_MiniGame_Find, "Button_Win_Close"),
    _percent = UI.getChildControl(Panel_MiniGame_Find, "Static_Text_Percent_Value"),
    _btn_nextGame = UI.getChildControl(Panel_MiniGame_Find, "Button_NextGame"),
    _btn_giveMeReward = UI.getChildControl(Panel_MiniGame_Find, "Button_GiveMeReward"),
    _showSlotCount = UI.getChildControl(Panel_MiniGame_Find, "Static_Text_ShowSlotCount_Value"),
    _objTotalCount = UI.getChildControl(Panel_MiniGame_Find, "Static_Text_ObjTotalCount_Value"),
    _curObjTotalCount = UI.getChildControl(Panel_MiniGame_Find, "Static_Text_CurObjTotalCount_Value")
  },
  _config = {
    _slotCols = 16,
    _slotRows = 16,
    _slotStartPosX = 30,
    _slotStartPosY = 70,
    _slotGapX = 47,
    _slotGapY = 47
  },
  _slotType = {
    default = 0,
    empty = 1,
    obj = 2
  },
  _slots = Array.new()
}
function PaGlobal_MiniGame_Find:initialize()
  self:createSlot()
  self:registEventHandler()
  self._messageBoxData = {
    tostringitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = "\236\132\177\234\179\181! \235\139\164\236\157\140 \234\178\140\236\158\132\236\157\132 \236\167\132\237\150\137\237\149\152\235\169\180 \235\141\148 \236\162\139\236\157\128 \235\179\180\236\131\129\236\157\132 \235\176\155\236\157\132\236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164. \235\139\168, \236\139\164\237\140\168\236\139\156 \236\149\132\236\157\180\237\133\156 \236\149\136\236\164\140. \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140? \235\139\164\236\157\140\236\138\164\237\133\140\236\157\180\236\167\128 \236\139\164\237\140\168\236\139\156 \235\179\180\236\131\129 X",
    functionYes = FGlobal_MiniGameFind_Next,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  Panel_MiniGame_Find:SetShow(false)
end
function PaGlobal_MiniGame_Find:close()
  ToClient_MiniGameFindSetShow(false)
end
function PaGlobal_MiniGame_Find:createSlot()
  for col = 0, self._config._slotCols - 1 do
    self._slots[col] = Array.new()
    for row = 0, self._config._slotRows - 1 do
      local slot = {close = nil, open = nil}
      slot.close = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, Panel_MiniGame_Find, "Slot_Close_" .. col .. "_" .. row)
      slot.open = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC, Panel_MiniGame_Find, "Slot_Open_" .. col .. "_" .. row)
      CopyBaseProperty(self._ui._baseCloseSlot, slot.close)
      CopyBaseProperty(self._ui._baseOpenSlot, slot.open)
      slot.close:SetPosX(self._config._slotStartPosX + self._config._slotGapX * col)
      slot.close:SetPosY(self._config._slotStartPosY + self._config._slotGapY * row)
      slot.close:SetShow(true)
      slot.open:SetPosX(self._config._slotStartPosX + self._config._slotGapX * col)
      slot.open:SetPosY(self._config._slotStartPosY + self._config._slotGapY * row)
      slot.open:SetShow(false)
      slot.close:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_Find:LClickCloseSlot(" .. col .. ", " .. row .. ")")
      slot.close:addInputEvent("Mouse_RUp", "PaGlobal_MiniGame_Find:RClickCloseSlot(" .. col .. ", " .. row .. ")")
      self._slots[col][row] = slot
    end
  end
end
function PaGlobal_MiniGame_Find:registEventHandler()
  self._ui._closeButton:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_Find:close()")
  self._ui._btn_nextGame:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_Find:askNextGame()")
  self._ui._btn_giveMeReward:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_Find:close()")
  registerEvent("FromClient_MiniGameFindSlotShow", "FromClient_MiniGameFindSlotShow")
  registerEvent("FromClient_MiniGameFindSetShow", "FromClient_MiniGameFindSetShow")
  registerEvent("FromClient_MiniGameFindSetShowButtonList", "FromClient_MiniGameFindSetShowButtonList")
  registerEvent("FromClient_MiniGameFindDefaultImage", "FromClient_MiniGameFindDefaultImage")
  registerEvent("FromClient_MiniGameFindInformation", "FromClient_MiniGameFindInformation")
end
function PaGlobal_MiniGame_Find:LClickCloseSlot(col, row)
  _PA_LOG("\235\176\149\234\183\156\235\130\152_MiniGame_Find", "clickCloseSlot " .. tostring(col) .. ", " .. tostring(row))
  ToClient_MiniGameFindClick(col, row)
end
function PaGlobal_MiniGame_Find:RClickCloseSlot(col, row)
  local slot = self._slots[col][row].close
  slot:ChangeTextureInfoName("New_UI_Common_forLua/Window/MiniGame/MiniGame_00.dds")
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot, 62, 184, 122, 244)
  slot:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot:setRenderTexture(slot:getBaseTexture())
  slot:SetShow(true)
end
function PaGlobal_MiniGame_Find:endGame()
  for row = 0, self._config._slotRows - 1 do
    for col = 0, self._config._slotCols - 1 do
      local slot = self._slots[col][row]
      slot.close:SetEnable(false)
    end
  end
end
function PaGlobal_MiniGame_Find:refresh(slotMaxCol, slotMaxRow)
  for row = 0, self._config._slotRows - 1 do
    for col = 0, self._config._slotCols - 1 do
      local slot = self._slots[col][row]
      if slotMaxCol <= col or slotMaxRow <= row then
        slot.close:SetShow(false)
        slot.open:SetShow(false)
      else
        slot.close:SetShow(true)
        slot.close:SetEnable(true)
        slot.open:SetShow(false)
      end
    end
  end
end
function PaGlobal_MiniGame_Find:askNextGame()
  MessageBox.showMessageBox(self._messageBoxData, "top")
end
function FromClient_MiniGameFindInformation(damageRate, showSlotCount, objTotalCount, curObjTotalCount)
  local self = PaGlobal_MiniGame_Find
  self._ui._percent:SetText(string.format("%.2f", damageRate / 10000) .. "%")
  self._ui._showSlotCount:SetText(tostring(showSlotCount))
  self._ui._objTotalCount:SetText(tostring(objTotalCount))
  self._ui._curObjTotalCount:SetText(tostring(curObjTotalCount))
end
function FromClient_MiniGameFindDefaultImage(col, row, uv0, uv1, uv2, uv3, imagePath)
  local self = PaGlobal_MiniGame_Find
  local slot = self._slots[col][row].close
  slot:ChangeTextureInfoName(imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot, uv0, uv1, uv2, uv3)
  slot:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot:setRenderTexture(slot:getBaseTexture())
end
function FromClient_MiniGameFindSlotShow(col, row, uv0, uv1, uv2, uv3, _imagePath)
  local self = PaGlobal_MiniGame_Find
  local slot = self._slots[col][row].open
  slot:ChangeTextureInfoName(_imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot, uv0, uv1, uv2, uv3)
  slot:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot:setRenderTexture(slot:getBaseTexture())
  self._slots[col][row].close:SetShow(false)
  self._slots[col][row].open:SetShow(true)
end
function FromClient_MiniGameFindSetShow(isShow, col, row)
  local self = PaGlobal_MiniGame_Find
  if true == isShow then
    self._ui._percent:SetText(string.format("%.2f", 0) .. "%")
    self._ui._btn_nextGame:SetShow(false)
    self._ui._btn_giveMeReward:SetShow(false)
    self:refresh(col, row)
  end
  Panel_MiniGame_Find:SetShow(isShow)
end
function FromClient_MiniGameFindSetShowButtonList(isNextGame, isGiveMeReward)
  local self = PaGlobal_MiniGame_Find
  self._ui._btn_nextGame:SetShow(isNextGame)
  self._ui._btn_giveMeReward:SetShow(isGiveMeReward)
  if true == isNextGame or true == isGiveMeReward then
    self:endGame()
  end
end
function FGlobal_MiniGameFind_Next()
  ToClient_MiniGameFindSetShow(true)
end
PaGlobal_MiniGame_Find:initialize()
function minigamefind()
  _PA_LOG("\235\176\149\234\183\156\235\130\152_MiniGame_Find", "minigamefind ")
  ToClient_MiniGameFindSetShow(true)
end
