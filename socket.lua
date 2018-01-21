local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local IM = CppEnums.EProcessorInputMode
local UI_color = Defines.Color
Panel_Window_Socket:SetShow(false, false)
Panel_Window_Socket:setMaskingChild(true)
Panel_Window_Socket:setGlassBackground(true)
Panel_Window_Socket:SetDragEnable(true)
Panel_Window_Socket:SetDragAll(true)
Panel_Window_Socket:RegisterShowEventFunc(true, "SocketShowAni()")
Panel_Window_Socket:RegisterShowEventFunc(false, "SocketHideAni()")
local socket = {
  slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  config = {socketSlotCount = 3, curSlotCount = 3},
  control = {
    staticEnchantItem = UI.getChildControl(Panel_Window_Socket, "Static_Equip_Socket"),
    staticSocket = {
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_1"),
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_2"),
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_3")
    },
    staticSocketName = {
      UI.getChildControl(Panel_Window_Socket, "StaticText_NameTag_1"),
      UI.getChildControl(Panel_Window_Socket, "StaticText_NameTag_2"),
      UI.getChildControl(Panel_Window_Socket, "StaticText_NameTag_3")
    },
    staticSocketDesc = {
      UI.getChildControl(Panel_Window_Socket, "StaticText_List_1"),
      UI.getChildControl(Panel_Window_Socket, "StaticText_List_2"),
      UI.getChildControl(Panel_Window_Socket, "StaticText_List_3")
    },
    staticSocketBackground = {
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_1_Background"),
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_2_Background"),
      UI.getChildControl(Panel_Window_Socket, "Static_Socket_3_Background")
    }
  },
  text = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT")
  },
  desc = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT_DESC")
  },
  slotMain = nil,
  slotSocket = Array.new(),
  _indexSocket = nil,
  _jewelInvenSlotNo = nil,
  _posX = 0,
  _posY = 0
}
local commentBG = UI.getChildControl(Panel_Window_Socket, "Static_CommentBG")
local isItemLock = false
local _buttonQuestion = UI.getChildControl(Panel_Window_Socket, "Button_Question")
_buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Socket\" )")
_buttonQuestion:addInputEvent("Mouse_On", "HelpMessageQuestion_Show( \"Socket\", \"true\")")
_buttonQuestion:addInputEvent("Mouse_Out", "HelpMessageQuestion_Show( \"Socket\", \"false\")")
local onlySocketListBG = {
  [1] = UI.getChildControl(Panel_Window_Socket, "Static_SocketBG_0"),
  [2] = UI.getChildControl(Panel_Window_Socket, "Static_SocketBG_1"),
  [3] = UI.getChildControl(Panel_Window_Socket, "Static_SocketBG_2")
}
socket._posX = Panel_Window_Socket:GetPosX()
socket._posY = Panel_Window_Socket:GetPosY()
function socket:init()
  for _, control in ipairs(self.control.staticSocketName) do
    control:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  end
  for _, control in ipairs(self.control.staticSocketDesc) do
    control:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  end
  Panel_Window_Socket:SetEnableArea(0, 0, 500, 25)
  commentBG:SetSize(commentBG:GetSizeX(), commentBG:GetTextSizeY() + 5)
