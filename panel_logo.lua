Panel_Logo:SetShow(true, false)
Panel_Logo:SetSize(getScreenSizeX(), getScreenSizeY())
local static_PearlAbyss = UI.getChildControl(Panel_Logo, "Static_Pearl")
local static_Daum = UI.getChildControl(Panel_Logo, "Static_Daum")
local static_Grade = UI.getChildControl(Panel_Logo, "Static_Grade")
local staticText_Warning = UI.getChildControl(Panel_Logo, "MultilineText_Warning")
local static_Movie
local setDivisionTime = 6
if isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
  setDivisionTime = 14.5
else
  setDivisionTime = 6
end
function Panel_Logo_Init()
  static_Daum:SetShow(true)
  if isGameTypeKorea() then
    static_Grade:SetSize(311, 121)
    static_Grade:ChangeTextureInfoName("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 311, 121)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Daum:SetShow(true)
  elseif isGameTypeEnglish() then
    static_Grade:SetSize(317, 122)
    static_Grade:ChangeTextureInfoName("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 317, 122)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Grade:SetShow(true)
    staticText_Warning:SetShow(false)
  elseif isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
    static_Grade:SetSize(130, 129)
    static_Grade:ChangeTextureInfoName("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 130, 129)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Daum:SetShow(false)
  elseif isGameTypeSA() then
    static_Daum:SetSize(1024, 302)
    static_Daum:ChangeTextureInfoName("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 1024, 302)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    staticText_Warning:SetShow(false)
    static_Grade:SetShow(false)
  elseif isGameTypeRussia() then
    static_Daum:SetSize(600, 300)
    static_Daum:ChangeTextureInfoName("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 600, 300)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    staticText_Warning:SetShow(false)
    static_Grade:SetShow(false)
  elseif isGameTypeKR2() then
    static_Daum:SetSize(406, 248)
    static_Daum:ChangeTextureInfoName("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 406, 248)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    static_Grade:SetShow(false)
  elseif isGameTypeJapan() then
    static_Daum:SetSize(688, 323)
    static_Daum:ChangeTextureInfoName("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 688, 323)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
  else
    static_Grade:SetSize(311, 121)
    static_Grade:ChangeTextureInfoName("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 311, 121)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
  end
  if isGameTypeKorea() then
    local isAdult = ToClient_IsAdultLogin()
    if isAdult then
      staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE"))
    else
      staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE_15"))
    end
  elseif isGameTypeTaiwan() then
    staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE_TW"))
  elseif isGameTypeKR2() then
    staticText_Warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BDOKR2_A"))
  else
    staticText_Warning:SetText("")
  end
  static_PearlAbyss:SetShow(false)
end
Panel_Logo_Init()
Panel_Logo:ComputePos()
static_PearlAbyss:ComputePos()
static_Daum:ComputePos()
static_Grade:ComputePos()
staticText_Warning:ComputePos()
static_Daum:SetAlpha(0)
static_Grade:SetAlpha(0)
staticText_Warning:SetFontAlpha(0)
local startAniTime = 6
if isGameTypeKorea() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 6, startAniTime + 9, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 6, startAniTime + 9, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
elseif isGameTypeEnglish() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 6, startAniTime + 9, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
elseif isGameTypeTaiwan() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = static_Grade:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
elseif isGameTypeKR2() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 8, startAniTime + 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 13, startAniTime + 15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
elseif isGameTypeTR() or isGameTypeTH() or isGameTypeID() then
else
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
end
local updateTime = 0
function Panel_Logo_Update()
  static_Movie = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_Logo, "WebControl_Movie")
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  static_Movie:SetIgnore(true)
  static_Movie:SetPosX(-8)
  static_Movie:SetPosY(-8)
  static_Movie:SetSize(sizeX + 34, sizeY + 19)
  local soundEnabled = getEnableSound(2)
  if true == soundEnabled then
    static_Movie:SetUrl(1920, 1080, "coui://UI_Movie/CI_Play.html", false, true)
  else
    static_Movie:SetUrl(1920, 1080, "coui://UI_Movie/CI_Play_NoSound.html", false, true)
  end
end
function Panel_Logo_Pause(deltaTime)
  updateTime = updateTime + deltaTime
  if setDivisionTime < updateTime then
    static_Movie:ResetUrl()
    static_Movie:SetShow(false)
  end
end
Panel_Logo_Update()
Panel_Logo:RegisterUpdateFunc("Panel_Logo_Pause")
