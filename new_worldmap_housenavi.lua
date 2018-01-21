local IM = CppEnums.EProcessorInputMode
local filterBG = UI.getChildControl(Panel_NodeMenu, "Filter_Bg")
local _myHosueCombo = UI.getChildControl(Panel_NodeMenu, "Combobox_Filter_Own")
local _typeCombo = UI.getChildControl(Panel_NodeMenu, "Combobox_Filter_Type")
local _levelCombo = UI.getChildControl(Panel_NodeMenu, "Combobox_Filter_Lev")
local _edit_Search = UI.getChildControl(Panel_NodeMenu, "Filter_Edit_Type")
local _btn_Search = UI.getChildControl(Panel_NodeMenu, "Filter_Button_TypeSearch")
local _myhouseList = _myHosueCombo:GetListControl()
local _typeList = _typeCombo:GetListControl()
local _levelList = _levelCombo:GetListControl()
local _typeListScroll = _typeList:GetScroll()
local _beforeReceipeIndex = 0
local _houseMaxLevel = 5
local _itemSize = 0
local defaultKeyWord = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_HOUSENAVI_DEFAULTKEYWORD")
Panel_NodeHouseFilter:RegisterShowEventFunc(true, "FGlobal_HouseFilter_ShowAni()")
Panel_NodeHouseFilter:RegisterShowEventFunc(false, "FGlobal_HouseFilter_HideAni()")
Panel_NodeHouseFilter:SetShow(false, false)
function FGlobal_HouseFilter_ShowAni()
end
function FGlobal_HouseFilter_HideAni()
end
local function Worldmap_HouseNavi_Init()
  filterBG:AddChild(_edit_Search)
  filterBG:AddChild(_btn_Search)
  filterBG:AddChild(_myHosueCombo)
  filterBG:AddChild(_typeCombo)
  filterBG:AddChild(_levelCombo)
  Panel_NodeMenu:RemoveControl(_edit_Search)
  Panel_NodeMenu:RemoveControl(_btn_Search)
  Panel_NodeMenu:RemoveControl(_myHosueCombo)
  Panel_NodeMenu:RemoveControl(_typeCombo)
  Panel_NodeMenu:RemoveControl(_levelCombo)
  _myHosueCombo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERFIILTER"))
  _myhouseList:SetItemQuantity(3)
  _myHosueCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERRFILTER_ALL"))
  _myHosueCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERFIILTER_MINE"))
  _myHosueCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERFIILTER_MINE_AT"))
  _myHosueCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERFILTER_OTHER"))
  _itemSize = _myhouseList:GetItemHeight()
  _myhouseList:SetSize(_myhouseList:GetSizeX(), 3 * _itemSize)
  _typeCombo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_USETYPEFILTER"))
  _typeList:SetItemQuantity(5)
  _levelCombo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER"))
  _levelList:SetItemQuantity(_houseMaxLevel)
  for i = 1, _houseMaxLevel do
    _levelCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER") .. " " .. i)
  end
  _myHosueCombo:addInputEvent("Mouse_LUp", "ToggleCombo(" .. 0 .. ")")
  _typeCombo:addInputEvent("Mouse_LUp", "ToggleCombo(" .. 1 .. ")")
  _levelCombo:addInputEvent("Mouse_LUp", "ToggleCombo(" .. 2 .. ")")
  _myhouseList:addInputEvent("Mouse_LUp", "FGlobal_SelectedFilter()")
  _typeList:addInputEvent("Mouse_LUp", "FGlobal_SelectedFilter()")
  _levelList:addInputEvent("Mouse_LUp", "FGlobal_SelectedFilter()")
  _edit_Search:addInputEvent("Mouse_LUp", "HandleClicked_HouseNaviEditSearch()")
  _btn_Search:addInputEvent("Mouse_LUp", "HandleClicked_HouseNaviSearch()")
  _edit_Search:RegistReturnKeyEvent("HandleClicked_HouseNaviSearch()")
end
function ToggleCombo(index)
  if 0 == index then
    _myHosueCombo:ToggleListbox()
  elseif 1 == index then
    _typeCombo:ToggleListbox()
  elseif 2 == index then
    _levelCombo:ToggleListbox()
  end
  _edit_Search:SetEditText(defaultKeyWord, true)
end
function FGlobal_FilterReset()
  ToCleint_findHouseByFilter(CppEnums.HouseOwnerFilter.HOUSE_OWNER_ALL, -1, 1)
  _myHosueCombo:SetSelectItemIndex(0)
  _typeCombo:SetSelectItemIndex(0)
  _levelCombo:SetSelectItemIndex(0)
  _edit_Search:SetEditText(defaultKeyWord, true)
end
function FGlobal_SelectedFilter()
  local ownerIndex = _myHosueCombo:GetSelectIndex()
  local receipeIndex = _typeCombo:GetSelectIndex()
  local receipeKey = ToClient_getReceipeTypeByIndex(receipeIndex - 1)
  local levelIndex = _levelCombo:GetSelectIndex()
  _myHosueCombo:SetSelectItemIndex(ownerIndex)
  _typeCombo:SetSelectItemIndex(receipeIndex)
  _levelCombo:SetSelectItemIndex(levelIndex)
  FGlobal_FilterEffectClear()
  ToCleint_findHouseByFilter(ownerIndex, receipeKey, levelIndex + 1)
end
function FromClient_WorldMap_HouseNaviShow(isShow)
  FGlobal_FilterReset()
  FGlobal_FilterReceiPeOn()
end
function FGlobal_FilterReceiPeOn()
  local count = ToClient_getTownReceipeList()
  _typeCombo:DeleteAllItem()
  local quantity = 0
  if count > 10 then
    quantity = 10
  else
    quantity = count
  end
  _typeList:SetSize(_typeList:GetSizeX(), quantity * _itemSize)
  _typeList:SetItemQuantity(quantity)
  _typeCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_OWNERRFILTER_ALL"))
  for idx = 0, count - 1 do
    _typeCombo:AddItem(ToClient_getReceipeName(ToClient_getReceipeTypeByIndex(idx)))
  end
  _typeCombo:SetSelectItemIndex(0)
  _typeListScroll:SetControlPos(0)
end
function FGlobal_FilterLevelOn()
  local receipeIndex = _typeCombo:GetSelectIndex()
  if receipeIndex <= 0 then
    return
  end
  local maxLevel = ToClient_getReceipeMaxLevelByIndex(receipeIndex)
  _levelCombo:DeleteAllItem()
  for i = 1, maxLevel do
    _levelCombo:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER") .. " " .. i)
  end
end
function FGlobal_HouseNavi_Close()
  ClearFocusEdit()
end
function HandleClicked_HouseNaviEditSearch()
  _edit_Search:SetEditText("", true)
  SetUIMode(Defines.UIMode.eUIMode_WoldMapSearch)
end
function HandleClicked_HouseNaviSearch()
  FGlobal_FilterEffectClear()
  _myHosueCombo:SetSelectItemIndex(0)
  _typeCombo:SetSelectItemIndex(0)
  _levelCombo:SetSelectItemIndex(0)
  local searchKeyword = _edit_Search:GetEditText()
  ToClient_findHouseByItemNameInTown(searchKeyword)
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
end
function WorldMap_HouseNavi_Resize()
  filterBG:ComputePos()
end
Worldmap_HouseNavi_Init()
registerEvent("FromClient_SetTownMode", "FromClient_WorldMap_HouseNaviShow")
registerEvent("onScreenResize", "WorldMap_HouseNavi_Resize")