end
function socket:createControl()
  local slotMain = {}
  slotMain.icon = self.control.staticEnchantItem
  SlotItem.new(slotMain, "Equip_Socket", 0, Panel_Window_Socket, self.slotConfig)
  slotMain:createChild()
  slotMain.icon:addInputEvent("Mouse_RUp", "Socket_EquipSlotRClick()")
  slotMain.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(0, \"Socket\", true)")
  slotMain.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(0, \"Socket\", false)")
  Panel_Tooltip_Item_SetPosition(0, slotMain, "Socket")
  slotMain.empty = true
  self.slotMain = slotMain
  self.slotMain.whereType = nil
  self.slotMain.slotNo = nil
  for ii = 1, self.config.socketSlotCount do
    slotSocket = {
      icon = self.control.staticSocket[ii],
      iconBg = self.control.staticSocketBackground[ii],
      name = self.control.staticSocketName[ii],
      desc = self.control.staticSocketDesc[ii]
    }
    function slotSocket:setShow(bShow)
      self.icon:SetShow(bShow)
      self.iconBg:SetShow(bShow)
      self.name:SetShow(bShow)
      self.desc:SetShow(bShow)
    end
    onlySocketListBG[ii]:SetShow(true)
    local indexSocket = ii - 1
    SlotItem.new(slotSocket, "Socket_" .. ii, ii, Panel_Window_Socket, self.slotConfig)
    slotSocket:createChild()
    slotSocket.icon:addInputEvent("Mouse_RUp", "Socket_SlotRClick(" .. indexSocket .. ")")
    slotSocket.icon:addInputEvent("Mouse_LUp", "Socket_SlotLClick(" .. indexSocket .. ")")
    slotSocket.icon:addInputEvent("Mouse_PressMove", "Socket_SlotDrag(" .. indexSocket .. ")")
    slotSocket.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. ii .. ", \"Socket_Insert\", true)")
    slotSocket.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. ii .. ", \"Socket_Insert\", false)")
    Panel_Tooltip_Item_SetPosition(ii, slotSocket, "Socket_Insert")
    slotSocket.empty = true
    self.slotSocket:push_back(slotSocket)
  end
end
function socket:clearData(uiOnly)
  self.slotMain:clearItem()
  self.slotMain.empty = true
  self.slotMain.whereType = nil
  self.slotMain.slotNo = nil
  self.slotMain.icon:SetShow(false)
  for ii = 1, self.config.socketSlotCount do
    local socketBG_1 = onlySocketListBG[ii]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    socketBG_1:SetStartColor(UI_color.C_FFFFFFFF)
    socketBG_1:SetEndColor(UI_color.C_FF626262)
    onlySocketListBG[ii]:EraseAllEffect()
    self.slotSocket[ii]:setShow(false)
    self.slotSocket[ii].empty = true
  end
  if not uiOnly then
    getSocketInformation():clearData()
  end
  Panel_Tooltip_Item_hideTooltip()
