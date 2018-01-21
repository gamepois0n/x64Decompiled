Panel_Loading:SetShow(true, false)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_TM = CppEnums.TextMode
local _currentTime = 10000
local _isStartLoading = false
local screenX, screenY
local _bg1 = UI.getChildControl(Panel_Loading, "Static_BG_1")
local _bg2 = UI.getChildControl(Panel_Loading, "Static_BG_2")
local _regionName = UI.getChildControl(Panel_Loading, "StaticText_RegionName")
local _knowledge_Image = UI.getChildControl(Panel_Loading, "Static_knowImage")
local _knowledge_title = UI.getChildControl(Panel_Loading, "StaticText_knowTitle")
local _knowledge_desc = UI.getChildControl(Panel_Loading, "StaticText_knowDesc")
local progressRate = UI.getChildControl(Panel_Loading, "Progress2_Loading")
local progressHead = UI.getChildControl(progressRate, "Progress2_Bar_Head")
local staticBack = UI.getChildControl(Panel_Loading, "Static_Progress_Back")
local goblinRun = UI.getChildControl(Panel_Loading, "Static_GoblinRun")
local backGroundEvnetImage = UI.getChildControl(Panel_Loading, "Static_BackImage")
local isBgOpen = false
local bgImageTexture = {}
local iskamasilviaOpen = ToClient_IsContentsGroupOpen("5")
if isBgOpen then
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/User_01.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/User_02.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/User_03.dds",
    ["count"] = 3
  }
end
if isGameTypeJapan() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/event_13.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/event_14.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/event_15.dds",
    ["count"] = 3
  }
end
if isGameTypeRussia() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/event_16.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/event_17.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/event_18.dds",
    ["count"] = 3
  }
end
if isGameTypeEnglish() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
    [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
    ["count"] = 4
  }
end
if isGameTypeJapan() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
    [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
    ["count"] = 4
  }
end
if isGameTypeTaiwan() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
    [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
    ["count"] = 4
  }