end
function socket:registEventHandler()
end
function socket:updateSocket()
  if self.slotMain.empty then
    UI.ASSERT(false, "Must not be EMPTY!!!!")
    return
  end
  local invenItemWrapper = getInventoryItemByType(self.slotMain.whereType, self.slotMain.slotNo)
  local maxCount = invenItemWrapper:get():getUsableItemSocketCount()
  local classType = getSelfPlayer():getClassType()
  for ii = 1, maxCount do
    local socketSlot = self.slotSocket[ii]
    local itemStaticWrapper = invenItemWrapper:getPushedItem(ii - 1)
    socketSlot:setShow(true)
    onlySocketListBG[ii]:EraseAllEffect()
    if nil == itemStaticWrapper then
      if ii == 1 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        onlySocketListBG[2]:SetColor(UI_color.C_FF626262)
        onlySocketListBG[3]:SetColor(UI_color.C_FF626262)
      elseif ii == 2 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_2 = onlySocketListBG[2]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_2:SetStartColor(UI_color.C_FF626262)
        socketBG_2:SetEndColor(UI_color.C_FFFFFFFF)
        onlySocketListBG[3]:SetColor(UI_color.C_FF626262)
      elseif ii == 3 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_2 = onlySocketListBG[2]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_2:SetStartColor(UI_color.C_FF626262)
        socketBG_2:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_3 = onlySocketListBG[3]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_3:SetStartColor(UI_color.C_FF626262)
        socketBG_3:SetEndColor(UI_color.C_FFFFFFFF)
      end
      socketSlot:clearItem()
      socketSlot.empty = true
      socketSlot.name:SetText(self.text[1])
      socketSlot.desc:SetText(self.desc[1])
      self.slotMain.icon:AddEffect("UI_ItemJewel", false, 0, 0)
    else
      if ii == 1 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        onlySocketListBG[2]:SetColor(UI_color.C_FF626262)
        onlySocketListBG[3]:SetColor(UI_color.C_FF626262)
        audioPostEvent_SystemUi(5, 6)
        onlySocketListBG[1]:AddEffect("UI_LimitMetastasis_TopLoop", true, -222, 40)
      elseif ii == 2 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_2 = onlySocketListBG[2]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_2:SetStartColor(UI_color.C_FF626262)
        socketBG_2:SetEndColor(UI_color.C_FFFFFFFF)
        onlySocketListBG[3]:SetColor(UI_color.C_FF626262)
        audioPostEvent_SystemUi(5, 6)
        onlySocketListBG[2]:AddEffect("UI_LimitMetastasis_MidLoop", true, -217, 0)
      elseif ii == 3 then
        local socketBG_1 = onlySocketListBG[1]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_1:SetStartColor(UI_color.C_FF626262)
        socketBG_1:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_2 = onlySocketListBG[2]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_2:SetStartColor(UI_color.C_FF626262)
        socketBG_2:SetEndColor(UI_color.C_FFFFFFFF)
        local socketBG_3 = onlySocketListBG[3]:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        socketBG_3:SetStartColor(UI_color.C_FF626262)
        socketBG_3:SetEndColor(UI_color.C_FFFFFFFF)
        audioPostEvent_SystemUi(5, 6)
        onlySocketListBG[3]:AddEffect("UI_LimitMetastasis_BotLoop", true, -212, -30)
      end
      socketSlot:setItemByStaticStatus(itemStaticWrapper, 0)
      socketSlot.empty = false
      local text = itemStaticWrapper:getName()
      local desc = ""
      socketSlot.name:SetText(text)
      local jewelSkillStaticWrapper = itemStaticWrapper:getSkillByIdx(classType)
      if nil ~= jewelSkillStaticWrapper then
        for buffIdx = 0, jewelSkillStaticWrapper:getBuffCount() - 1 do
          local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
          if nil == descCurrent or "" == descCurrent then
            break
          end
          if desc == "" then
            desc = descCurrent
          else
            desc = desc .. "\n" .. descCurrent
          end
        end
      end
      socketSlot.desc:SetText(desc)
    end
  end
  for ii = maxCount + 1, self.config.socketSlotCount do
    local socketSlot = self.slotSocket[ii]
    socketSlot:setShow(false)
  end
end
local function Socket_Pop_Confirm()
  Socket_PopJewelFromSocket(socket._indexSocket, CppEnums.ItemWhereType.eCount, CppEnums.TInventorySlotNoUndefined)
end
local function Socket_Push_Confirm()
  local self = socket
  local socketInfo = getSocketInformation()
  local index = socketInfo._indexPush
  local socketSlot = self.slotSocket[index + 1]
  if false == isItemLock then
    socketSlot.iconBg:AddEffect("UI_ItemJewel02", false, 0, 0)
    socketSlot.desc:AddEffect("UI_ItemJewel03", false, 0, 0)
    socketSlot.iconBg:AddEffect("fUI_ItemJewel01", false, -1, -1)
    self.slotMain.icon:AddEffect("fUI_ItemJewel01", false, -1, -1)
    self.slotMain.icon:AddEffect("UI_LimitMetastasis_Box01", false, -1, -1)
    socketSlot.icon:AddEffect("UI_LimitMetastasis_Box02", false, -1, -1)
  end
  Socket_ConfirmPushJewel(true)
  if false == isItemLock then
    if index == 0 then
      audioPostEvent_SystemUi(0, 7)
      self.slotMain.icon:AddEffect("UI_LimitMetastasis_Top01", false, -1, -1)
    elseif index == 1 then
      audioPostEvent_SystemUi(0, 7)
      self.slotMain.icon:AddEffect("UI_LimitMetastasis_Mid01", false, -1, -1)
    elseif index == 2 then
      audioPostEvent_SystemUi(0, 7)
      self.slotMain.icon:AddEffect("UI_LimitMetastasis_Bot01", false, -1, -1)
    end
  end
end
local function Socket_OverWrite_Confirm()
  local self = socket
  local rv = Socket_OverWriteToSocket(self.slotMain.whereType, self.slotMain.slot, self._indexSocket)
  if 0 ~= rv then
    self:clearData()
    Inventory_SetFunctor(Socket_InvenFiler_EquipItem, Panel_Socket_InteractortionFromInventory, Socket_WindowClose, nil)
  end
end
local Socket_Deny = function()
  Socket_ConfirmPushJewel(false)
end
local Socket_InvenFiler_EquipItem = function(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():doHaveSocket() then
    if 22 == itemSSW:getEquipType() and false == itemWrapper:get():isVested() then
      return true
    else
      return false
    end
  end
  return true
end
local Socket_InvenFiler_Jewel = function(slotNo, itemWrapper, whereType)
  if nil == itemWrapper then
    return true
  end
  if CppEnums.ItemWhereType.eCashInventory == whereType then
    return true
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  local isAble = getSocketInformation():isFilterJewelEquipType(whereType, slotNo)
  return not isAble
end
function SocketItem_FromItemWrapper()
  local self = socket
  if nil == self.slotMain.slotNo then
    return nil
  end
  return (getInventoryItemByType(self.slotMain.whereType, self.slotMain.slotNo))
end
function Socket_SlotRClick(indexSocket)
  local self = socket
  if true == self.slotSocket[indexSocket + 1].empty then
    return
  end
  socket._indexSocket = indexSocket
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_MESSAGE", "socketNum", string.format("%d", indexSocket + 1))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = Socket_Pop_Confirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function Socket_EquipSlotRClick()
  getSocketInformation():popEquip()
  socket:clearData()
  Inventory_SetFunctor(Socket_InvenFiler_EquipItem, Panel_Socket_InteractortionFromInventory, Socket_WindowClose, nil)
end
function Socket_SlotLClick(indexSocket)
  if DragManager.dragStartPanel ~= Panel_Window_Inventory then
    return
  end
  local self = socket
  local whereType = DragManager.dragWhereTypeInfo
  local slotNo = DragManager.dragSlotInfo
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    UI.ASSERT(false, "Item Is Null?!?!?!")
    return
  end
  local index = indexSocket + 1
  if true == self.slotSocket[index].empty then
    local success = 0 == Socket_SetItemHaveSocket(whereType, slotNo)
    if not success then
      return
    end
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_TITLE")
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_MESSAGE", "socketNum", string.format("%d", index), "itemName", itemWrapper:getStaticStatus():getName())
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = Socket_Push_Confirm,
      functionCancel = Socket_Deny,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  else
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_ALREADYCRYSTAL")
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  DragManager.clearInfo()
end
function Panel_Socket_InteractortionFromInventory(slotNo, itemWrapper, count_s64, inventoryType)
  local self = socket
  local socketInfo = getSocketInformation()
  local success = 0 == Socket_SetItemHaveSocket(inventoryType, slotNo)
  if not success then
    self:clearData()
    Inventory_SetFunctor(Socket_InvenFiler_EquipItem, Panel_Socket_InteractortionFromInventory, Socket_WindowClose, nil)
    return
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  UI.ASSERT(nil ~= itemWrapper, "Item Is Null?!?!?!")
  if socketInfo._setEquipItem then
    self.slotMain.empty = false
    self.slotMain.whereType = inventoryType
    self.slotMain.slotNo = slotNo
    self.slotMain:setItem(itemWrapper)
    self.slotMain.icon:SetShow(true)
    self.slotMain.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", 'SocketItem', true)")
    self.slotMain.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", 'SocketItem', false)")
    Panel_Tooltip_Item_SetPosition(slotNo, self.slotMain, "SocketItem")
    self:updateSocket()
    Inventory_SetFunctor(Socket_InvenFiler_Jewel, Panel_Socket_InteractortionFromInventory, Socket_WindowClose, nil)
  else
    local rv = socketInfo:checkPushJewelToEmptySoket(inventoryType, slotNo)
    isItemLock = ToClient_Inventory_CheckItemLock(self.slotMain.slotNo)
    if 0 == rv then
      local index = socketInfo._indexPush
      local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_TITLE")
      local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_MESSAGE", "socketNum", string.format("%d", index + 1), "itemName", itemWrapper:getStaticStatus():getName())
      local messageboxData = {
        title = titleString,
        content = contentString,
        functionYes = Socket_Push_Confirm,
        functionCancel = Socket_Deny,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  end
end
function Socket_Result()
  if Panel_Window_Socket:GetShow() then
    socket:updateSocket()
  else
    PaGlobal_ExtractionCrystal:result()
  end
end
local function Socket_fadeInSCR_Down(panel)
  local FadeMaskAni = panel:addTextureUVAnimation(0, 0.28, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  FadeMaskAni:SetTextureType(UI_TT.PAUI_TEXTURE_TYPE_MASK)
  FadeMaskAni:SetStartUV(0, 0.6, 0)
  FadeMaskAni:SetEndUV(0, 0.1, 0)
  FadeMaskAni:SetStartUV(1, 0.6, 1)
  FadeMaskAni:SetEndUV(1, 0.1, 1)
  FadeMaskAni:SetStartUV(0, 1, 2)
  FadeMaskAni:SetEndUV(0, 0.4, 2)
  FadeMaskAni:SetStartUV(1, 1, 3)
  FadeMaskAni:SetEndUV(0, 0.4, 3)
  panel:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo3 = panel:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  for key, value in pairs(onlySocketListBG) do
    local socketBG_1 = value:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    socketBG_1:SetStartColor(UI_color.C_00626262)
    socketBG_1:SetEndColor(UI_color.C_FF626262)
  end
  local aniInfo8 = panel:addColorAnimation(0.12, 0.23, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo8:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(3)
  aniInfo8:SetEndIntensity(1)
end
function SocketShowAni()
  local aniInfo1 = Panel_Window_Socket:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.13)
  aniInfo1.AxisX = Panel_Window_Socket:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Socket:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Socket:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.13)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Socket:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Socket:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  audioPostEvent_SystemUi(1, 0)
end
function SocketHideAni()
  local socketHide = UIAni.AlphaAnimation(0, Panel_Window_Socket, 0, 0.2)
  socketHide:SetHideAtEnd(true)
  audioPostEvent_SystemUi(1, 1)
end
function Socket_WindowClose()
  Inventory_SetFunctor(nil, nil, nil, nil)
  Panel_Window_Socket:SetShow(false, false)
  InventoryWindow_Close()
  Equipment_PosLoadMemory()
  Panel_Equipment:SetShow(false, false)
  ToClient_BlackspiritEnchantClose()
end
function Socket_Window_Show()
  if Panel_Window_Enchant:GetShow() then
    Panel_Window_Enchant:SetShow(false, false)
  elseif Panel_SkillAwaken:GetShow() then
    Panel_SkillAwaken:SetShow(false, false)
  end
  Panel_Window_Socket:SetShow(true, true)
  Inventory_SetFunctor(Socket_InvenFiler_EquipItem, Panel_Socket_InteractortionFromInventory, Socket_WindowClose, nil)
  socket:clearData()
  InventoryWindow_Show()
  Equipment_PosSaveMemory()
  Panel_Equipment:SetShow(true, true)
  Panel_Equipment:SetPosX(10)
  Panel_Equipment:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Equipment:GetSizeY() / 2)
  SkillAwaken_Close()
  Panel_Join_Close()
  FGlobal_LifeRanking_Close()
  Panel_Window_Socket:SetPosX(socket._posX)
  Panel_Window_Socket:SetPosY(socket._posY)
end
function Socket_ShowToggle()
  if Panel_Window_Socket:GetShow() then
    Socket_WindowClose()
  else
    Socket_Window_Show()
    InventoryWindow_Show()
  end
end
function Socket_OnScreenEvent()
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_Window_Socket:SetPosX(sizeX / 2 - Panel_Window_Socket:GetSizeX() / 2)
  Panel_Window_Socket:SetPosY(sizeY / 3.5)
  Panel_Window_Socket:ComputePos()
end
function socket:registMessageHandler()
  registerEvent("EventSocketResult", "Socket_Result")
  registerEvent("onScreenResize", "Socket_OnScreenEvent")
end
function Socket_GetSlotNo()
  return socket.slotMain.slotNo
end
socket:init()
socket:createControl()
socket:registEventHandler()
socket:registMessageHandler()