end
if isGameTypeSA() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
    [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
    [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
    [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
    ["count"] = 4
  }
end
if isGameTypeKR2() then
  isBgOpen = false
  bgImageTexture = {}
  bgImageTexture = {
    [0] = "New_UI_Common_ForLua/Window/Loading/bgKR2Only_1.dds",
    ["count"] = 1
  }
end
local UI_color = Defines.Color
progressRate:SetCurrentProgressRate(0)
_knowLedge_TitleSizeX = 0
function LoadingPanel_Resize()
  screenX = getScreenSizeX()
  screenY = getScreenSizeY()
  Panel_Loading:SetSize(screenX, screenY)
  _bg1:SetSize(screenX, screenY)
  _bg1:ComputePos()
  _bg2:SetSize(screenX, screenY)
  _bg2:SetSize(1, 1)
  _bg2:ComputePos()
  progressRate:SetSize(screenX * 0.8, progressRate:GetSizeY())
  progressRate:ComputePos()
  staticBack:SetSize(screenX * 0.8, staticBack:GetSizeY())
  staticBack:ComputePos()
  backGroundEvnetImage:SetSize(screenX, screenY)
  backGroundEvnetImage:SetShow(isBgOpen)
end
local addXpos = 0
function LoadingPanel_Init()
  progressRate:SetCurrentProgressRate(0)
  local progressRateX = progressRate:GetPosX()
  local progressRateY = progressRate:GetPosY()
  local progressHeadX = progressHead:GetPosX()
  local progressHeadY = progressHead:GetPosY()
  local isXmas = ToClient_isEventOn("x-mas")
  local isHalloween = ToClient_isEventOn("Halloween")
  local isEaster = ToClient_isEventOn("Easter")
  if isXmas then
    goblinRun:ChangeTextureInfoName("New_UI_Common_ForLua/Default/goblrun2.dds")
  elseif isEaster then
    goblinRun:ChangeTextureInfoName("New_UI_Common_ForLua/Default/EN_easter.dds")
  elseif isHalloween then
    goblinRun:ChangeTextureInfoName("new_ui_common_forlua/default/goblrun3.dds")
    progressHead:ChangeTextureInfoName("new_ui_common_forlua/default/obsidian_child2.dds")
    addXpos = 10
  else
    goblinRun:ChangeTextureInfoName("new_ui_common_forlua/default/goblrun.dds")
    progressHead:ChangeTextureInfoName("new_ui_common_forlua/default/obsidian_child.dds")
  end
  goblinRun:SetPosX(progressRateX + progressHeadX + progressHead:GetSizeX() + addXpos)
  goblinRun:SetPosY(progressRateY + progressHeadY + 25)
end
function LoadingPanel_SetProgress(rate)
  progressRate:SetProgressRate(rate)
  local progressRateX = progressRate:GetPosX()
  local progressRateY = progressRate:GetPosY()
  local progressHeadX = progressHead:GetPosX()
  local progressHeadY = progressHead:GetPosY()
  local isHalloween = ToClient_isEventOn("Halloween")
  local addXpos2 = 0
  if isHalloween then
    addXpos2 = 10
  else
    addXpos2 = 0
  end
  goblinRun:SetPosX(progressRateX + progressHeadX + progressHead:GetSizeX() + addXpos2)
  goblinRun:SetPosY(progressRateY + progressHeadY + 25)
end
function LoadingPanel_SetRegionName()
  local cameraPosition = getWorldMapCameraLookAt()
  _regionName:SetText(getRegionNameByPosition(cameraPosition))
end
local function LoadingPanel_PlayKnowledgeAni()
  _bg1:SetShow(true)
  _bg2:SetShow(true)
  local ImageMoveAni = _knowledge_Image:addMoveAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(screenX / 2 - 200, screenY / 2 - 350)
  ImageMoveAni:SetEndPosition(screenX / 2 - 200, screenY / 2 - 400)
  ImageMoveAni.IsChangeChild = true
  _knowledge_Image:CalcUIAniPos(ImageMoveAni)
  local knowTitleMoveAni = _knowledge_title:addMoveAnimation(0, 1.65, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleMoveAni:SetStartPosition(screenX / 2 - _knowLedge_TitleSizeX / 2, screenY / 2 - 50)
  knowTitleMoveAni:SetEndPosition(screenX / 2 - _knowLedge_TitleSizeX / 2, screenY / 2 + 20)
  knowTitleMoveAni.IsChangeChild = true
  _knowledge_title:CalcUIAniPos(knowTitleMoveAni)
  local knowDescMoveAni = _knowledge_desc:addMoveAnimation(0, 1.75, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescMoveAni:SetStartPosition(screenX / 2 - 300, screenY / 2 - 25)
  knowDescMoveAni:SetEndPosition(screenX / 2 - 300, screenY / 2 + 50)
  knowDescMoveAni.IsChangeChild = true
  _knowledge_desc:CalcUIAniPos(knowDescMoveAni)
  local ImageAni = _knowledge_Image:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_00FFFFFF)
  ImageAni:SetEndColor(UI_color.C_00FFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(0, 0.35, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_00FFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_00FFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(0, 0.45, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_00FFFFFF)
  knowDescAni:SetEndColor(UI_color.C_00FFFFFF)
  knowDescAni.IsChangeChild = true
  local ImageAni = _knowledge_Image:addColorAnimation(0.25, 0.85, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_00FFFFFF)
  ImageAni:SetEndColor(UI_color.C_FFFFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(0.35, 0.95, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_00FFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_FFFFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(0.45, 1.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_00FFFFFF)
  knowDescAni:SetEndColor(UI_color.C_FFFFFFFF)
  knowDescAni.IsChangeChild = true
  local ImageAni = _knowledge_Image:addColorAnimation(7, 7.65, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_FFFFFFFF)
  ImageAni:SetEndColor(UI_color.C_00FFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(7, 7.75, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_FFFFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_00FFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(7, 7.85, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_FFFFFFFF)
  knowDescAni:SetEndColor(UI_color.C_00FFFFFF)
  knowDescAni.IsChangeChild = true
end
local function LoadingPanel_GetRandomKnowledge()
  local mentalCardData = RequestIntimacy_getRandomKnowledge()
  if nil ~= mentalCardData then
    _knowledge_Image:SetShow(true, false)
    _knowledge_title:SetShow(true, false)
    _knowledge_desc:SetShow(true, false)
    local screenX = getScreenSizeX()
    _knowledge_Image:ChangeTextureInfoName(mentalCardData:getPicture())
    _knowledge_title:SetText(mentalCardData:getName())
    _knowLedge_TitleSizeX = _knowledge_title:GetTextSizeX()
    _knowledge_desc:SetTextMode(UI_TM.eTextMode_AutoWrap)
    _knowledge_desc:SetText(mentalCardData:getDesc())
    LoadingPanel_PlayKnowledgeAni()
  end
end
local function LoadingPanel_GetBackGroundImage()
  if isBgOpen then
    local loadingImageIndex = math.random(0, bgImageTexture.count - 1)
    loadingImageIndex = (loadingImageIndex + 1) % bgImageTexture.count
    backGroundEvnetImage:ChangeTextureInfoName(bgImageTexture[loadingImageIndex])
  end
end
local updateTime = 0
local isScope = false
function LoadingPanel_UpdatePerFrame(deltaTime)
  _currentTime = _currentTime + deltaTime
  updateTime = updateTime - deltaTime
  if _currentTime > 8 then
    _currentTime = 0
    LoadingPanel_GetRandomKnowledge()
  end
end
registerEvent("EventMapLoadProgress", "LoadingPanel_SetProgress")
registerEvent("onScreenResize", "LoadingPanel_Resize")
Panel_Loading:RegisterUpdateFunc("LoadingPanel_UpdatePerFrame")
LoadingPanel_Resize()
LoadingPanel_GetBackGroundImage()
